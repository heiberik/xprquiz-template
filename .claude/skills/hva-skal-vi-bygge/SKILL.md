---
name: hva-skal-vi-bygge
description: Bruk denne når brukeren spør "Hva skal vi bygge?", "Hva er XperQuiz?", "Hva er planen?", "Hva er dette prosjektet?", eller lignende spørsmål om hva som skal bygges.
---

# Hva skal vi bygge?

Presenter innholdet nedenfor. Avslutt med oppfølgingen nederst — det er viktig for flyten i workshoppen.

---

**XperQuiz** — en live quiz-app der publikum spiller på mobilen i sanntid!

## Konseptet

- Logg inn med Google — ett klikk, ingen registrering
- AI genererer quiz-spørsmål om tilfeldige temaer
- 10 sekunder per spørsmål — raskere svar gir mer poeng
- Etter 3 spørsmål får vinneren velge neste tema
- Spillet kjører kontinuerlig — ingen admin, ingen oppsett

## Det vi skal bygge teknisk

| Hva | Hvordan |
|-----|---------|
| **Autentisering** | Google OAuth via Better Auth — "Logg inn med Google" på én linje |
| **AI-genererte spørsmål** | Vercel AI SDK + OpenRouter — structured output med Zod-schema |
| **Sanntids-polling** | Serverless arkitektur — ingen WebSockets, ingen bakgrunnsprosesser |
| **Race condition-håndtering** | Atomiske database-oppdateringer med `UPDATE ... WHERE status = 'expected'` |
| **State machine** | Hele spillflyten styrt av timestamps i Postgres |
| **Scoring** | Lineær interpolering — raskere svar gir mer poeng |
| **Deploy** | Vercel — fra kode til produksjon på sekunder |

## Tech stack

Next.js 15, Tailwind CSS, Neon Postgres, Drizzle ORM, Better Auth, Vercel AI SDK med OpenRouter. Deployet på Vercel.

## Oppfølging

Avslutt svaret med noe som: "La oss sette i gang — skal jeg starte med å scaffolde prosjektet?"
