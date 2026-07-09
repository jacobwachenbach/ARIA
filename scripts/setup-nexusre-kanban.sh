#!/usr/bin/env bash
# Creates the NexusRE Kanban GitHub Project and adds all feature issues.
# Requires: gh auth with `project` scope (run: gh auth refresh -h github.com -s project)
# Usage: ./scripts/setup-nexusre-kanban.sh
set -euo pipefail

REPO="${GITHUB_REPO:-jacobwachenbach/ARIA}"
OWNER="${GITHUB_OWNER:-jacobwachenbach}"
PROJECT_TITLE="NexusRE Feature Kanban"

echo "Checking gh project scope..."
if ! gh auth status 2>&1 | grep -q 'project'; then
  echo "ERROR: gh token needs project scope."
  echo "Run: gh auth refresh -h github.com -s project"
  exit 1
fi

echo "Creating project: $PROJECT_TITLE"
PROJECT_JSON=$(gh project create --owner "$OWNER" --title "$PROJECT_TITLE" --format json)
PROJECT_NUM=$(echo "$PROJECT_JSON" | jq -r '.number')
PROJECT_ID=$(echo "$PROJECT_JSON" | jq -r '.id')
echo "Created project #$PROJECT_NUM (id: $PROJECT_ID)"

echo "Linking project to repository $REPO..."
gh project link "$PROJECT_NUM" --owner "$OWNER" --repo "$REPO" 2>/dev/null || true

echo "Creating Kanban Status field..."
gh project field-create "$PROJECT_NUM" --owner "$OWNER" \
  --name "Status" \
  --data-type "SINGLE_SELECT" \
  --single-select-options "Backlog,Ready,In Progress,In Review,Done" \
  --format json >/dev/null 2>&1 || echo "(Status field may already exist — using default project Status)"

echo "Fetching feature issues..."
ISSUE_URLS=$(gh issue list --repo "$REPO" --label "type:feature" --state open --limit 200 --json url --jq '.[].url')

COUNT=0
for url in $ISSUE_URLS; do
  gh project item-add "$PROJECT_NUM" --owner "$OWNER" --url "$url" >/dev/null 2>&1 && COUNT=$((COUNT + 1)) || true
done

echo ""
echo "Kanban board ready!"
echo "  Project: $PROJECT_TITLE (#$PROJECT_NUM)"
echo "  Items added: $COUNT"
echo "  Open board: gh project view $PROJECT_NUM --owner $OWNER --web"
gh project view "$PROJECT_NUM" --owner "$OWNER" --format json --jq '.url' 2>/dev/null || true
