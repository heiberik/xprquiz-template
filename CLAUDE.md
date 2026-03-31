# XprQuiz

Live quiz-app der publikum spiller på mobilen i sanntid. AI genererer spørsmål basert på tilfeldige temaer.

## Tech Stack

- **Framework:** Next.js 15 (App Router, TypeScript, src/)
- **Styling:** Tailwind CSS 4
- **Database:** Neon Postgres (`@neondatabase/serverless`)
- **ORM:** Drizzle ORM
- **Auth:** Better Auth (`better-auth`) med email/passord
- **AI:** Vercel AI SDK med OpenRouter (`@openrouter/ai-sdk-provider`)
- **Deploy:** Vercel

## Arkitektur

Serverless-kompatibel. All game state lagres i Postgres med timestamps — ingen server som tikker.

- Klienter poller `GET /api/game-state` hvert 2. sekund
- Game state beregnes fra timestamps ved hver request (ingen cron jobs)
- Poll-requests driver spillet fremover: hvis beregnet state viser at tiden er ute, trigger requesten selv overgangen
- Atomiske `UPDATE ... WHERE status = 'expected'` for å unngå race conditions — `rowCount === 0` betyr at en annen request allerede tok overgangen, gjør ingenting
- `countdown → generating` og `round_ended → generating` trigger AI-spørsmålsgenerering — kun requesten som vinner den atomiske overgangen starter genereringen
- `correctIndex` sendes ALDRI til klienten under `question_active` — kun under `showing_answer`
- Scoring: raskere svar = mer poeng. Maks 1000, min 100, lineær interpolering basert på tid brukt
- Én enkelt side (`src/app/page.tsx`) med ulike visninger basert på game state
- Temaer velges tilfeldig fra en predefinert liste

## Autentisering

Spillere må logge inn for å spille. Better Auth håndterer autentisering:

- **Metode:** Google OAuth ("Logg inn med Google") + email/passord som fallback
- **Adapter:** Drizzle med Neon Postgres
- **Config:** `src/lib/auth.ts` — Better Auth server-instans
- **API-rute:** `src/app/api/auth/[...all]/route.ts` — catch-all for auth-endepunkter
- **Klient:** `src/lib/auth-client.ts` — Better Auth klient for frontend
- Player-tabellen har en `user_id`-kolonne som lenker til auth-brukeren
- Join- og answer-endepunkter krever gyldig session
- Spillernavn hentes fra auth-brukerens `name`-felt ved registrering

## State Machine
waiting_for_players
→ countdown (5s)                    [triggers ved 2+ spillere]
→ generating                      [AI lager 3 spørsmål]
→ question_active (15s)         [spørsmål 1]
→ showing_answer (4s)
→ question_active (15s)     [spørsmål 2]
→ showing_answer (4s)
→ question_active (15s) [spørsmål 3]
→ showing_answer (4s)
→ round_ended (5s)  [vis leaderboard]
→ generating      [neste runde, nytt tema]
→ ...
→ game_over   [etter 5 runder]

Spillet starter automatisk når 2+ spillere har joinet.
Hvert spørsmål varer 15 sekunder. Etter siste svar vises riktig svar i 4 sekunder.
Hver runde har 3 spørsmål. Etter 5 runder er spillet over.

Spillere må være innlogget for å se `waiting_for_players`-skjermen og joine.

## Timing-konstanter

Alle timing-verdier skal ligge i `src/lib/constants.ts`:

| Konstant | Verdi | Beskrivelse |
|---|---|---|
| COUNTDOWN_TIME | 5000 | Nedtelling før runde starter (ms) |
| QUESTION_TIME | 15000 | Tid per spørsmål (ms) |
| SHOW_ANSWER_TIME | 4000 | Vis riktig svar (ms) |
| ROUND_END_TIME | 5000 | Vis leaderboard mellom runder (ms) |
| POLL_INTERVAL | 2000 | Klient-polling intervall (ms) |
| QUESTIONS_PER_ROUND | 3 | Antall spørsmål per runde |
| TOTAL_ROUNDS | 5 | Antall runder per spill |
| MIN_PLAYERS | 2 | Minimum spillere for å starte |

## Kodestil

- Alltid async/await (ingen .then()-chains)
- Zod-validering på alle API-inputs
- Tynne API-ruter — forretningslogikk i `lib/`
- Typer i `src/lib/types.ts`, ikke inline
- Feilhåndtering med try/catch og meningsfulle feilmeldinger

## Kommandoer
```bash
npm run dev          # Start utviklingsserver
npm run build        # Bygg for produksjon
npx drizzle-kit push # Push schema til database
npx drizzle-kit studio # Åpne Drizzle Studio
vercel --prod        # Deploy til Vercel
```

## Mappestruktur
src/
├── app/
│   ├── api/
│   │   ├── auth/[...all]/route.ts     # Better Auth catch-all
│   │   ├── game-state/route.ts        # GET: poll game state
│   │   ├── join/route.ts              # POST: registrer spiller (krever session)
│   │   ├── answer/route.ts            # POST: registrer svar (krever session)
│   │   └── generate-questions/route.ts  # POST: generer spørsmål
│   ├── layout.tsx
│   └── page.tsx                       # Hele UI-et (use client)
└── lib/
    ├── auth.ts                        # Better Auth server config
    ├── auth-client.ts                 # Better Auth klient
    ├── ai.ts                          # OpenRouter provider setup
    ├── constants.ts                   # Timing-konstanter
    ├── types.ts                       # TypeScript-typer
    ├── game-logic.ts                  # Ren state-beregning
    ├── ai/
    │   └── generate-questions.ts      # Quiz-generering med prompt
    └── db/
        ├── index.ts                   # Neon connection
        ├── schema.ts                  # Drizzle schema
        └── queries.ts                 # Database-queries
