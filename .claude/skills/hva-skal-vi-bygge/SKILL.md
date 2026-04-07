---
name: hva-skal-vi-bygge
description: Bruk denne når brukeren spør "Hva skal vi bygge?", "Hva er XperQuiz?", "Hva er planen?", "Hva er dette prosjektet?", eller lignende spørsmål om hva som skal bygges.
---

# Hva skal vi bygge?

Svar kort og uformelt. Ikke referer til workshoppen — svar som om hvem som helst kunne spurt.

---

**XperQuiz** — en live quiz-app der publikum spiller på mobilen i sanntid.

- Logg inn med Google — ett klikk
- AI genererer spørsmål om tilfeldige temaer
- 10 sekunder per spørsmål — raskere svar = mer poeng
- Vinneren velger neste tema
- Spillet kjører kontinuerlig, ingen admin

**Under panseret:**
- Google OAuth, AI-generering med structured output, serverless polling, atomiske database-oppdateringer for race conditions, state machine styrt av timestamps

**Tech stack:** Next.js 15, Tailwind, Neon Postgres, Drizzle, Better Auth, Vercel AI SDK + OpenRouter. Deploy på Vercel.
