#!/usr/bin/env bash
# Creates GitHub issues for every NexusRE PRD feature (no labels required).
# Run from repo root: ./scripts/create-nexusre-issues.sh
set -euo pipefail

REPO="${GITHUB_REPO:-jacobwachenbach/ARIA}"

create_issue() {
  local title="$1"
  local body="$2"
  gh issue create --repo "$REPO" --title "$title" --body "$body"
}

echo "Creating NexusRE feature issues in $REPO..."

# Section 1 — Core
create_issue "[Core] Engine Stack (Rust/C++ backend)" "**Priority:** High\n\nRust or modern C++ backend with multi-threading and hardware-accelerated runtime memory inspection. Read-only by default; writes gated behind confirmation and audit logging.\n\n**PRD:** Section 1"
create_issue "[Core] Local AI Orchestration" "**Priority:** High\n\nInference abstraction layer for local LLMs (Ollama, LM Studio, vLLM) via localhost:11434 or OpenAI-compatible endpoints. Fully offline operation.\n\n**PRD:** Section 1"
create_issue "[Core] Structured AI Outputs (JSON Schema)" "**Priority:** High\n\nStrict JSON Schema forcing for LLM responses: C++ structs, memory layouts, offset tables, analysis scripts.\n\n**PRD:** Section 1"
create_issue "[Core] AI Copilot & Natural-Language Navigation" "**Priority:** High\n\nPersistent Copilot panel for plain-language questions; queries indexed project/browser state and navigates UI on behalf of analyst.\n\n**PRD:** Section 1"
create_issue "[Core] Copilot Query Scope" "**Priority:** High\n\nSearch function names, pseudocode, symbols, bookmarks, notes, HTTP traffic, API routes, browser sitemap, DOM snapshots, analysis history.\n\n**PRD:** Section 1"
create_issue "[Core] Structured Navigation Actions" "**Priority:** High\n\nJSON navigation plan schema: \`navigate_to_function\`, \`navigate_to_address\`, \`open_view\`, \`browser_goto_url\`, \`browser_highlight_element\`, \`show_search_results\`.\n\n**PRD:** Section 1"
create_issue "[Core] Copilot Existence & Location Answers" "**Priority:** Medium\n\nAnswer does-this-page-exist style questions with yes/no/unknown, evidence links, and one-click Go there.\n\n**PRD:** Section 1"
create_issue "[Core] Copilot Disambiguation UX" "**Priority:** Medium\n\nRanked picker when multiple matches; user can reply the second one to navigate.\n\n**PRD:** Section 1"
create_issue "[Core] Browser-Aware Copilot Go-To" "**Priority:** Medium\n\nCorrelate DOM routes, network logs, and native call stacks; open browser URL and sync decompiler view.\n\n**PRD:** Section 1"
create_issue "[Core] Copilot Safety & Audit Logging" "**Priority:** High\n\nOut-of-scope URL confirmation; log all navigation actions with prompt, target, timestamp.\n\n**PRD:** Section 1"
create_issue "[Core] Headless & Batch Mode (CLI)" "**Priority:** High\n\nCLI for unattended pipelines: import binary, run scripted passes, export reports.\n\n**PRD:** Section 1"
create_issue "[Core] Plugin & Extension API" "**Priority:** High\n\nStable SDK (Rust/C++ core, Python bindings) for third-party loaders, analyzers, exporters, UI panels.\n\n**PRD:** Section 1"
create_issue "[Core] Intended Use & Compliance Controls" "**Priority:** High\n\nScope controls, audit logging, consent prompts before live attach or traffic capture.\n\n**PRD:** Intended Use"

# Section 2 — Static
create_issue "[Static] Multi-Format Binary Loaders" "**Priority:** High\n\nPE, ELF, Mach-O, firmware images, archives. Auto-detect x86, x64, ARM32, ARM64, WASM.\n\n**PRD:** Section 2"
create_issue "[Static] Disassembler & Decompiler" "**Priority:** High\n\nLinear disassembly + C pseudocode decompiler. Rename, retype, comment, structure definitions.\n\n**PRD:** Section 2"
create_issue "[Static] Symbol & Debug Info (PDB/DWARF)" "**Priority:** High\n\nImport PDB, DWARF, map files. Resolve exports, imports, demangled C++ names.\n\n**PRD:** Section 2"
create_issue "[Static] Cross-References & Call Graph" "**Priority:** High\n\nFull xref graph, function call trees, interactive CFG/DFG visualization.\n\n**PRD:** Section 2"
create_issue "[Static] Signature & Library Recognition" "**Priority:** Medium\n\nFLIRT-style ID, byte-pattern signatures, user-editable type libraries.\n\n**PRD:** Section 2"
create_issue "[Static] Binary Diffing" "**Priority:** Medium\n\nSide-by-side build comparison: changed functions, shifted offsets, patched regions.\n\n**PRD:** Section 2"
create_issue "[Static] String, Import & Entropy Passes" "**Priority:** Medium\n\nString extraction, API enumeration, packer heuristics, section entropy scoring.\n\n**PRD:** Section 2"

# Section 3 — Dynamic
create_issue "[Dynamic] Live Process Attach" "**Priority:** High\n\nAttach to local process with consent UI. Default read-only memory and module enumeration.\n\n**PRD:** Section 3"
create_issue "[Dynamic] Automated Class & Struct Reconstruction" "**Priority:** High\n\nRTTI parsing, C++ class hierarchies, Vtable mapping, field type inference synced to static DB.\n\n**PRD:** Section 3"
create_issue "[Dynamic] Data-Flow & Taint Analysis" "**Priority:** High\n\nTrace buffer lifetimes from networking/serialization routines; flag bounds checks and unvalidated paths.\n\n**PRD:** Section 3"
create_issue "[Dynamic] Pattern & Signature Generation" "**Priority:** Medium\n\nOne-click update-resilient byte signatures from functions/addresses for CI regression.\n\n**PRD:** Section 3"
create_issue "[Dynamic] Debugger Integration" "**Priority:** High\n\nBreakpoints, single-step, registers, stack, watchpoints unified with static database.\n\n**PRD:** Section 3"

# Section 4 — Scripting
create_issue "[Scripting] Decompiler Export" "**Priority:** High\n\nExport pseudocode, structs, enums, xrefs to C headers, Markdown, or JSON bundles.\n\n**PRD:** Section 4.1"
create_issue "[Scripting] Selection-Aware Code Extract" "**Priority:** Medium\n\nExport highlighted address range, basic block, or struct with comments and types.\n\n**PRD:** Section 4.1"
create_issue "[Scripting] Batch Code Extract" "**Priority:** Medium\n\nFilter-driven export across matching functions to project folder.\n\n**PRD:** Section 4.1"
create_issue "[Scripting] Live Snapshot Export" "**Priority:** Medium\n\nDump layouts, register state at breakpoint, memory regions as annotated hex + C struct.\n\n**PRD:** Section 4.1"
create_issue "[Scripting] Built-In Script Editor" "**Priority:** High\n\nPython 3 + optional Lua DSL with NexusRE API autocomplete.\n\n**PRD:** Section 4.2"
create_issue "[Scripting] Script Templates Gallery" "**Priority:** Medium\n\nStarter templates: enumerate exports, string xrefs, protocol decode, diff builds, call graph PNG.\n\n**PRD:** Section 4.2"
create_issue "[Scripting] One-Click Run & REPL Console" "**Priority:** High\n\nRun scripts against project/session; interactive REPL for ad-hoc API queries.\n\n**PRD:** Section 4.2"
create_issue "[Scripting] Sandboxed Script Execution" "**Priority:** High\n\nRestricted interpreter by default; explicit elevation for network/filesystem writes.\n\n**PRD:** Section 4.2"
create_issue "[Scripting] Event-Driven Script Hooks" "**Priority:** Medium\n\nScripts on events: binary imported, function renamed, breakpoint hit, HTTP captured.\n\n**PRD:** Section 4.2"
create_issue "[Scripting] AI-Assisted Script Generation" "**Priority:** Medium\n\nLocal AI drafts scripts from UI selection; user reviews before execution.\n\n**PRD:** Section 4.2"
create_issue "[Scripting] Function Interceptor Wizard" "**Priority:** Medium\n\nGenerate instrumentation hook boilerplate from decompiler selection.\n\n**PRD:** Section 4.3"
create_issue "[Scripting] Analysis Plugin Templates" "**Priority:** Medium\n\nExportable C++/Rust in-process tracing modules with build instructions.\n\n**PRD:** Section 4.3"
create_issue "[Scripting] Automation Script Exports" "**Priority:** Medium\n\nPackage findings as Python scripts, C++ tracing stubs, JSON for CI, memory-analysis tables.\n\n**PRD:** Section 4.3"

# Section 5 — Knowledge Graph
create_issue "[Notes] Contextual Scratchpad" "**Priority:** Medium\n\nMarkdown-supported note tab linked to analysis workspace.\n\n**PRD:** Section 5"
create_issue "[Notes] Live-Linked Assets" "**Priority:** Medium\n\nClickable anchors for structs, findings, traffic; jump to disassembly/decompiler/memory/traffic.\n\n**PRD:** Section 5"
create_issue "[Notes] AI Synthesizer Report" "**Priority:** Medium\n\nUnified Security & Compatibility Assessment Report from full note graph.\n\n**PRD:** Section 5"
create_issue "[Notes] Project Persistence & Versioning" "**Priority:** High\n\nVersioned project file for notes, scripts, types, bookmarks; optional Git integration.\n\n**PRD:** Section 5"

# Section 6 — UI
create_issue "[UI] Synchronized Multi-View" "**Priority:** High\n\nSplit-pane: Disassembly, Pseudocode, Memory Hex, Script Editor, Function Graph, Notes.\n\n**PRD:** Section 6"
create_issue "[UI] AI Copilot Panel" "**Priority:** High\n\nDockable chat sidebar; auto-focus pane, scroll to target, highlight destination.\n\n**PRD:** Section 6"
create_issue "[UI] Bookmarks, History & Annotations" "**Priority:** Medium\n\nColor tags, comments, navigable analysis history trail.\n\n**PRD:** Section 6"
create_issue "[UI] Zero-Lag Asynchronous Design" "**Priority:** High\n\nNon-blocking UI during memory scans, decompilation, LLM queries.\n\n**PRD:** Section 6"
create_issue "[UI] Theming & Accessibility" "**Priority:** Low\n\nDark/light themes, scalable fonts, keyboard-driven navigation.\n\n**PRD:** Section 6"

# Section 7 — Browser & Traffic
create_issue "[Browser] Extension Bridge" "**Priority:** High\n\nChromium/Firefox extension streaming DOM, JS stacks, storage, WebSockets to NexusRE.\n\n**PRD:** Section 7.1"
create_issue "[Browser] DevTools Protocol (CDP) Attach" "**Priority:** High\n\nAttach to Chrome/Edge/Chromium for JS breakpoints, network inspection, HAR logs, source maps.\n\n**PRD:** Section 7.1"
create_issue "[Browser] Playwright/Puppeteer Headless Hook" "**Priority:** Medium\n\nHeadless browser regression passes; pipe output to Knowledge Graph.\n\n**PRD:** Section 7.1"
create_issue "[Browser] Indexed Route & Page Inventory" "**Priority:** High\n\nIndex URLs, titles, forms, anchors, API endpoints for offline Copilot search.\n\n**PRD:** Section 7.1.1"
create_issue "[Browser] Ask-to-Navigate (Copilot)" "**Priority:** High\n\nNatural-language browser navigation with evidence and auto-go.\n\n**PRD:** Section 7.1.1"
create_issue "[Browser] Browser/Native Cross-View Sync" "**Priority:** Medium\n\nOpen browser location and linked native decompiler function side by side.\n\n**PRD:** Section 7.1.1"
create_issue "[Traffic] Local TLS Inspection Proxy" "**Priority:** High\n\nEmbedded HTTP/HTTPS proxy on localhost with NexusRE CA.\n\n**PRD:** Section 7.2"
create_issue "[Traffic] Process-Scoped Traffic Capture" "**Priority:** High\n\nCorrelate WebView2/CEF/Electron HTTP/TLS with native call stacks.\n\n**PRD:** Section 7.2"
create_issue "[Traffic] Traffic-to-Memory Correlation" "**Priority:** High\n\nTrace request parameter values back to originating buffer, function, struct.\n\n**PRD:** Section 7.2"
create_issue "[Traffic] WebSocket & gRPC Stream Inspection" "**Priority:** Medium\n\nDecode frames/protobuf; flag protocol issues; generate validation scripts.\n\n**PRD:** Section 7.2"
create_issue "[Traffic] OWASP-Oriented Traffic Review" "**Priority:** Medium\n\nFlag common web vulnerability classes; link findings to Knowledge Graph.\n\n**PRD:** Section 7.3"
create_issue "[Traffic] API Fuzzing Matrix" "**Priority:** Medium\n\nMutate discovered endpoint parameters; record anomalies and crash signatures.\n\n**PRD:** Section 7.3"
create_issue "[Traffic] Session & Token Analysis" "**Priority:** Medium\n\nExtract/classify JWTs, cookies, API keys, OAuth; decode claims and flag misconfigurations.\n\n**PRD:** Section 7.3"
create_issue "[Traffic] Hybrid Application Surface Map" "**Priority:** High\n\nUnified graph of native modules, IPC, web endpoints; highlight trust-boundary crossings.\n\n**PRD:** Section 7.3"
create_issue "[Traffic] Compliance & Scope Guardrails" "**Priority:** High\n\nOpt-in capture, domain/IP allowlists, sensitive field redaction, audit log.\n\n**PRD:** Section 7.3"
create_issue "[Traffic] Traffic-Aware Scripts" "**Priority:** Medium\n\nScripts iterate captured requests, decode protobuf, cross-link to native functions.\n\n**PRD:** Section 7.4"
create_issue "[Traffic] AI Synthesizer Web Surface Summary" "**Priority:** Low\n\nReports include Web Application Surface Summary alongside native findings.\n\n**PRD:** Section 7.4"
create_issue "[Traffic] Security Export Targets" "**Priority:** Low\n\nBurp configs, nuclei templates, ffuf wordlists, Python requests scripts.\n\n**PRD:** Section 7.4"

# Section 8 — Roadmap
create_issue "[Roadmap] Emulation (Unicorn/QEMU)" "**Priority:** Medium\n\nOptional sandboxed execution of untrusted snippets.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Firmware / IoT Loaders" "**Priority:** Medium\n\nNAND/NOR dump loaders, partition parsers, base-address rebasing.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Collaborative RE" "**Priority:** High\n\nShared project servers, RBAC, comment threads on functions.\n\n**PRD:** Section 8"
create_issue "[Roadmap] CI/CD Integration (Headless Action)" "**Priority:** High\n\nGitHub/GitLab Action for headless analysis on release artifacts.\n\n**PRD:** Section 8"
create_issue "[Roadmap] YARA Integration" "**Priority:** Medium\n\nScan segments and memory regions with user YARA rules.\n\n**PRD:** Section 8"
create_issue "[Roadmap] LLVM IR Export" "**Priority:** Low\n\nOptional LLVM IR export for optimization research.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Malware Safe Mode" "**Priority:** High\n\nDetachable analysis VM profile with network disabled by default.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Report Export (PDF/HTML)" "**Priority:** Medium\n\nExecutive summaries for audit and disclosure workflows.\n\n**PRD:** Section 8"
create_issue "[Roadmap] License Management" "**Priority:** Low\n\nOffline node-locked or floating licenses for enterprise labs.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Training Mode" "**Priority:** Medium\n\nSample binaries and guided labs for xref, struct recovery, scripting.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Macro Recorder" "**Priority:** Medium\n\nRecord UI/analysis steps and replay as script skeleton.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Custom Calling Conventions" "**Priority:** Medium\n\nUser-defined ABI for exotic or obfuscated binaries.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Unpacker Assist" "**Priority:** High\n\nOEP detection heuristics and staged dump-to-database workflow.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Semantic Search" "**Priority:** High\n\nEmbedding-based similar-function search across large binaries.\n\n**PRD:** Section 8"
create_issue "[Roadmap] SBOM / Dependency Graph" "**Priority:** Medium\n\nMap statically linked and dynamically loaded third-party components.\n\n**PRD:** Section 8"
create_issue "[Roadmap] Copilot Voice Input" "**Priority:** Low\n\nOptional offline speech-to-text for hands-free go-to commands.\n\n**PRD:** Section 8"

# Section 9 — Deliverables
create_issue "[Deliverable] Architecture Blueprint" "**Priority:** High\n\nCommunication design for Static Analyzer, Dynamic Inspector, Decompiler, AI Context Manager, Script Runtime, Browser Bridge, Traffic Proxy.\n\n**PRD:** Section 9"
create_issue "[Deliverable] AI Orchestration Code" "**Priority:** High\n\nRust/Python local LLM API with JSON Schema outputs and navigation action plans.\n\n**PRD:** Section 9"
create_issue "[Deliverable] Copilot Navigation Executor" "**Priority:** High\n\nAction schema, index queries, disambiguation flow, UI focus/highlight behavior.\n\n**PRD:** Section 9"
create_issue "[Deliverable] Class Reconstruction Algorithm" "**Priority:** High\n\nRTTI/Vtable scanning and struct inference from live memory.\n\n**PRD:** Section 9"
create_issue "[Deliverable] Script Runtime & API Surface" "**Priority:** High\n\nPython/Lua bindings, sandbox model, example scripts.\n\n**PRD:** Section 9"
create_issue "[Deliverable] Browser & Traffic Module Design" "**Priority:** High\n\nCDP attach, localhost proxy, traffic-to-memory correlation pipelines.\n\n**PRD:** Section 9"
create_issue "[Deliverable] UI Layout Scaffold" "**Priority:** High\n\nReact/TypeScript or Qt synchronized multi-view, Script Editor, Traffic Inspector.\n\n**PRD:** Section 9"

echo ""
echo "Created all NexusRE feature issues."
echo "Next: create the Kanban board — see docs/KANBAN_SETUP.md"
