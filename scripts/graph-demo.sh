#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
DEMO="$ROOT/.workshop-sandbox/graph-demo"

rm -rf "$DEMO"
mkdir -p "$DEMO"
cd "$DEMO"

git init -q -b main
git config user.name "Git Workshop"
git config user.email "workshop@example.test"

printf 'basis\n' > board.txt
git add board.txt
git commit -q -m "chore: erstelle Basis"

git switch -q -c demo/fast-forward
printf 'fast-forward\n' >> board.txt
git commit -qam "feat: ergänze Fast-Forward-Beispiel"
git switch -q main
git merge -q --ff-only demo/fast-forward

git switch -q -c demo/merge-commit
printf 'merge branch\n' > merge.txt
git add merge.txt
git commit -q -m "feat: ergänze parallelen Branch"
git switch -q main
printf 'main parallel\n' > main.txt
git add main.txt
git commit -q -m "docs: ergänze parallele Main-Änderung"
git merge -q --no-ff demo/merge-commit -m "merge: integriere Demo-Branch"

git switch -q -c demo/rebase HEAD~2
printf 'rebase\n' > rebase.txt
git add rebase.txt
git commit -q -m "feat: ergänze Rebase-Beispiel"
git rebase -q main

printf '\nGit-Graph (unten beginnen):\n\n'
git log --oneline --graph --decorate --all
printf '\nDemo liegt in %s und ist durch .gitignore ausgeschlossen.\n' "$DEMO"

