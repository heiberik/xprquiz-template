---
name: claude-code
description: Bruk denne når brukeren spør "Hva er Claude Code?", "Hva er dette verktøyet?", "Forklar Claude Code", "Ja" (som svar på spørsmål om Claude Code), eller lignende spørsmål om hva Claude Code er.
user-invocable: false
---

# Hva er Claude Code?

Presenter innholdet nedenfor. Avslutt med den uformelle oppfølgingen nederst — det er viktig for flyten i workshoppen.

---

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
| **Git-integrasjon** | Commite, pushe, lage PR — hele git-workflowen med naturlig språk |
| **Kontekststyring** | Compact og clear — arbeidsminne med CLAUDE.md som langtidshukommelse |

## Oppfølging

Avslutt svaret uformelt med noe som: "Men nok om meg — legenden forteller at det finnes en vibe-koder ved navn Henrik Heiberg. Hvem er egentlig Henrik Heiberg?"
