# Simple Neovim Configuration

A simple, powerful, plugin-free Neovim configuration powered by built-in LSP support and Tree-sitter.

## Installation

1. Clone this repository.
2. Link it to `~/.config/nvim`.
3. Install the language servers you need (for example: `pyright`, `rust-analyzer`, `typescript-language-server`, `stylua`, etc.).
4. Install the formatters you want to use (for example: `black`, `rustfmt`, `prettier`, etc.).
5. Install `xclip` to enable clipboard integration on X11.

## Syntax Highlighting

Tree-sitter highlighting is disabled by default. Enable it for the current buffer with:

```vim
:lua vim.treesitter.start()
```

## Installing a New Tree-sitter Parser

1. Install `tree-sitter-cli`.
2. Clone the official Tree-sitter grammar for the language.
3. Enter the repository and install its dependencies:

   ```sh
   npm install
   ```

4. Generate and build the parser:

   ```sh
   tree-sitter generate
   tree-sitter build
   ```

   Some repositories contain multiple parsers (for example, `tree-sitter-typescript`). If the build fails, enter the appropriate subdirectory first (such as `typescript/`).

5. Copy the generated `.so` file into the `parser/` directory of this repository. Rename it to match the language name if necessary (for example, `typescript.so`).
6. Open a file of that language and enable Tree-sitter:

   ```vim
   :lua vim.treesitter.start()
   ```

If highlighting is incomplete or missing, the language is probably missing its queries.

## Installing Tree-sitter Queries

Most queries in this repository were copied from the official `nvim-treesitter` project. New languages can be added directly from their Tree-sitter grammar repositories.

1. Open the language's official Tree-sitter grammar repository.
2. Copy its `queries/` directory into `queries/<language>/` in this repository.
3. Check every `inherits:` directive inside the query files.
4. If an inherited query is missing, copy the corresponding queries from the appropriate Tree-sitter grammar as well.

Once the parser and queries are installed, the language should work without any additional plugins.
