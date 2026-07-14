#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "Fehler: GitHub CLI (gh) ist nicht installiert." >&2
  exit 1
fi

gh auth status >/dev/null

gh label create workshop --color D4A72C --description "Aufgabe im Git Workflow Lab" --force
gh label create round-1 --color 2D7045 --description "Konfliktfreier Feature-Workflow" --force
gh label create round-2 --color B33A3A --description "Konflikt- und Rebase-Workflow" --force
gh label create reflection --color 6B4BA1 --description "Gemeinsamer Workshop-Abschluss" --force

existing_titles="$(gh issue list --state all --limit 100 --json title --jq '.[].title')"

create_issue() {
  local title="$1"
  local body="$2"
  shift 2

  if grep -Fqx "$title" <<< "$existing_titles"; then
    echo "Übersprungen (existiert): $title"
    return
  fi

  local command=(gh issue create --title "$title" --body "$body")
  for label in "$@"; do
    command+=(--label "$label")
  done
  "${command[@]}"
  existing_titles="${existing_titles}"$'\n'"${title}"
}

for number in {01..10}; do
  file="src/profiles/profile-${number}.js"
  title="Runde 1: Profil von Person ${number} ergänzen"
  body="## Aufgabe

Bearbeite ausschliesslich \`${file}\` gemäss deiner Karte in \`docs/AUFGABEN.md\`.

## Akzeptanzkriterien

- [ ] Eigener Name eingetragen
- [ ] Konkrete Stärke eingetragen
- [ ] \`ready: true\` gesetzt
- [ ] \`npm test\` erfolgreich
- [ ] Suggested Change mit Request Changes erhalten und übernommen
- [ ] Aktualisierten Stand erneut prüfen und freigeben lassen

Der Pull Request muss dieses Issue mit \`Closes #...\` verknüpfen."

  create_issue "$title" "$body" workshop round-1
done

create_team_issue() {
  local team="$1"
  local people="$2"
  local topic="$3"
  local first_value="$4"
  local second_value="$5"
  local title="Runde 2: Team ${team} entscheidet ${topic}"
  local body="## Aufgabe

Personen ${people} erstellen vom gleichen Stand zwei konkurrierende Pull Requests. Beide ändern die \`decision\`-Zeile von Team ${team} in \`src/workshop-config.js\`.

## Ausgangswerte

- ungerade Person: \`${first_value}\`
- gerade Person: \`${second_value}\`

## Verknüpfung

- Der erste PR verwendet \`Refs #...\`, damit das Issue offen bleibt.
- Der zweite PR verwendet nach dem Rebase \`Closes #...\`.

## Akzeptanzkriterien

- [ ] Beide PRs vor dem ersten Merge freigegeben
- [ ] PR der ungeraden Person zuerst gemergt
- [ ] Gerade Person auf \`origin/main\` rebased
- [ ] Konflikt fachlich im Tandem gelöst
- [ ] Aktualisierung mit \`git push --force-with-lease\`
- [ ] Verworfenes Approval durch ein neues Review ersetzt
- [ ] \`npm test\` erfolgreich"

  create_issue "$title" "$body" workshop round-2
}

create_team_issue A "01 und 02" "Branch-Namen" "feature/<issue>-<kurztext>" "feat/<issue>-<kurztext>"
create_team_issue B "03 und 04" "Merge-Strategie" "Squash Merge für Feature Pull Requests" "Merge Commit für Feature Pull Requests"
create_team_issue C "05 und 06" "Commit-Stil" "Conventional Commits mit Typ und Imperativ" "Freie Commit-Texte mit Issue-Nummer"
create_team_issue D "07 und 08" "Review-Regel" "Eine Freigabe aus dem eigenen Tandem" "Zwei Freigaben aus anderen Teams"
create_team_issue E "09 und 10" "Branch-Löschung" "Branch nach Merge automatisch löschen" "Branch bis zum Sprintende behalten"

exit_title="Abschluss: Exit-Ticket zum Git Workflow Lab"
exit_body="## Gemeinsame Reflexion

Jede Person beantwortet in einem eigenen Kommentar:

1. Warum ist \`git pull --ff-only\` auf \`main\` hilfreich?
2. Weshalb ist \`--force-with-lease\` sicherer als \`--force\`?
3. Wann braucht ein Konflikt eine fachliche statt nur eine technische Entscheidung?

Das Issue wird geschlossen, sobald alle zehn Kommentare vorhanden sind."
create_issue "$exit_title" "$exit_body" workshop reflection

echo "Workshop-Issues sind vollständig: zehn Einzelaufgaben, fünf Teamaufgaben und ein Exit-Ticket."
