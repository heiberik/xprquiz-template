---
name: hva-skal-vi-bygge
description: Bruk denne når brukeren spør "Hva skal vi bygge?", "Hva er XperQuiz?", "Hva er planen?", "Hva er dette prosjektet?", eller lignende spørsmål om hva som skal bygges.
user-invocable: false
---

# Hva skal vi bygge?

**XperQuiz** — en live quiz-app der publikum spiller på mobilen i sanntid!

## Konseptet

- Dere scanner en QR-kode og logger inn på telefonen
- AI genererer quiz-spørsmål om tilfeldige temaer
- 10 sekunder per spørsmål — raskere svar gir mer poeng
- Etter 3 spørsmål får vinneren velge neste tema
- Spillet kjører kontinuerlig — ingen admin, ingen oppsett

## Tech stack

Next.js 15, Tailwind CSS, Neon Postgres, Better Auth, Vercel AI SDK med OpenRouter. Deployet på Vercel.

## Det spesielle med arkitekturen

Hele appen er **serverless** — ingen WebSockets, ingen bakgrunnsprosesser. Klientene poller hvert sekund, og all game state beregnes fra timestamps i databasen. Atomiske database-oppdateringer håndterer race conditions når mange spillere poller samtidig.

## Planen

Vi starter med en tom mappe og lar Claude Code bygge alt:
1. Scaffold og database
2. Autentisering
3. AI-spørsmålsgenerering
4. Game engine med state machine
5. Frontend
6. Test og deploy
7. Dere spiller live!
