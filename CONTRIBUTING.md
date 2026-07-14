# Beitragsregeln

## Verbindlicher Workflow

1. Nie direkt auf `main` arbeiten.
2. Vor jedem neuen Branch: `git switch main && git pull --ff-only`.
3. Branches heissen `feature/<issue>-<kurztext>` oder `conflict/<team>-<option>`.
4. Ein Commit enthält genau eine nachvollziehbare Änderung.
5. Vor dem Push immer `npm test` ausführen.
6. Pull Requests referenzieren ihr Issue mit `Closes #<nummer>`.
7. Die andere Person im Tandem reviewt den Pull Request.
8. Eigene Pull Requests werden nicht selbst freigegeben oder gemergt.
9. Nach einem Rebase nur `git push --force-with-lease`, niemals `--force`.
10. Nach dem Merge lokale und entfernte Feature Branches löschen.

## Commit-Stil

```text
<typ>: <kurze Beschreibung im Imperativ>
```

Erlaubte Typen: `feat`, `fix`, `docs`, `test`, `chore`.

Beispiele:

```text
feat: ergänze Profil von Person 04
fix: einige Team A auf Branch-Konvention
docs: präzisiere Rebase-Anleitung
```

## Review-Checkliste

- Erfüllt die Änderung die Akzeptanzkriterien des Issues?
- Ist nur der notwendige Bereich verändert?
- Sind Namen und Daten verständlich?
- Läuft `npm test`?
- Wurde weder generierter noch lokaler Inhalt committed?
- Bei einem Konflikt: Ist die fachliche Entscheidung erhalten geblieben?

