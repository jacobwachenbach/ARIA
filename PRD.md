The v2 Master Architecture Prompt
Copy and paste this into your target AI. It leaves zero ambiguity about the automation, application-specific analysis capabilities, and local AI integration.

System Role & Objective
Act as a Principal Systems Architect, Senior Binary Analysis Engineer, and Application Security Researcher. Your objective is to architect and generate the complete application for "NexusRE", a next-generation, AI-native reverse engineering and dynamic analysis platform.

NexusRE must be 10x faster and more capable than Ghidra/IDA Pro by seamlessly merging static binary analysis with dynamic runtime inspection, specifically tuned for complex desktop applications, native libraries, and interactive software. It must feature a deeply integrated Local AI Orchestration layer to automate structural analysis, vulnerability research, and reproducible test harness generation.

Intended Use & Compliance
NexusRE is a professional security research and software analysis workstation. All features assume authorized use only: analyzing binaries you own, software you have written permission to assess, or targets covered by a formal bug-bounty or penetration-test engagement. The platform includes scope controls, audit logging, and consent prompts before any live attach or traffic capture.

Intended Audiences & Use Cases
NexusRE is designed for both professional and personal analysis workflows:

Business & Product Teams: Companies and development teams can use NexusRE to test and validate their own applications, desktop clients, APIs, and websites before release. Typical uses include internal security reviews, QA hardening, regression checks after updates, verifying third-party dependencies, and documenting architecture for compliance or audit purposes—all against systems the organization owns or controls.

Independent Developers & Personal Projects: Individual developers and hobbyists can use NexusRE to understand how their own software works, debug native or hybrid apps they are building, inspect personal projects, learn reverse engineering concepts, and run security sanity checks on apps or sites they host for themselves—all without requiring an enterprise license or external cloud services.

Security Researchers & Consultants: Professional analysts use the same toolset for authorized client engagements, bug-bounty programs, and responsible disclosure workflows.

Regardless of audience, analysts must only analyze software and web properties they own or have explicit permission to test. The built-in scope controls and audit logging apply equally to business, personal, and consulting use.

Product Requirements Document (PRD)

1. Core Architecture & Local AI Integration

Engine Stack: Rust or modern C++ backend for memory safety, multi-threading, and hardware-accelerated runtime memory inspection (read-only by default; optional write access gated behind explicit user confirmation and audit logging).

Local AI Orchestration: Implement an inference abstraction layer designed to connect to local LLMs (e.g., Ollama, LM Studio, vLLM) via standard localhost:11434 or OpenAI-compatible endpoints. The tool must operate fully offline for maximum privacy and zero latency.

Structured AI Outputs: The backend must use strict JSON Schema forcing when prompting the local model, ensuring the LLM returns perfectly formatted C++ struct definitions, memory layout annotations, offset tables, or analysis scripts without hallucinating invalid syntax.

AI Copilot & Natural-Language Navigation: When a local LLM is connected, the analyst can ask plain-language questions in a persistent Copilot panel (e.g., "Where is the login handler?", "Does an `/admin` route exist?", "Take me to the struct we noted yesterday", "Open the page that handles password reset"). The Copilot does not guess—it queries indexed project state and optional browser attach data, then resolves the best match and navigates the UI on the user's behalf.

Copilot Query Scope: The Local AI can search across function names and pseudocode, renamed symbols, bookmarks, Knowledge Graph notes, captured HTTP traffic and API routes, sitemap/URL inventory from an attached browser, DOM snapshots, recent analysis history, and metadata for files imported via drag-and-drop or File → Open.

Structured Navigation Actions: The LLM returns a strict JSON navigation plan (not free-form clicks), using a fixed action schema such as `navigate_to_function`, `navigate_to_address`, `open_view` (Disassembly / Decompiler / Memory / Traffic / Notes), `browser_goto_url`, `browser_highlight_element`, and `show_search_results`. The UI executor validates every action against the current project before applying it.

Existence & Location Answers: For questions like "Does this page exist?" or "Is there a handler for JWT refresh?", the Copilot returns a concise answer (yes/no/unknown) with evidence links—matching URLs, routes, functions, or xrefs—and offers a one-click "Go there" action that performs the navigation automatically.

Disambiguation UX: When multiple matches are found (e.g., three functions containing `authenticate`), the Copilot presents a ranked picker with context snippets. The user selects one entry or replies "the second one"; the Copilot then navigates without requiring manual menu drilling.

Browser-Aware Go-To: With CDP or the extension bridge attached, the user can ask "Find the settings page" or "Where is the checkout API called from?" The Copilot correlates DOM routes, network logs, and—when available—native call stacks, then opens the correct browser URL or scrolls to the relevant element while syncing the native disassembly view if a correlation exists.

Safety & Confirmations: Navigating to a live URL outside the configured scope allowlist requires explicit confirmation. All Copilot navigation actions are logged in the audit trail with the original prompt, chosen target, and timestamp.

Headless & Batch Mode: A CLI entry point for unattended analysis pipelines (import binary → run scripted passes → export reports), comparable to Ghidra's headless analyzer and IDA's idalib.

Plugin & Extension API: A stable SDK (Rust/C++ core with Python bindings) so third parties can add loaders, analyzers, exporters, and UI panels without forking the core.

2. Static Analysis Engine (Ghidra / IDA Parity)

Multi-Format Loaders: PE, ELF, Mach-O, raw firmware images, and packaged archives. Auto-detect architecture (x86, x64, ARM32, ARM64, WASM where applicable).

Drag-and-Drop File Import: Analysts can drop one or more files directly onto the NexusRE window—main window, welcome screen, or project tree—to import and begin static analysis immediately, identical to Ghidra's drag-to-import and IDA's drag-and-drop loader workflow. No File menu required.

Drop Target & Import Pipeline: A persistent drop zone overlay appears when files are dragged over the app. On drop, NexusRE queues each file, auto-selects the correct loader by magic bytes/extension, pairs companion artifacts dropped together (e.g., `.exe` + `.pdb`, `.elf` + debug link), and runs the standard import → analyze → index pipeline in the background.

Multi-File & Folder Drops: Support dropping multiple binaries at once, `.zip`/archive bundles, and folders (recursive import of supported types). Each item opens as a separate module in the current project or prompts to create a new project when none is open.

Post-Drop Analysis UX: A non-blocking progress tray shows per-file status (detecting format, loading, disassembling, decompiling, indexing). When complete, the first function or entry point is focused automatically; the Copilot can answer questions about the newly imported file ("What does this binary do?", "List exported functions").

Drag-and-Drop Safety: Dropped content is analyzed locally only. Executables are never auto-run on drop—static inspection only unless the analyst explicitly chooses dynamic attach afterward.

Disassembler & Decompiler: Production-grade linear disassembly with a high-level C pseudocode decompiler view. Support rename, retype, comment, and structure definition workflows identical in spirit to Ghidra's Listing/Decompiler and IDA's Hex-Rays.

Symbol & Debug Info: Import PDB, DWARF, and map files. Resolve exports, imports, and demangled C++ names.

Cross-References & Call Graph: Full xref graph (code ↔ data), function call trees, and interactive graph visualization for control-flow and data-flow exploration.

Signature & Library Recognition: FLIRT-style function identification, byte-pattern (AOB) signatures for locating the same logic across builds, and a user-editable type library for common runtimes (CRT, STL, game engines, UI frameworks).

Binary Diffing: Side-by-side comparison of two builds to highlight changed functions, shifted offsets, and patched regions—useful for patch Tuesday analysis and regression triage.

String, Import & Entropy Passes: Automated string extraction, API surface enumeration, packer/obfuscator heuristics, and section entropy scoring.

3. Dynamic Analysis & Runtime Inspection

Live Process Attach: Attach to a user-selected, locally running process with clear consent UI. Default mode is non-invasive read-only memory and module enumeration.

Automated Class & Struct Reconstruction: Monitor heap allocations and parse RTTI (Run-Time Type Information) where present. Rebuild C++ class hierarchies, map virtual function tables (Vtables), and infer field types from memory access patterns—presented as editable struct definitions synced to the static database.

Data-Flow & Taint Analysis: When the analyst selects a networking or serialization routine, trace buffer lifetimes to flag missing bounds checks, integer edge cases, and unvalidated input paths suitable for further manual review.

Pattern & Signature Generation: One-click export of update-resilient byte signatures from any function or address for reuse in future builds or CI regression checks.

Debugger Integration: Breakpoints, single-step, register and stack views, and memory watchpoints—unified with the static database so renamed symbols persist across static and dynamic sessions.

4. Built-In Scripting, Code Extraction & Automation Studio

NexusRE must ship with a first-class scripting environment comparable to Ghidra Scripts and IDA Python, not only export-only workflows.

4.1 Code Extraction

Decompiler Export: Extract function pseudocode, struct headers, enum definitions, and xref lists to C header files, Markdown reports, or JSON analysis bundles.

Selection-Aware Extract: Highlight any address range, basic block, or struct and export exactly that slice—preserving comments, types, and renamed labels.

Batch Extract: Run a script across all functions matching a filter (e.g., imports from `ws2_32.dll`, RTTI class names containing `Network`) and write results to a project folder.

Live Snapshot Export: From a dynamic session, dump reconstructed layouts, register state at a breakpoint, or a memory region as annotated hex + C struct.

4.2 Custom Script Authoring & Execution

Built-In Script Editor: Syntax-highlighted IDE pane supporting Python 3 and an optional Lua DSL, with autocomplete for the NexusRE API (functions, segments, xrefs, types, debugger, traffic logs).

Script Templates Gallery: Starter templates for common tasks—enumerate exports, find string references, decode a protocol struct, diff two versions, generate a call graph PNG, run a custom linter on decompiler output.

One-Click Run & REPL Console: Run the active script against the open project or attached session; interactive REPL for ad-hoc queries (`get_xrefs`, `rename_function`, `read_u32`).

Sandboxed Execution: Scripts run in a restricted interpreter by default (no arbitrary network or filesystem writes outside the project directory unless the user elevates permissions).

Scheduled & Event-Driven Hooks: Scripts can register on events—binary imported, function renamed, breakpoint hit, HTTP request captured—to automate repetitive analyst workflows.

AI-Assisted Script Generation: From any UI selection, ask the Local AI to draft a script (e.g., "list all callers of this API and log argument sizes"). The user reviews and runs it in the Script Editor—nothing executes without explicit approval.

4.3 Instrumentation & Interceptor Scaffolding

Function Interceptor Wizard: When a user highlights a function in the decompiler, offer "Generate Instrumentation Hook" to produce C++ boilerplate (MinHook, Detours, or trampolines) for logging arguments and return values during authorized dynamic analysis.

Analysis Plugin Templates: Exportable C++ or Rust dynamic-analysis modules for in-process tracing, presented as research plugins with clear build instructions—not opaque binaries.

Automation Script Exports: Package findings into Python analysis scripts, annotated C++ tracing stubs, structured JSON for CI, and portable memory-analysis table formats compatible with common RE workflows.

5. The Knowledge Graph Note System

Contextual Scratchpad: A dedicated, markdown-supported note tab directly linked to the analysis workspace.

Live-Linked Assets: Extracted structs, vulnerability findings, and traffic captures embed as clickable anchors. Selecting an offset, function, or URL jumps the main UI to that location in disassembly, decompiler, memory view, or traffic log.

AI Synthesizer: The Local AI reads the full note graph and produces a unified Security & Compatibility Assessment Report summarizing offsets, classes, protocol fields, recommended instrumentation points, and open questions for peer review.

Project Persistence & Versioning: Notes, scripts, types, and bookmarks serialize into a versioned project file; optional Git integration for team review of analysis artifacts (not the target binary itself).

6. UI & Interface Requirements

Synchronized Multi-View: A tear-away, split-pane UI featuring Disassembly, C-Pseudocode, Live Memory Hex Dump, Script Editor, Function Graph, and Knowledge Graph Notes—layout presets modeled on familiar Ghidra/IDA workflows.

Drag-and-Drop Workspace: The entire application shell acts as a valid drop target. An empty workspace shows a centered "Drop files to analyze" prompt with supported format hints (PE, ELF, Mach-O, dumps, archives, PDB/DWARF sidecars). Dragging files over any pane shows a translucent overlay so analysts can drop without switching views.

AI Copilot Panel: A dockable chat sidebar (visible only when a local LLM endpoint is connected) for natural-language questions and navigation commands. Successful resolutions auto-focus the correct pane, scroll to the target line/address/URL, and briefly highlight the destination so the analyst always sees where they were taken.

Bookmarks, History & Annotations: Per-function color tags, analyst comments, and a navigable analysis history trail.

Zero-Lag Asynchronous Design: The UI must never lock up while the backend scans memory, decompiles, or queries the local LLM.

Theming & Accessibility: Dark/light themes, scalable fonts, and keyboard-driven navigation for power users.

7. Web Browser & Network Traffic Integration (Authorized Security Testing)

NexusRE must support optional attachment to web browsers and live network traffic so security researchers can use the same platform for web application assessment, vulnerability validation, and hybrid native/web analysis—always within user-defined scope.

7.1 Browser Attachment Modes

Browser Extension Bridge: A lightweight Chromium/Firefox extension that streams DOM events, JavaScript call stacks, storage access patterns, and WebSocket frames to NexusRE over localhost WebSocket (default port 17890). Enabled only by explicit user action with a one-time pairing token from the desktop app.

DevTools Protocol (CDP) Attach: Attach to Chrome, Edge, or Chromium via CDP for JavaScript breakpoints, network inspection, HAR-like logs, and source-map-aware debugging.

Playwright/Puppeteer Headless Hook: Drive a headless browser for automated regression passes against staging environments; pipe navigation, console output, and requests into the Knowledge Graph.

7.1.1 Copilot Browser Navigation

Indexed Route & Page Inventory: While attached, NexusRE continuously indexes visited URLs, page titles, form actions, anchor text, and API endpoints into a searchable local index the Copilot can query offline.

Ask-to-Navigate Examples: The analyst can type prompts such as "Does a billing page exist?", "Where is the user profile API?", or "Open the page we saw that returns 403"—the Copilot searches the index, answers with evidence, and navigates the attached browser to the matched route or highlights the matching network entry.

Cross-View Sync: When a web page maps to a known native handler (Electron, WebView2, CEF), Copilot navigation opens both the browser location and the linked native function in the decompiler side by side.

7.2 Network Traffic Inspection & Analysis

Local TLS Inspection Proxy: An embedded HTTP/HTTPS proxy (Burp Suite / mitmproxy-class) on localhost. User installs a NexusRE CA once; scoped traffic is decrypted, logged, and indexed.

Process-Scoped Traffic Capture: For desktop apps using WebView2, CEF, or Electron, correlate outbound HTTP/TLS with the native call stack that initiated the request.

Traffic-to-Memory Correlation: Trace suspicious parameter values from captured requests back through the desktop process to the originating buffer, function, and struct.

WebSocket & gRPC Stream Inspection: Decode frames and protobuf messages; flag protocol design issues (missing auth on subscribe, weak token binding, schema mismatch) and generate reproducible validation scripts for the Script Editor.

7.3 Security Assessment Workflows

OWASP-Oriented Traffic Review: Analyze captured traffic and DOM behavior for common web vulnerability classes (injection, XSS, CSRF, IDOR, SSRF, insecure deserialization). Findings link to the Knowledge Graph with curl/Python reproduction steps suitable for responsible disclosure.

API Fuzzing Matrix: Mutate parameters on discovered endpoints; record anomalous responses, status codes, and crash signatures for triage.

Session & Token Analysis: Extract and classify JWTs, cookies, API keys, and OAuth tokens; decode claims and highlight transport or attribute misconfigurations.

Hybrid Application Surface Map: For Electron apps, launchers, and mixed native/web clients, build a unified graph of native modules, IPC channels, and web endpoints—highlighting trust-boundary crossings for manual review.

Compliance & Scope Guardrails: Opt-in capture only; domain/IP allowlists; sensitive field redaction by default; full audit log of attach and proxy actions.

7.4 Integration with Scripting & Notes

Traffic-Aware Scripts: Scripts can iterate captured requests, decode protobuf fields, and cross-link results to native functions.

AI Synthesizer Extension: Reports include a Web Application Surface Summary alongside native findings.

Export Targets: Burp-compatible configs, nuclei templates, ffuf wordlists, and Python `requests` validation scripts—plus direct import into the Built-In Script Editor for editing before run.

8. Recommended Additions (Gap Analysis vs. Ghidra / IDA Pro)

The following items are not yet fully specified above and should be tracked on the roadmap:

| Area | Recommended Inclusion | Priority |
|------|----------------------|----------|
| Emulation | Optional unicorn/QEMU slice for sandboxed execution of untrusted snippets | Medium |
| Firmware / IoT | NAND/NOR dump loaders, partition parsers, base-address rebasing | Medium |
| Collaborative RE | Shared project servers, role-based access, comment threads on functions | High |
| CI/CD Integration | GitHub/GitLab Action to run headless analysis on release artifacts | High |
| YARA Integration | Scan segments and memory regions with user YARA rules | Medium |
| Capstone / LLVM IR | Optional LLVM IR export for advanced optimization research | Low |
| Malware Safe Mode | Detachable analysis VM profile with network disabled by default | High |
| Report Export | PDF/HTML executive summaries for audit and disclosure workflows | Medium |
| License Management | Offline node-locked or floating licenses for enterprise lab deployments | Low |
| Training Mode | Sample binaries and guided labs teaching xref, struct recovery, and scripting | Medium |
| Macro Recorder | Record UI/analysis steps and replay as a script skeleton | Medium |
| Custom Calling Conventions | User-defined ABI for exotic or obfuscated binaries | Medium |
| Unpacker Assist | OEP detection heuristics and staged dump-to-database workflow | High |
| Semantic Search | Embedding-based "find similar functions" across large binaries | High |
| SBOM / Dependency Graph | Map statically linked and dynamically loaded third-party components | Medium |
| Copilot Voice Input | Optional offline speech-to-text for hands-free "go to" commands in the lab | Low |

9. Expected Output Deliverables
Execute this prompt by providing:

Architecture Blueprint: How the Static Analyzer, Dynamic Inspector, Decompiler, Local AI Context Manager, Script Runtime, Browser Bridge, and Traffic Proxy communicate.

AI Orchestration Code: Rust/Python for querying the local LLM API with strict JSON Schema outputs for analysis tasks and validated navigation action plans.

Copilot Navigation Executor: The action schema, index queries (project + browser), disambiguation flow, and UI focus/highlight behavior for ask-to-navigate commands.

Class Reconstruction Algorithm: Foundational code for RTTI/Vtable scanning and struct inference from live memory.

Script Runtime & API Surface: Python/Lua binding design, sandbox model, and example scripts (enumerate functions, extract decompiler code, export headers).

Browser & Traffic Module Design: CDP attach, localhost proxy, and traffic-to-memory correlation pipelines.

UI Layout Scaffold: Frontend framework (React/TypeScript or Qt) for synchronized multi-view, Script Editor, notes, Traffic Inspector panes, and drag-and-drop import overlays.

File Import & Drop Handler: Loader detection, multi-file queue, companion-artifact pairing, and progress-tray UX for dropped files.
