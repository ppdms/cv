{
  description = "LaTeX resume environment for Jake's template";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      devShells = forAllSystems (system: {
        default = (pkgsFor system).mkShell {
          buildInputs = [
            (pkgsFor system).poppler-utils # pdftoppm for README render
            ((pkgsFor system).texlive.combine {
              inherit ((pkgsFor system).texlive)
                scheme-small # base LaTeX + engines
                latexmk # build tool
                collection-latex # LaTeX base (size11.clo, etc.)
                titlesec # section formatting
                enumitem # compact lists
                hyperref # PDF metadata + links
                xcolor # colors
                fancyhdr # headers/footers
                fontspec
                fontawesome5 # header contact icons
                # NB: do NOT add texlive's `inter` here — it ships Inter v3
                # into the texmf tree, which shadows other installs during
                # name-based font lookup. Fonts are vendored in ./fonts/ and
                # loaded by path instead.
                ;
            })
          ];
        };
      });
    };
}
