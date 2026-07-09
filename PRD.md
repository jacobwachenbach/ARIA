The v2 Master Architecture Prompt
Copy and paste this into your target AI. It leaves zero ambiguity about the automation, game-specific capabilities, and local AI integration.

System Role & Objective
Act as a Principal Systems Architect, Senior Game Hacker, and Cybersecurity Expert. Your objective is to architect and generate the complete application for "NexusRE", a next-generation, AI-native reverse engineering and dynamic analysis platform.

NexusRE must be 10x faster and more capable than Ghidra/IDA Pro by seamlessly merging static binary analysis with dynamic memory scanning, specifically tuned for complex desktop applications and modern games. It must feature a deeply integrated Local AI Orchestration layer to automate structural reversing, vulnerability discovery, and payload generation.

Product Requirements Document (PRD)

1. Core Architecture & Local AI Integration

Engine Stack: Rust or modern C++ backend for memory safety, multi-threading, and hardware-accelerated memory scanning (reading/writing to live processes).

Local AI Orchestration: Implement an inference abstraction layer designed to hook directly into local LLMs (e.g., Ollama, LM Studio, vLLM) via standard localhost:11434 or OpenAI-compatible endpoints. The tool must operate fully offline for maximum privacy and zero latency.

Structured AI Outputs: The backend must use strict JSON Schema forcing when prompting the local model, ensuring the LLM returns perfectly formatted C++ structs, memory offsets, or Python scripts without hallucinating invalid syntax.

2. Game & Desktop Automation (The 10x Features)

Automated Class & Struct Reconstruction: The system must actively monitor live heap allocations and parse RTTI (Run-Time Type Information). It should automatically rebuild complex C++ class hierarchies (like an Entity or PlayerBase class), map out virtual function tables (Vtables), and guess variable types based on memory access patterns.

Dynamic Weak Point Discovery: The AI must perform automated taint analysis. If I select a game's networking function, the AI traces the packet buffer to identify unchecked bounds, integer overflows, logic flaws, or ideal memory injection points.

Pattern & Signature Generation: One-click automation to take any function or memory address and generate a robust, update-resilient byte signature (AOB) to locate it in future updates.

3. Script & Payload Generation Matrix

Instant Hook Generation: When a user highlights a function in the decompiler, the tool must offer a "Generate Hook" context menu. The AI will instantly write the exact C++ boilerplate (using MinHook, Detours, or custom trampolines) to intercept that function.

Custom Script Exports: The AI must be able to compile its findings into extractable scripts. Target outputs include Python automation scripts, C++ DLL injection templates, GSC-style logic mappings, and Cheat Engine .CT table XML formats.

4. The Knowledge Graph Note System

Contextual Scratchpad: A dedicated, markdown-supported note tab that is directly linked to the RE workspace.

Live-Linked Assets: If the AI extracts a player class struct or finds a vulnerability, it can be embedded into a note. Clicking the offset or function name inside the note instantly jumps the main UI to that exact location in the disassembly or live memory view.

AI Synthesizer: The AI can read the user's entire note tab and generate a unified "Exploit/Modding Strategy Report" summarizing all found offsets, classes, and recommended hook points.

5. UI & Interface Requirements

Synchronized Multi-View: A tear-away, split-pane UI featuring Disassembly, C-Pseudocode, Live Memory Hex Dump, and the Knowledge Graph Notes.

Zero-Lag Asynchronous Design: The UI must never lock up while the backend scans memory or queries the local LLM.

6. Expected Output Deliverables
Execute this prompt by providing:

Architecture Blueprint: Outline how the Memory Scanner, Decompiler, and Local AI Context Manager communicate.

AI Orchestration Code: Provide the Rust/Python code for querying the local LLM API and enforcing a strict JSON output schema for reversing tasks.

Class Reconstruction Algorithm: The foundational code for scanning live memory to detect and map C++ Vtables and player structures.

UI Layout Scaffold: The frontend framework (React/TypeScript or Qt) for the synchronized multi-view and note-taking tab.