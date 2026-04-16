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

This produces an executable `educational_lsp`.

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
Under the hood, this is done by querying [Free Dictionary API](https://dictionaryapi.dev/) (default) or using [sdcv](https://wiki.archlinux.org/title/Sdcv).  
This behavior can be configured by changing the value of `priv/config.json` to `"dictionaryapi"` or `"sdcv"`.

### Diagnostics

Provide an error diagnostic when `VS Code` is present in the document.

### Completions

Provide words to suggest based on a list of words.
This can be configured by changing the content of `priv/words.txt`.

### Code Actions

When `VS Code` is present, suggest these actions:

1. Replace `VS Code` with Neovim.
1. Censor `VS Code` to `VS C*de`.

## Acknowledgement

Thanks to https://github.com/tjdevries for explaining how to implement the LSP,
check https://www.youtube.com/watch?v=YsdlcQoHqPY
