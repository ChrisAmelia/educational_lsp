# EducationalLSP

Server implementing the [Language Server Protocol (LSP)](https://microsoft.github.io/language-server-protocol/) for learning purposes.

## Purpose

It is intended to be used on a file written in English.

## Prequiresites

As of writing,

```
elixir -v
Elixir 1.19.5 (compiled with Erlang/OTP 28)
```

```
mix -v
Mix 1.19.5 (compiled with Erlang/OTP 28)
```

```
sdcv -v
Console version of Stardict, version 0.5.5
```

## Build the server

Build the server with:

```
mix escript.build
```

It produces an executable `educational_lsp`.

## Run the server in Neovim

```lua
vim.lsp.config('educationalsp', {
  cmd = { '/path/to/educational_lsp' },
  filetypes = { 'markdown' },
})

vim.lsp.enable('educationalsp')
```

## Features

### Definition

Provide the definition of the word by using the hover request, in Neovim, by default, press `K` (`vim.lsp.buf.hover()`) in normal mode.  
Under the hood, this is done by using [sdcv](https://wiki.archlinux.org/title/Sdcv).

### Diagnostics

Provide an error diagnostic when `VS Code` is present in the document.

## Acknowledgement

Thanks to https://github.com/tjdevries for explaining how to implement the LSP,
check https://www.youtube.com/watch?v=YsdlcQoHqPY
