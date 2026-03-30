# XprQuiz — Workshop Template

Template-repo for live-koding av XprQuiz med Claude Code.

## Hvordan bruke dette repoet

1. Fork dette repoet (eller klon og slett `.git`)
2. Kopier `.env.example` til `.env.local` og fyll inn verdier
3. Åpne `WORKSHOP.md` for prompts og kjøreplan
4. Start Claude Code: `claude --dangerously-skip-permissions`

## Hva som allerede finnes

- `CLAUDE.md` — Prosjektdokumentasjon som Claude Code leser og følger
- `.claude/skills/` — Oppskrifter for API-ruter og AI-integrasjon (SKILL.md-format med frontmatter)
- `.claude/settings.json` — Pre-konfigurerte hooks (blokkér .env-lesing)
- `.claude/hooks/` — Hook-scripts som kjøres automatisk
- `.env.example` — Template for environment variables

## Hva som bygges live

Alt annet: Next.js-prosjekt, database-schema, Better Auth autentisering, API-ruter, game engine, AI-generering, frontend og deploy til Vercel.

## Claude Code-konsepter som demonstreres

| Konsept | Hvor i workshoppen |
|---------|-------------------|
| CLAUDE.md | Fase 1 — wow-moment |
| Skills (custom) | Fase 1 — vis SKILL.md med frontmatter |
| Skills (third-party) | Fase 2 — `npx skills add better-auth/skills` |
| Hooks | Fase 1 — pre-konfigurert, demo .env-blokkering |
| Planning mode | Fase 4 — før game engine |
| Sub-agenter | Fase 5 — frontend-bygging |
| Git + gh | Fase 8 — repo + PR |

## Pre-flight Checklist

### Dagen før
- [ ] `.env.local` med gyldige `DATABASE_URL` og `OPENROUTER_API_KEY`
- [ ] Vercel: environment variables konfigurert i dashboard
- [ ] OpenRouter: verifiser at modellen fungerer (`curl` test-kall)
- [ ] Neon: database er oppe, connection fungerer
- [ ] `jq` installert (`jq --version`) — kreves for hooks
- [ ] Valgfritt: `npx skills add better-auth/skills` pre-installert
- [ ] Terminal font 18px+
- [ ] Øvd gjennom minst 2 ganger
- [ ] Slides ferdige
- [ ] QR-generator klar i browser-fane (f.eks. qr-code-generator.com)

### Rett før
- [ ] Slett alt utenom template-filer — start med kun CLAUDE.md, skills, hooks, settings.json, .env.local, .gitignore
- [ ] `vercel whoami` fungerer
- [ ] `node -v` viser 20+
- [ ] WiFi fungerer
- [ ] Lukk Slack, mail, notifications
