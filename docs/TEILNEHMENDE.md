# Arbeitsanleitung für Teilnehmende

## Vor dem Start

```bash
git config --global user.name "Vorname Nachname"
git config --global user.email "ID+username@users.noreply.github.com"
git config --global pull.ff only
git config --global fetch.prune true
git clone <URL-DER-LEHRPERSON>
cd git-workflow-lab
node --version
npm test
```

Verwende die exakte GitHub-Noreply-Adresse aus **GitHub → Settings → Emails**. Das verhindert, dass eine private E-Mail in Commits veröffentlicht wird oder GitHub den ersten Push mit `GH007` blockiert. Für das Repo wird Node.js 18 oder neuer benötigt.

Öffne deine Nummer in [AUFGABEN.md](AUFGABEN.md). Deine Review-Person ist die zweite Person im gleichen Team.

## Runde 1: Sicherer Feature-Workflow

```bash
git switch main
git pull --ff-only
git switch -c feature/<nummer>-profil
```

Bearbeite ausschliesslich deine Datei `src/profiles/profile-<nummer>.js`. Setze deinen Namen, `ready: true` und als Stärke zunächst bewusst nur ein allgemeines Stichwort wie `Kommunikation`. Dieser verbesserungsfähige Text ist der kontrollierte Anlass für den Review-Zyklus.

```bash
npm test
git diff
git status
git add src/profiles/profile-<nummer>.js
git commit -m "feat: ergänze Profil von Person <nummer>"
git push -u origin feature/<nummer>-profil
```

Erstelle auf GitHub einen Pull Request. Optional kannst du ihn früh als **Draft Pull Request** eröffnen und nach dem lokalen Test mit **Ready for review** freigeben. Fülle das Template aus, verknüpfe dein Issue mit `Closes #...` und fordere die Tandem-Person als Reviewer an.

### Verpflichtender Review-Zyklus

1. Die Review-Person öffnet **Files changed** und markiert die Zeile mit `strength`.
2. Über das Suggestion-Symbol wird eine konkrete Formulierung vorgeschlagen, zum Beispiel statt `Kommunikation` neu `Fasst Diskussionen zusammen und klärt offene Entscheidungen`.
3. Die Review wird mit einer kurzen Begründung und **Request changes** abgeschlossen.
4. Die Autorin oder der Autor öffnet die Suggestion, wählt **Commit suggestion** und kontrolliert den neuen Actions-Lauf.
5. Die Review-Person prüft den tatsächlich neuen Stand und schliesst die zweite Review mit **Approve** ab.

Damit erlebt ihr den vollständigen Zyklus aus Feedback, Änderung, erneuter CI-Prüfung und Freigabe. Erst danach wird gemergt.

Nach dem Merge:

```bash
git switch main
git pull --ff-only
git branch -d feature/<nummer>-profil
git fetch --prune
```

## Runde 2: Geplanter Konflikt mit Rebase

Öffnet das gemeinsame Runde-2-Issue eures Teams. Wartet, bis beide Personen auf demselben aktuellen `main` stehen. Erstellt dann gleichzeitig je einen eigenen `conflict/...`-Branch. Ändert exakt die `decision`-Zeile eures Teams gemäss Aufgabenkarte.

Beide pushen und öffnen einen Pull Request. Der PR der ungeraden Person verwendet `Refs #...`, der PR der geraden Person `Closes #...`. So bleibt das Team-Issue bis zur vollständigen Lösung offen.

Die Tandem-Person prüft und **approved zunächst beide Pull Requests**. Danach wird nur der PR der ungeraden Person gemergt. Der PR der geraden Person enthält nun einen Konflikt und ist veraltet.

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

Da der Rebase neue Commit-IDs erzeugt hat, verwirft GitHub das frühere Approval. Die Review-Person muss den aufgelösten Konflikt und den aktuellen Diff erneut prüfen und ein neues Approval erteilen. Genau dieses zweite Review schützt davor, dass nach einer Freigabe unkontrollierte Änderungen hinzukommen.

Prüft im Pull Request gemeinsam:

- Der Konflikt ist aufgelöst.
- Die gemeinsame fachliche Entscheidung ist korrekt.
- Die Checks sind grün.
- Der Verlauf enthält keine unnötigen Merge Commits.

Danach Merge und Branch-Löschung wie in Runde 1. Der zweite PR schliesst mit `Closes #...` das gemeinsame Team-Issue.

## Abschluss

Öffnet das gemeinsame Exit-Ticket. Jede Person beantwortet die drei Fragen in einem eigenen Issue-Kommentar. Die Moderation schliesst das Issue, sobald alle zehn Beiträge vorhanden sind.

## Wenn etwas schiefgeht

```bash
git status                 # zuerst immer den Zustand lesen
git rebase --abort         # Rebase vollständig abbrechen
git restore <datei>        # uncommittete Änderung an einer Datei verwerfen
git reflog                  # lokale Bewegungen wiederfinden
```

Kein `git reset --hard`, kein `git push --force` und keine fremden Branches löschen. Holt bei Unsicherheit die Moderation dazu, bevor ihr Daten verwerft.

## Ausblick: Forks in Open Source

In diesem Workshop seid ihr Collaborators und pusht eure Branches direkt in dasselbe Repository. Bei fremden Open-Source-Projekten fehlt dieses Schreibrecht meist: Ihr erstellt dann einen Fork im eigenen Account, pusht dorthin und öffnet aus dem Fork einen Pull Request zum Originalprojekt. Review, CI und Konfliktlösung bleiben konzeptionell gleich.
