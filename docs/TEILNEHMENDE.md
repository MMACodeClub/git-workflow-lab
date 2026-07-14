# Arbeitsanleitung für Teilnehmende

## Vor dem Start

```bash
git config --global user.name "Vorname Nachname"
git config --global user.email "deine-github-mail@example.com"
git config --global pull.ff only
git config --global fetch.prune true
git clone <URL-DER-LEHRPERSON>
cd git-workflow-lab
npm test
```

Öffne deine Nummer in [AUFGABEN.md](AUFGABEN.md). Deine Review-Person ist die zweite Person im gleichen Team.

## Runde 1: Sicherer Feature-Workflow

```bash
git switch main
git pull --ff-only
git switch -c feature/<nummer>-profil
```

Bearbeite ausschliesslich deine Datei `src/profiles/profile-<nummer>.js`. Setze deinen Namen, eine Stärke in der Gruppenarbeit und `ready: true`.

```bash
npm test
git diff
git status
git add src/profiles/profile-<nummer>.js
git commit -m "feat: ergänze Profil von Person <nummer>"
git push -u origin feature/<nummer>-profil
```

Erstelle auf GitHub einen Pull Request. Fülle das Template aus, verknüpfe dein Issue mit `Closes #...` und fordere die Tandem-Person als Reviewer an. Reviewer prüfen `Files changed`, hinterlassen mindestens einen konkreten Kommentar und wählen danach **Approve** oder **Request changes**.

Nach dem Merge:

```bash
git switch main
git pull --ff-only
git branch -d feature/<nummer>-profil
git fetch --prune
```

## Runde 2: Geplanter Konflikt mit Rebase

Wartet, bis beide Personen des Tandems auf demselben aktuellen `main` stehen. Erstellt dann gleichzeitig je einen eigenen `conflict/...`-Branch. Ändert exakt die `decision`-Zeile eures Teams gemäss Aufgabenkarte.

Beide pushen und öffnen einen Pull Request. Der PR der ungeraden Person wird zuerst reviewed und gemergt. Der PR der geraden Person ist nun veraltet.

Die gerade Person aktualisiert ihren Branch:

```bash
git fetch origin
git rebase origin/main
```

Git stoppt am Konflikt. Öffne `src/workshop-config.js`, suche die Marker `<<<<<<<`, `=======`, `>>>>>>>` und ersetze den gesamten Konfliktblock durch **einen gemeinsam beschlossenen Wert**.

```bash
git add src/workshop-config.js
git rebase --continue
npm test
git push --force-with-lease
```

Prüft im Pull Request gemeinsam:

- Der Konflikt ist aufgelöst.
- Die gemeinsame fachliche Entscheidung ist korrekt.
- Die Checks sind grün.
- Der Verlauf enthält keine unnötigen Merge Commits.

Danach Review, Merge und Branch-Löschung wie in Runde 1.

## Wenn etwas schiefgeht

```bash
git status                 # zuerst immer den Zustand lesen
git rebase --abort         # Rebase vollständig abbrechen
git restore <datei>        # uncommittete Änderung an einer Datei verwerfen
git reflog                  # lokale Bewegungen wiederfinden
```

Kein `git reset --hard`, kein `git push --force` und keine fremden Branches löschen. Holt bei Unsicherheit die Moderation dazu, bevor ihr Daten verwerft.

