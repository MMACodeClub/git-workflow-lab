# Moderationsleitfaden: 120 Minuten

## Lernziele

Am Ende kann jede Person einen Branch vom aktuellen `main` erstellen, fokussiert committen, pushen, einen Pull Request eröffnen, eine Review durchführen, Feedback einarbeiten, einen Rebase-Konflikt lösen und die passende Integrationsstrategie erklären.

## Vorbereitung (vor dem Termin)

- Zehn GitHub-Konten und Git auf allen Geräten sicherstellen.
- Alle Personen als Collaborators mit Schreibrecht einladen.
- `./scripts/create-issues.sh` ausführen. Die zehn Runde-1-Issues einzeln zuweisen, die fünf Runde-2-Issues den Tandems und das Exit-Ticket der ganzen Gruppe erklären.
- Unter **Settings → General → Pull Requests** Squash Merge aktivieren und automatische Branch-Löschung aktivieren.
- Branch Ruleset für `main`: Pull Request erforderlich, mindestens 1 Approval, neue Commits verwerfen alte Approvals, Approval des letzten Pushers verbieten, `test` als Required Status Check, direkte Pushes blockieren.
- Teams verteilen: A = 01/02, B = 03/04, C = 05/06, D = 07/08, E = 09/10.
- Einen Beamer mit Repository, Pull-Request-Liste und Terminal vorbereiten.
- Beim Einstieg die MIT-Datei kurz zeigen: Ein öffentlich sichtbares Repository ist ohne Lizenz nicht automatisch frei nutzbar.

Branch Protection erst aktivieren, nachdem der initiale Commit und die Issues angelegt sind. Falls Status Checks noch nicht auswählbar sind, einmal den Action-Workflow auf `main` laufen lassen.

**Wichtig:** Beim Required Status Check die Option **Require branches to be up to date before merging** deaktivieren. Sonst werden in Runde 1 nach jedem Merge fast alle übrigen PRs künstlich veraltet und der Zeitplan kollabiert. Der geplante Konflikt in Runde 2 entsteht trotzdem zuverlässig durch dieselbe geänderte Zeile.

## Ablauf

| Zeit | Aktivität | Sichtbares Ergebnis |
| --- | --- | --- |
| 00–10 | Einstieg, Clone, `npm test`, Dreiebenenmodell | alle lokal bereit |
| 10–20 | Live-Demo: Branch, Diff, Stage, Commit, Push | gemeinsames Vokabular |
| 20–38 | Runde 1: zehn Profil-Branches und PRs | 10 offene PRs |
| 38–55 | Suggested Change und Request Changes | 10 Änderungswünsche |
| 55–63 | Suggestion committen, erneut prüfen, Approval und Merge | Profile auf `main` |
| 63–71 | Graph-Demo: FF, Merge Commit, Rebase | Strategien verstanden |
| 71–82 | Runde 2: zwei Konflikt-Branches je Team | 10 neue PRs |
| 82–91 | beide PRs approven, ungerade PRs mergen | 5 PRs gemergt |
| 91–107 | gerade PRs rebasen, Konflikt lösen, pushen | 5 Approvals verworfen |
| 107–114 | erneutes Review und Merge | Entscheide auf `main` |
| 114–120 | `git log` und Kommentare im Exit-Issue | Transfer gesichert |

## Live-Demo bei Minute 10

Zeige langsam `status → switch -c → diff → add → diff --staged → commit → push`. Erkläre bei jedem Schritt, welche der drei Ebenen verändert wird. Der Demo-Branch wird nicht gemergt.

## Graph-Demo bei Minute 63

```bash
./scripts/graph-demo.sh
```

Das Skript erzeugt nur ein ignoriertes lokales Mini-Repository in `.workshop-sandbox/graph-demo`. Es zeigt nacheinander Fast-Forward, einen echten Merge Commit und einen linearen Verlauf nach Rebase. Die Ausgabe gemeinsam von unten nach oben lesen.

## Steuerung der Konfliktrunde

1. Prüfen, dass beide Personen jedes Teams denselben aktuellen `main` haben.
2. Beide Branches parallel erstellen und pushen lassen.
3. Vor dem Merge beide PRs jedes Tandems approven lassen.
4. Nur die PRs 01, 03, 05, 07, 09 zuerst mergen.
5. In den übrigen PRs Konflikt und vorhandenes Approval sichtbar machen.
6. Gerade Personen führen `fetch` und `rebase origin/main` aus.
7. Tandems müssen den Endwert diskutieren. Nicht einfach "ours" oder "theirs" wählen.
8. Vor `--force-with-lease` erklären, dass Rebase Commit-IDs ersetzt.
9. Nach dem Push gemeinsam beobachten, dass das alte Approval verschwunden ist; erst nach erneutem Diff-Review wieder freigeben.

## Exit-Ticket

Jede Person beantwortet im vorbereiteten Abschluss-Issue drei Fragen:

1. Warum ist `git pull --ff-only` auf `main` hilfreich?
2. Weshalb ist `--force-with-lease` sicherer als `--force`?
3. Wann braucht ein Konflikt eine fachliche statt nur eine technische Entscheidung?

## Zeitnot oder Störung

- Unter 20 Minuten Restzeit: Nur Teams A und B lösen live; die anderen beobachten mit offenem Terminal.
- GitHub Actions gestört: lokale Ausgabe von `npm test` im PR dokumentieren; Review-Regel beibehalten.
- Merge-Konflikt erscheint nicht: Beide Branches wurden vermutlich nicht vom gleichen Ausgangsstand erstellt oder der erste PR ist noch nicht gemergt. Mit `git log --graph --all` prüfen.
- Rebase misslungen: `git rebase --abort`, Zustand erklären lassen und erneut ab `git fetch origin` starten.

## Erfolgskontrolle

- 20 Pull Requests insgesamt: 10 Profil-PRs + 10 Konflikt-PRs.
- Mindestens 35 Reviews: 20 in Runde 1, 10 erste Approvals und 5 erneute Approvals in Runde 2.
- Zehn dokumentierte Request-Changes-Zyklen mit Suggested Changes.
- Fünf durch Rebase verworfene und anschliessend erneuerte Approvals.
- Fünf dokumentierte Rebase-Konflikte.
- Keine direkten Commits auf `main` nach Workshopstart.
- Alle Checks auf dem finalen `main` grün.
