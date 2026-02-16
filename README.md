# NATO Phonetic Alphabet Converter

A clean, simple web application that converts text to NATO phonetic alphabet in real-time. Built with Elm 0.19.1.

**🔗 Live Demo:** [https://kkweon.dev/nato-phonetic-elm/](https://kkweon.dev/nato-phonetic-elm/)

![Desktop Screenshot](docs/screenshot-desktop.png)

## Features

- ✨ **Real-time conversion** - See phonetic alphabet as you type
- 📱 **Responsive design** - Works on mobile, tablet, and desktop
- 📖 **Desktop cheatsheet** - Quick reference sidebar on larger screens
- 🎯 **Simple & focused** - No distractions, just the conversion you need
- ⌨️ **Keyboard shortcuts** - Press ESC to clear input

## Usage

Simply type any text into the input field and instantly see it converted to NATO phonetic alphabet. Perfect for:

- Radio communication
- Customer service (spelling names, confirmation codes)
- Military and aviation operations
- Clear verbal communication over phone

## Development

### Prerequisites

- [Elm 0.19.1](https://guide.elm-lang.org/install/elm.html)
- Python 3 (for dev server)
- Optional: [elm-live](https://github.com/wking-io/elm-live) for auto-reload

### Setup

```bash
# Clone the repository
git clone https://github.com/kkweon/nato-phonetic-elm.git
cd nato-phonetic-elm

# Start development server
make dev

# Or with auto-reload (requires elm-live)
npm install -g elm-live
make dev
```

Navigate to http://localhost:8000 to view the app.

### Build Commands

```bash
make dev         # Start dev server (with auto-reload if elm-live installed)
make build       # Compile to docs/js/main.js (unoptimized)
make build-prod  # Production build with optimizations + updates sitemap
make clean       # Remove built JavaScript files
```

### Project Structure

```
nato-phonetic-elm/
├── src/
│   ├── Main.elm           # Main application logic and UI
│   └── NatoPhonetic.elm   # NATO phonetic alphabet dictionary
├── docs/                  # GitHub Pages deployment directory
│   ├── index.html         # HTML entry point
│   └── js/main.js         # Compiled Elm application
├── Makefile              # Build commands
└── README.md
```

## Technologies

- **[Elm](https://elm-lang.org/)** - Functional language for reliable web apps
- **[Tailwind CSS](https://tailwindcss.com/)** - Utility-first CSS framework
- **GitHub Pages** - Free hosting

## License

MIT

## Contributing

Issues and pull requests are welcome! Feel free to contribute improvements or report bugs.

---

Made with ❤️ using Elm
