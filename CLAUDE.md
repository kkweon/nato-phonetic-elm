# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A simple Elm web application that converts text input into NATO phonetic alphabet equivalents in real-time. Built with Elm 0.19.1.

**Production URL:** https://kkweon.dev/nato-phonetic-elm/

## Development Commands

```bash
make dev         # Start elm reactor dev server at http://localhost:8000
make build       # Compile Elm to docs/js/main.js (fast, unoptimized)
make build-prod  # Production build: optimized + updates sitemap.xml
make clean       # Remove built JavaScript files
```

For development: navigate to http://localhost:8000/src/Main.elm after running `make dev`.

## Architecture

**Two-module structure:**
- `src/Main.elm` - Main application with Browser.sandbox setup, input handling, and view rendering
- `src/NatoPhonetic.elm` - Dictionary mapping characters to NATO phonetic words

**Build output:**
- Compiles to `docs/js/main.js` (not `dist/` or `build/`)
- The `docs/` directory is used for GitHub Pages hosting
- `docs/index.html` embeds the Elm app and handles initialization

## Important Notes

- This is a simple Browser.sandbox application (no commands or subscriptions)
- Build output must go to `docs/` directory for GitHub Pages compatibility
- The app uses a Dict-based lookup for character-to-phonetic-word conversion

## Git Conventions

Use [Conventional Commits](https://www.conventionalcommits.org/) format:

```
<type>(<scope>): <subject>

<body>
```

**Types:** feat, fix, docs, style, refactor, test, chore
