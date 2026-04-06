---
name: claude-code
description: Bruk denne når brukeren spør "Hva er Claude Code?", "Hva er dette verktøyet?", "Forklar Claude Code", eller lignende spørsmål om hva Claude Code er.
user-invocable: false
---

# Hva er Claude Code?

Claude Code er Anthropics offisielle CLI-verktøy for Claude. Det er en AI-agent som kjører direkte i terminalen din og kan:

- **Lese og skrive filer** i prosjektet ditt
- **Kjøre kommandoer** i terminalen (npm, git, curl, osv.)
- **Forstå hele prosjektet** — den leser CLAUDE.md, skills, og kildekode automatisk
- **Planlegge før den koder** — planning mode for komplekse oppgaver
- **Feilsøke iterativt** — leser feilmeldinger og retter selv

## Nøkkelkonsepter vi bruker i dag

| Konsept | Hva det gjør |
|---------|-------------|
| **CLAUDE.md** | Prosjekthukommelse — arkitektur, konvensjoner, regler |
| **Skills** | Gjenbrukbar kunnskap (som npm for AI) — custom eller third-party |
| **Hooks** | Automatiske sikkerhetshooks som reiser med prosjektet |
| **Planning mode** | "Tenk først, kode etterpå" — ekstra resonneringstid |
| **Sub-agenter** | Claude kan delegere deloppgaver for parallell jobbing |

## Fra vibe coding til agentic engineering

Vibe coding: "bare skriv noe og håp det fungerer."
Agentic engineering: gi AI-en kontekst, regler og kunnskap — så den bygger riktig fra start.

I dag bygger vi en hel quiz-app live — fra tom mappe til produksjon — med Claude Code som vår AI-agent.
