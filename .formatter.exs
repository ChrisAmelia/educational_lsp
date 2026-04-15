# Used by "mix format"
Code.require_file(".formatter-config.exs", __DIR__)

[
  plugins: [Quokka],
  quokka: Formatter.Config.quokka(),
  locals_without_parens: [],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"]
]
