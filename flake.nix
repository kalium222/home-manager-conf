{
  description = "nix config";

  inputs = {
    nixpkgs.url = "nixpkgs";
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      mkHomeConfig =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home.nix ];
        };
    in
    {
      homeConfigurations = {
        Kalium = mkHomeConfig "x86_64-linux";
        Kalium-aarch = mkHomeConfig "aarch64";
      };
    };
}
