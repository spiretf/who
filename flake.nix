{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/release-24.11";
    spire.url = "github:spiretf/nix";
    spire.inputs.nixpkgs.follows = "nixpkgs";
    spire.inputs.utils.follows = "utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    spire,
  }:
    utils.lib.eachSystem spire.systems (system: let
      overlays = [spire.overlays.default];
      pkgs = (import nixpkgs) {
        inherit system overlays;
      };
      spEnv = pkgs.sourcepawn.buildEnv (with pkgs.sourcepawn.includes; [sourcemod]);
    in {
      packages = rec {
        inherit spEnv;
        sdrconnect = pkgs.buildSourcePawnScript {
          name = "who";
          src = ./plugin/who.sp;
        };
        default = sdrconnect;
      };
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [spEnv];
      };
    });
}
