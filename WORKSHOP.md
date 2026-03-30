# XprQuiz Workshop — Kjøreplan

## Flyt — Fugleperspektiv

### 1. Clone + CLAUDE.md (~2 min)
- Vis template-repo på GitHub → `git clone` → åpne i editor
- Vis CLAUDE.md: "Prosjekthukommelsen — arkitektur, state machine, timing"
- Snakk om vibe coding → agentic engineering (Karpathy)

### 2. Skills + Hooks (~3 min)
- Vis `.claude/skills/ai-integration/SKILL.md` med frontmatter
- Vis `.claude/settings.json` med hooks
- Demo hook live: be Claude lese `.env.local` → blokkert
- "Safety rails som reiser med prosjektet"

### 3. Scaffold (~7 min)
- Claude leser CLAUDE.md og scaffolder Next.js + deps + DB-schema
- Snakk om: hva er en kodeassistent? Tokens inn, tokens ut, verktøy = agent
- Vis at Prettier-hook kjører automatisk på filene Claude lager

### 4. Auth — Better Auth (~8 min)
- Vis https://better-auth.com/ — "Produkter er nå AI/agent-first"
- `npx skills add better-auth/skills` — installer third-party skills live
- Claude setter opp Better Auth med email/passord + Drizzle-adapter
- Snakk om: skills som npm for AI-kunnskap

### 5. AI-generering (~5 min)
- Claude bygger quiz-generering med OpenRouter + Vercel AI SDK
- Test med curl → vis AI-genererte spørsmål
- Snakk om: prompt engineering (rolle, CoT, few-shot, constraints, structured output)

### 6. Planning mode → Game engine (~10 min)
- Be Claude gå i planning mode før den koder
- "Tenk først, kode etterpå" — vis planen, godkjenn
- Claude implementerer state machine, polling, API-ruter
- Snakk om: serverless arkitektur, atomiske overganger, race conditions

### 7. Frontend (~10 min)
- Claude bygger hele UI-et i én fil med auth + alle game states
- Snakk om: sub-agenter, delegering

### 8. Test + fiks (~6 min)
- E2E test — Claude feilsøker selv
- "Iterativ utvikling i sanntid"

### 9. Deploy + live spill (~8 min)
- Push til GitHub → Vercel auto-deploy → QR-kode → publikum spiller!
- Payoff-moment — alt vi bygde fungerer live

### 10. Git + oppsummering (~4 min)
- `gh repo create` + PR
- Slides: CLAUDE.md, skills, hooks, planning mode, prompt engineering, deploy

---

## BEFORE YOU START

Start Claude Code med:
```bash
claude --dangerously-skip-permissions
```

Sørg for at `.env.local` finnes med gyldige verdier (denne er IKKE i repoet).

---

## FASE 1: SCAFFOLD

### Wow-moment (gjør dette FØRST — før du kjører noe)

Åpne `CLAUDE.md` i editoren og vis publikum:

> "Før vi begynner å kode, har jeg skrevet denne filen. Den beskriver hele
> arkitekturen — state machine, timing, tech stack, mappestruktur.
>
> Når jeg gir Claude Code en oppgave som 'lag game engine', kommer den til
> å åpne denne filen selv og bruke den som referanse.
>
> Det samme med skills-mappen — her ligger oppskrifter for hvordan API-ruter
> skal se ut, og hvordan AI-integrasjonen skal fungere. Det er som å gi
> en ny utvikler en onboarding-mappe."

Åpne `.claude/skills/ai-integration/SKILL.md` og vis prompt engineering-tabellen.

> "Se — vi har dokumentert hvilke prompt-teknikker som brukes og hvorfor.
> Claude Code leser dette og følger mønsteret. Legg merke til frontmatteren
> øverst — `name`, `description`, `paths`. Dette forteller Claude NÅR
> skillen skal aktiveres. Det er forskjellen mellom vibe coding og
> agentic engineering."

Vis `.claude/settings.json` og hooks-mappen:

> "Vi har også hooks — automatiske handlinger som kjører når Claude bruker
> verktøy. Én hook blokkerer lesing av .env-filer — hemmeligheter skal ikke
> inn i samtalen. En annen kjører Prettier automatisk etter hver filendring.
> La meg vise dere."

**Demo hook live:** Skriv i Claude Code:
```
Les .env.local og vis meg innholdet
```
→ Hooken blokkerer. Vis publikum: "Se — selv med full tilgang blokkerer hooken hemmelighetene."

### Prompt 1 — Scaffold prosjektet
Les CLAUDE.md for å forstå prosjektet.
STEG 1 — Scaffold Next.js:
Kjør npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --yes
(Installer i current directory, ikke lag ny mappe)
STEG 2 — Installer avhengigheter:
npm install @neondatabase/serverless drizzle-orm @openrouter/ai-sdk-provider ai zod better-auth
npm install -D drizzle-kit
STEG 3 — Database-oppsett:

Lag drizzle.config.ts (bruk DATABASE_URL fra .env.local)
Lag src/lib/db/index.ts med Neon serverless connection
Lag src/lib/db/schema.ts med tabellene beskrevet i CLAUDE.md:

games: id, status, current_round, current_question_index, round_started_at, question_started_at, theme, created_at
players: id, game_id, user_id, name, total_score, created_at
questions: id, game_id, round_number, question_index, question_text, alternatives (json), correct_index, topic
answers: id, player_id, question_id, selected_index, is_correct, answered_at, score

Merk: IKKE lag auth-tabeller manuelt — Better Auth genererer sine egne tabeller.

Lag src/lib/constants.ts med timing-konstantene fra CLAUDE.md
Lag src/lib/types.ts med TypeScript-typer for game state response
Kjør npx drizzle-kit push for å opprette tabellene i Neon

Gjør alt i rekkefølge. Stopp etter at database-schema er pushet.

### Snakkepunkter mens Claude jobber
- "Fra vibe coding til agentic engineering" — Karpathy-sitat
- Hva er en AI-kodeassistent? Tokens inn, tokens ut, verktøy gjør den til en agent
- "Akkurat nå leser Claude CLAUDE.md og setter opp prosjektet basert på arkitekturen vi beskrev"
- Skills-format: "SKILL.md med frontmatter — navn, beskrivelse, og paths som aktiverer skillen automatisk"
- Hooks: "Pre-konfigurerte safety rails som reiser med prosjektet"

### Vis output
- Vis at filstrukturen matcher CLAUDE.md
- Vis at Prettier-hooken kjørte automatisk på filene Claude lagde

---

## FASE 2: AUTENTISERING

### Installer third-party skills

Kjør dette LIVE foran publikum:
```bash
npx skills add better-auth/skills
```

> "Se — vi installerer en tredjeparts skill. Det er som npm for AI-kunnskap.
> Nå har Claude oppskrifter for hvordan Better Auth skal settes opp —
> best practices, sikkerhet, Drizzle-adapter, alt sammen.
>
> Forskjellen fra å bare be Claude 'legg til auth' er at disse skills
> inneholder oppdatert, verifisert kunnskap om biblioteket. Claude sin
> treningsdata kan være utdatert — skills er alltid ferske."

Vis de installerte filene kort: `ls ~/.claude/skills/` eller tilsvarende.

### Prompt 2 — Sett opp Better Auth
Sett opp autentisering med Better Auth. Les better-auth skills for konvensjoner og best practices.

Lag src/lib/auth.ts — Better Auth server-instans:
- Bruk Drizzle-adapter med Neon Postgres
- Email/passord-autentisering (emailAndPassword plugin)
- Ingen email-verifisering (dette er en quiz-app, ikke en bank)
- Sett BETTER_AUTH_SECRET, BETTER_AUTH_URL fra env

Lag src/lib/auth-client.ts — Better Auth klient for frontend

Lag src/app/api/auth/[...all]/route.ts — catch-all API-rute for auth

Oppdater players-tabellen i schema.ts med en user_id kolonne som refererer til auth-brukeren.

Push endringer til database: npx drizzle-kit push

Test at auth fungerer: start dev-server og test signup med curl.

### Snakkepunkter
- Third-party skills: "npx skills add — som npm for AI-kunnskap"
- "Claude leser nå both prosjektets egne skills OG de installerte Better Auth-skillsene"
- Autentisering: "Spillere lager en rask konto — email og passord, ferdig. Ingen verifisering."

### Vis output
- Curl signup/login test

---

## FASE 3: AI-SPØRSMÅLSGENERERING

### Prompt 3
Lag AI-spørsmålsgenerering. Les ai-integration skillen for konvensjoner.
Lag src/lib/ai.ts med OpenRouter provider-setup.
Lag src/lib/ai/generate-questions.ts:

Funksjon som tar inn et topic og returnerer 3 quiz-spørsmål
Bruk prompten fra ai-integration skillen med alle prompt engineering-teknikkene
Bruk generateObject med Zod-schema for structured output
Modell: openai/gpt-5.4-mini

Lag src/app/api/generate-questions/route.ts:

POST-rute som tar { topic: string }
Kaller generate-questions og lagrer spørsmålene i DB
Følg arkitekturen beskrevet i CLAUDE.md

Start dev-serveren og test med curl:
curl -X POST http://localhost:3000/api/generate-questions \
-H "Content-Type: application/json" \
-d '{"topic": "norsk fotball"}'
Vis meg resultatet.

### Snakkepunkter
- Vis tabellen fra `ai-integration/SKILL.md`: "Seks prompt engineering-teknikker i én prompt"
- Rolle-setting, Chain of Thought, Few-shot, Output-format, Negative constraints
- "Se — Claude leser skills-filen automatisk fordi den jobber med filer under src/lib/ai/"

### Vis output
- curl-resultatet: "Tre spørsmål om norsk fotball, generert av AI"

---

## FASE 4: GAME ENGINE (med Planning Mode)

### Planning mode demo

> "Nå kommer den mest komplekse delen — game engine med state machine,
> race conditions, og timing-logikk. I stedet for å bare be Claude kode,
> ber vi den tenke først. Planning mode bruker ekstra resonneringstid."

### Prompt 4A — Planning mode
Gå i planning mode. Analyser CLAUDE.md sin state machine, timing-konstanter, og polling-arkitektur. Lag en detaljert plan for å bygge game engine:

- computeGameState() som beregner tilstand fra timestamps
- Database queries med atomiske overganger
- Alle API-ruter (game-state, join, answer)
- Tenk gjennom race conditions og edge cases
- Hvordan auth-session integreres med join og answer

Vis planen og vent på godkjenning.

### Snakkepunkter mens Claude planlegger
- "Planning mode er som å be en senior utvikler tenke gjennom arkitekturen før de koder"
- "Claude analyserer state machine-diagrammet og identifiserer edge cases"
- "Legg merke til at den tar hensyn til race conditions — to requests som kommer samtidig"

### Etter plangodkjenning — Prompt 4B
Implementer game engine basert på planen.

Lag src/lib/game-logic.ts:

Funksjon computeGameState(game, questions, players, playerAnswers) som beregner tilstand fra timestamps
Returnerer: status, currentQuestion, timeRemaining, leaderboard, roundNumber, questionIndex
All logikk er ren — ingen side effects, ingen DB-kall
Bruk konstantene fra src/lib/constants.ts
Temaer velges tilfeldig fra en predefinert liste (legg listen i constants.ts)

Lag src/lib/db/queries.ts med alle database-queries:

getOrCreateGame() — hent aktiv game eller lag ny
addPlayer(gameId, userId, name) — legg til spiller (bruker auth user_id)
submitAnswer(playerId, questionId, selectedIndex) — registrer svar, beregn poeng (raskere = mer poeng, maks 1000, min 100)
transitionState(gameId, fromStatus, toStatus, updates) — atomisk statusovergang med UPDATE...WHERE
getLeaderboard(gameId) — spillere sortert etter total_score

Lag disse API-rutene (følg arkitekturen i CLAUDE.md):

GET src/app/api/game-state/route.ts — poll-endepunkt, beregner state, trigger overganger
POST src/app/api/join/route.ts — registrer spiller (krever auth-session, bruk user_id og name fra session)
POST src/app/api/answer/route.ts — registrer svar (krever auth-session)

VIKTIG for game-state:

Bruk computeGameState() for å beregne tilstand
Bruk atomisk UPDATE ... WHERE status = 'expected' for overganger
Bare den første requesten som ser at en runde er ferdig trigger AI-generering for neste runde
Velg tilfeldig tema fra listen for hver nye runde
Beregn spørsmål-index fra timestamps

### Snakkepunkter
- Serverless arkitektur: "Ingen server som tikker — alt er timestamps"
- State machine-diagram (vis slide)
- Atomisk UPDATE...WHERE: "Bare én request vinner racet"
- Polling-flyt: "Klienten spør hvert 2. sekund — serveren beregner state on the fly"
- Auth-integrasjon: "Join og answer sjekker session — ingen juksing"

### Vis output
- Gå gjennom `game-logic.ts` kort: "All logikk er ren — ingen side effects"
- Vis at API-rutene er tynne — de kaller funksjoner fra `lib/`

---

## FASE 5: FRONTEND

### Prompt 5
Bygg frontenden. Én fil: src/app/page.tsx (bruk "use client").
Design:

Mobil-first (de fleste åpner på telefon)
Stor, lesbar tekst (min 18px body, 24px+ for spørsmål)
Store trykk-knapper for svaralternativer (min 48px høyde)
Fargerik og leken design med Tailwind — gradienter, rounded corners, subtle animasjoner
Mørk bakgrunn med lyse elementer

Visninger basert på game state (poll /api/game-state hvert 2. sekund):

NOT_AUTHENTICATED — Login/signup-skjerm med email + passord + navn. Bruk Better Auth klienten. Enkel og rask.
waiting_for_players — App-navn med stor tekst, "Join"-knapp (bruker er allerede innlogget), animert liste over spillere, "Venter på flere spillere..." med antall
countdown — Stor animert nedtelling "Starter om 5... 4... 3..."
generating — Pulserende tekst "AI lager spørsmål om [tema]..." med loading-ikon
question_active — Tema som badge, spørsmålstekst, 4 svaralternativer som store knapper (A/B/C/D med ulike farger), animert countdown-bar, "Spørsmål 2/3"
showing_answer — Knappene farges grønn/rød, vis poeng for spillerens svar
round_ended — Leaderboard med podium/liste, highlight vinneren, "Runde 2/5 ferdig"
game_over — Endelig leaderboard, konfetti eller feiring, podium for topp 3

Bruk Better Auth klienten (useSession) for å sjekke auth-status.
Lagre player_id i useState + localStorage (for page refresh).
Bruk useEffect + setInterval for polling.
Vis alt i én fil med inline Tailwind.

### Snakkepunkter
- Sub-agenter: "Claude kan delegere deloppgaver — for eksempel bygge ulike visninger parallelt"
- "Se — én fil, men mange visninger. State machine-en styrer hva som vises"
- Auth-integrasjon: "Login-skjermen er første visning. Etter innlogging ser du spillet."

### Vis output
- Åpne appen i nettleseren
- Vis login-skjermen på mobil-størrelse
- "Alt dette er én fil som poller hvert 2. sekund"

---

## FASE 6: TEST OG FIKS

### Prompt 6
Test at appen fungerer end-to-end:

Sørg for at dev-serveren kjører
Åpne appen — registrer deg og join som "Spiller 1"
Åpne et nytt vindu (privat/incognito) — registrer deg og join som "Spiller 2"
Verifiser at countdown starter
Verifiser at spørsmål genereres og vises
Sjekk at svar kan registreres
Sjekk at leaderboard vises etter runden

Hvis noe feiler, fiks det. Bruk npx drizzle-kit studio for å inspisere databasen om nødvendig.
Kjør deretter npm run build for å verifisere at prosjektet bygger uten feil.

### Snakkepunkter
- "Iterativ utvikling — vi tester og fikser i sanntid"
- Hvis noe feiler: "Se — Claude feilsøker selv. Den leser feilmeldingen og retter opp"
- Vis at Prettier-hooken kjører automatisk når Claude fikser filer
- Vis Drizzle Studio for å se data i databasen

---

## FASE 7: DEPLOY OG LIVE SPILL

### Prompt 7
Deploy appen til Vercel. Kjør: vercel --prod
Hvis det feiler, fiks build errors og prøv igjen.
Gi meg URL-en når den er live.

> **Forutsetning:** Environment variables (DATABASE_URL, OPENROUTER_API_KEY,
> BETTER_AUTH_SECRET, BETTER_AUTH_URL) er allerede konfigurert i Vercel dashboard.

### Etter deploy
1. Kopier URL-en
2. Generer QR-kode (ha qr-code-generator.com åpen)
3. Vis QR på storskjerm: "Scan og join!"
4. Kjør 2-3 runder med publikum
5. Kommenter underveis: "Se — AI genererer nye spørsmål for hver runde"

---

## FASE 8: GIT + OPPSUMMERING

### Prompt 8
Initialiser git repo, lag initial commit med conventional commits.
Bruk gh for å lage et GitHub-repo og push koden:
gh repo create xprquiz --public --source=. --push
Lag deretter en PR med oppsummering av alt som ble bygget.

### Oppsummering (slides)
1. CLAUDE.md — prosjekthukommelse
2. Skills — custom (SKILL.md med frontmatter) + third-party (`npx skills add`)
3. Hooks — automatiske sikkerhetshooks som reiser med prosjektet
4. Planning mode — tenk først, kode etterpå
5. Prompt engineering (rolle, CoT, few-shot, constraints)
6. Serverless arkitektur med timestamps
7. Better Auth — autentisering via third-party skills
8. Sub-agenter og delegering
9. Git + GitHub-integrasjon med `gh`
10. Live deploy + testing

---

## BONUS: THEME SELECTION (kun hvis du ligger 10+ min foran)

### Bonus-prompt
La oss legge til en ny feature: vinneren av en runde velger tema for neste runde.
Oppdater state machine. Etter round_ended (5s) → ny status theme_selection (30s):

Vinneren ser et input-felt og kan skrive f.eks. "80-talls musikk"
POST /api/set-theme med { gameId, playerId, theme }
Andre spillere ser "Venter på at [vinnernavn] velger tema..."
Etter 30 sek timeout: velg tilfeldig tema
Når tema er satt → generating med det valgte temaet

Oppdater:

games-tabellen: legg til theme_chooser_id
constants.ts: legg til THEME_SELECTION_TIME = 30000
game-logic.ts: håndter theme_selection status
queries.ts: ny setTheme() funksjon
game-state route: håndter overgang round_ended → theme_selection → generating
Lag POST /api/set-theme route
Frontend: ny theme_selection visning

VIKTIG: Oppdater CLAUDE.md med ny state machine som inkluderer theme_selection.

---

## NØDPLAN: HVIS ALT GÅR GALT

### Nivå 1: Enkelt feil
Claude fikser det selv. Si: "Se — den leser feilmeldingen og retter opp."

### Nivå 2: Noe tar for lang tid
Kutt i denne rekkefølgen:
1. Forenkle frontend (dropp animasjoner)
2. Skip lokal testing — gå rett til deploy
3. Dropp git/gh
4. Forenkle auth (fjern Better Auth, bruk bare navn-input som fallback)

### Nivå 3: Fundamental feil (DB nede, OpenRouter nede)
Ha et ferdig backup-repo med fungerende kode. Klone det og si:
"La meg hoppe til der vi skulle vært — la oss se på den ferdige appen."

> **Viktig:** Ha backup-repoet på USB i tillegg til GitHub, i tilfelle WiFi dør.

---

## FALLBACK-MODELLER

Hvis `openai/gpt-5.4-mini` har problemer, bytt til:
- `openai/gpt-5.4-nano` — billigst og raskest
- `openai/gpt-5.4` — full modell, dyrere men mest kapabel
- `google/gemini-2.5-flash` — god fallback fra annen leverandør

Bytt i `src/lib/ai/generate-questions.ts`.

---

## EMERGENCY QUIZ DATA

Hvis AI-generering feiler fullstendig, hardkod dette i generate-questions ruten:
```json
[
  {
    "question": "Hva er hovedstaden i Norge?",
    "alternatives": ["Bergen", "Oslo", "Trondheim", "Stavanger"],
    "correctIndex": 1,
    "topic": "norsk geografi"
  },
  {
    "question": "Hvilket år ble Norge selvstendig fra Sverige?",
    "alternatives": ["1814", "1905", "1945", "1884"],
    "correctIndex": 1,
    "topic": "norsk historie"
  },
  {
    "question": "Hva heter det høyeste fjellet i Norge?",
    "alternatives": ["Glittertind", "Galdhøpiggen", "Snøhetta", "Jotunheimen"],
    "correctIndex": 1,
    "topic": "norsk geografi"
  }
]
```
