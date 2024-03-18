{
  inputs = {
    systems.url = "github:nix-systems/default";
  };
  outputs = { self, nixpkgs, systems }: 
  let
    lib = nixpkgs.lib;
    eachSystem = lib.genAttrs (import systems);
  in {
    packages = eachSystem (system: let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        nixfiles-assets = pkgs.callPackage ./package.nix { };
        default = nixfiles-assets;
      }
    );
    overlays.default = final: prev: {
      inherit (self.outputs.packages.${prev.pkgs.system}) nixfiles-assets;
    };
  };
}
