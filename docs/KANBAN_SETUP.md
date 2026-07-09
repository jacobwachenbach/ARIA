# NexusRE Kanban Board Setup

This repo includes scripts and issues for tracking every feature in [PRD.md](../PRD.md) on a GitHub Projects Kanban board.

## Quick setup (2 minutes)

### 1. Create the issues (if not already created)

```bash
./scripts/create-nexusre-issues.sh
```

This creates **~80 issues** prefixed by section: `[Core]`, `[Static]`, `[Dynamic]`, `[Scripting]`, `[Notes]`, `[UI]`, `[Browser]`, `[Traffic]`, `[Roadmap]`, `[Deliverable]`.

### 2. Create the Kanban board in GitHub

1. Open https://github.com/jacobwachenbach/ARIA
2. Click the **Projects** tab → **New project**
3. Choose **Board** layout
4. Name it **NexusRE Feature Kanban**
5. Click **Add item** → **Add items from repository**
6. Filter: `is:issue is:open` (or search `[Core]` etc. by section)
7. Select all NexusRE feature issues → **Add selected items**

### 3. Configure columns

Default columns work well:

| Column | Use for |
|--------|---------|
| **Backlog** | All new features (default) |
| **Ready** | Scoped and ready to implement |
| **In progress** | Active development |
| **In review** | PR open / needs review |
| **Done** | Shipped |

Optional: add a **Priority** field (High / Medium / Low) and group the board by priority.

## Automated setup (requires project scope)

If your `gh` CLI has the `project` scope:

```bash
gh auth refresh -h github.com -s project
./scripts/create-nexusre-issues.sh    # skip if issues exist
./scripts/setup-nexusre-kanban.sh
```

This creates the project, links it to the repo, adds a Status field, and bulk-adds all `type:feature` issues.

## Issue breakdown by section

| Prefix | Count | PRD section |
|--------|-------|-------------|
| `[Core]` | 13 | Architecture, Local AI, Copilot |
| `[Static]` | 7 | Static analysis engine |
| `[Dynamic]` | 5 | Runtime inspection |
| `[Scripting]` | 13 | Code extraction & automation |
| `[Notes]` | 4 | Knowledge graph |
| `[UI]` | 5 | Interface |
| `[Browser]` | 6 | Browser attachment |
| `[Traffic]` | 12 | Network & security assessment |
| `[Roadmap]` | 16 | Gap analysis / future |
| `[Deliverable]` | 7 | Architecture deliverables |

## Tips

- **Filter views:** Create saved views per section using title filters like `[Core]` or `[Traffic]`.
- **Milestones:** Group by release (e.g., `v0.1 Core`, `v0.2 Static`, `v0.3 Copilot`).
- **Link PRs:** When implementing a feature, link the PR to its issue (`Closes #NN`).
