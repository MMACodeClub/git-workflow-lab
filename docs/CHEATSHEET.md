# Git-Cheatsheet

## Drei Ebenen

| Ebene | Bedeutung | Typischer Befehl |
| --- | --- | --- |
| Working Tree | aktuelle Dateien | `git diff` |
| Staging Area | Inhalt für nächsten Commit | `git diff --staged` |
| Repository | gespeicherte Commits | `git log --oneline` |

## Täglicher Ablauf

```bash
git switch main
git pull --ff-only
git switch -c feature/123-kurztitel
# bearbeiten
git diff
git add <datei>
git commit -m "feat: beschreibe Änderung"
git push -u origin HEAD
```

## Aktualisieren und Rebase

```bash
git fetch origin
git rebase origin/main
# Konflikt lösen
git add <gelöste-datei>
git rebase --continue
git push --force-with-lease
```

`fetch` lädt Informationen, verändert aber keine Arbeitsdateien. `pull` kombiniert `fetch` mit Integration. `rebase` setzt eigene Commits auf eine neue Basis und schreibt deren IDs neu.

## Integrationsarten

| Art | Ergebnis | Einsatz im Workshop |
| --- | --- | --- |
| Fast-Forward | Branch-Zeiger wird vorgeschoben, kein Merge Commit | lokales Modell im Graph-Demo |
| Merge Commit | erhält beide Verläufe und erzeugt Integrations-Commit | Vergleich im Graph-Demo |
| Squash Merge | fasst PR-Commits zu einem Commit auf `main` zusammen | empfohlener GitHub-Merge |
| Rebase | linearisiert eigene Commits auf neuer Basis | veralteten PR aktualisieren |

## Diagnose und Rettung

```bash
git status
git log --oneline --graph --decorate --all
git diff origin/main...HEAD
git rebase --abort
git reflog
```

## Sichere Grundregeln

- `main` ist geschützt und bleibt veröffentlichte Wahrheit.
- Kleine Branches und kleine Pull Requests reduzieren Konflikte.
- Konflikte sind fachliche Entscheidungen, keine rein technischen Fehler.
- Öffentliche Branch-Historie nur bewusst umschreiben.
- Nach Rebase immer `--force-with-lease`; es schützt vor dem Überschreiben fremder neuer Commits.

