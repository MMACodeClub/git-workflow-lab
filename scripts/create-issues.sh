#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "Fehler: GitHub CLI (gh) ist nicht installiert." >&2
  exit 1
fi

gh auth status >/dev/null

gh label create workshop --color D4A72C --description "Aufgabe im Git Workflow Lab" --force
gh label create round-1 --color 2D7045 --description "Konfliktfreier Feature-Workflow" --force

for number in $(seq -w 1 10); do
  file="src/profiles/profile-${number}.js"
  title="Runde 1: Profil von Person ${number} ergänzen"
  body="## Aufgabe

Bearbeite ausschliesslich \`${file}\` gemäss deiner Karte in \`docs/AUFGABEN.md\`.

## Akzeptanzkriterien

- [ ] Eigener Name eingetragen
- [ ] Konkrete Stärke eingetragen
- [ ] \`ready: true\` gesetzt
- [ ] \`npm test\` erfolgreich
- [ ] Pull Request durch Tandem-Person reviewed

Der Pull Request muss dieses Issue mit \`Closes #...\` verknüpfen."

  gh issue create --title "$title" --body "$body" --label workshop --label round-1
done

echo "Zehn Workshop-Issues wurden erstellt. Bitte jetzt den Personen zuweisen."

