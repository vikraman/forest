{
  description = "A basic flake for building this forest";

  inputs = {
    nixpkgs.url =
      "github:nixos/nixpkgs?ref=9f8a9a2870ea528126a3f2c4f2e5ffd4e37812d3";
    flake-utils.url = "github:numtide/flake-utils";
    ocaml-overlay = {
      url = "github:nix-ocaml/nix-overlays";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ocaml-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ocaml-overlay.overlays.default ];
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs =
            (with pkgs.ocaml-ng.ocamlPackages_5_3; [ ocaml opam dune ])
            ++ (with pkgs; [ texlive.combined.scheme-medium watchman ]);
        };
      });
}
