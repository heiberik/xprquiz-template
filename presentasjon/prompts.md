# Prompts

## Orkestrator-prompt

Vi skal implementere appen vår. Les CLAUDE.md — den er kilden til sannhet.

Jeg vil at du skal orkestrere implementasjonen. Ikke skriv kode selv.

Tenk steg for steg:
1. Hvilke deler må bygges?
2. Hva avhenger av hva?
3. Hva kan kjøres i parallell?

Lag en overordnet 5-stegs plan. For eksempel:
- Steg 1: Prosjektoppsett (dependencies, schema, typer)
- Steg 2: Auth (bruk Better Auth MCP-serveren for oppslag)
- Steg 3 og 4: to uavhengige backend-deler som kan kjøres parallelt
- Steg 5: Frontend

Viktig for steg-promptene du genererer:
- Steg-promptene skal ALDRI motsi reglene i CLAUDE.md eller .claude/rules/. Hvis du er usikker, referer til CLAUDE.md fremfor å gi egne tekniske instruksjoner.
- Ikke inkluder implementasjonsdetaljer som kodestil, feilhåndtering eller async-mønstre — det er allerede dekket av CLAUDE.md og rules.

Ikke gi meg implementasjonsdetaljer ennå — bare den overordnede planen.
