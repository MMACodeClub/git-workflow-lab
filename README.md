# Git Workflow Lab

Ein vollständiges 120-Minuten-Übungsrepository für **10 Personen**. Die Gruppe übt an einer kleinen Team-Webapp den gemeinsamen GitHub-Workflow:

- Feature Branches und sinnvolle Commits
- Pull Requests und Code Reviews
- Request Changes und Suggested Changes
- Merge-Konflikte bewusst erzeugen und lösen
- `fetch`, Rebase und `--force-with-lease`
- Fast-Forward, Merge Commit und Squash unterscheiden
- Branch Protection und automatisierte Checks nutzen

## Schnellstart

```bash
git clone <REPOSITORY-URL>
cd git-workflow-lab
npm test
npm start
```

Danach ist die App unter [http://localhost:4173](http://localhost:4173) erreichbar. Voraussetzung ist Node.js 18 oder neuer; Python und zusätzliche npm-Pakete werden nicht benötigt.

## Rollen und Unterlagen

| Zielgruppe | Dokument |
| --- | --- |
| Moderation | [120-Minuten-Ablauf](docs/MODERATION.md) |
| Teilnehmende | [Arbeitsanleitung](docs/TEILNEHMENDE.md) |
| Alle | [Git-Cheatsheet](docs/CHEATSHEET.md) |
| Zehn Rollen | [Aufgabenkarten](docs/AUFGABEN.md) |
| Repo-Regeln | [CONTRIBUTING.md](CONTRIBUTING.md) |

## Übungsdesign

Die zehn Personen werden in fünf Review-Tandems aufgeteilt. Zuerst verändert jede Person exklusiv eine Profil-Datei. Dadurch kann der normale Branch-PR-Review-Merge-Zyklus ohne zufällige Konflikte geübt werden. Anschliessend ändern beide Personen eines Tandems dieselbe Zeile in `src/workshop-config.js`. Der zweite Pull Request kollidiert garantiert mit dem ersten und muss per Rebase gelöst werden.

Die App und die Tests machen den Zustand sichtbar. Ein Pull Request ist erst bereit zum Mergen, wenn `npm test` erfolgreich ist und das Tandem das Review freigegeben hat.

## Für die Lehrperson

Nach dem Veröffentlichen können die 16 vorbereiteten GitHub Issues mit diesem Skript erzeugt werden. Es kann gefahrlos erneut ausgeführt werden und überspringt vorhandene Aufgaben:

```bash
./scripts/create-issues.sh
```

Repository-Einstellungen, Zeitplan, Notfallplan und Abschlusskontrolle stehen in [docs/MODERATION.md](docs/MODERATION.md).

## Lizenz

Dieses Lehr-Repository steht unter der [MIT-Lizenz](LICENSE).
