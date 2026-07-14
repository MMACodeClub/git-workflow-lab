# Aufgabenkarten für zehn Personen

Jede Zeile ist eine kompakte Aufgabenkarte. Die exakten Texte in Runde 2 sind bewusst unterschiedlich und erzeugen innerhalb jedes Teams einen Konflikt.

| Person | Team | Runde 1 | Branch in Runde 2 | Wert für `decision` in Runde 2 |
| --- | --- | --- | --- | --- |
| 01 | A | `profile-01.js` | `conflict/team-a-feature` | `feature/<issue>-<kurztext>` |
| 02 | A | `profile-02.js` | `conflict/team-a-feat` | `feat/<issue>-<kurztext>` |
| 03 | B | `profile-03.js` | `conflict/team-b-squash` | `Squash Merge für Feature Pull Requests` |
| 04 | B | `profile-04.js` | `conflict/team-b-merge` | `Merge Commit für Feature Pull Requests` |
| 05 | C | `profile-05.js` | `conflict/team-c-conventional` | `Conventional Commits mit Typ und Imperativ` |
| 06 | C | `profile-06.js` | `conflict/team-c-freeform` | `Freie Commit-Texte mit Issue-Nummer` |
| 07 | D | `profile-07.js` | `conflict/team-d-one-review` | `Eine Freigabe aus dem eigenen Tandem` |
| 08 | D | `profile-08.js` | `conflict/team-d-two-reviews` | `Zwei Freigaben aus anderen Teams` |
| 09 | E | `profile-09.js` | `conflict/team-e-auto-delete` | `Branch nach Merge automatisch löschen` |
| 10 | E | `profile-10.js` | `conflict/team-e-keep` | `Branch bis zum Sprintende behalten` |

## Akzeptanzkriterien Runde 1

- Nur die eigene Profil-Datei wurde verändert.
- `name` enthält den eigenen Anzeigenamen.
- `strength` beschreibt eine konkrete Stärke in der Zusammenarbeit.
- `ready` steht auf `true`.
- `npm test` ist grün.
- Pull Request und Review sind vollständig.

## Akzeptanzkriterien Runde 2

- Nur die `decision`-Zeile des eigenen Teams wurde verändert.
- Beide konkurrierenden Pull Requests wurden von demselben Stand erstellt.
- Der erste PR wurde normal gemergt.
- Der zweite Branch wurde auf `origin/main` rebased.
- Die endgültige Formulierung wurde im Tandem fachlich entschieden, nicht blind übernommen.
- Aktualisierung erfolgte mit `git push --force-with-lease`.

