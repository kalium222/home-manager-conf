{
    description = "nix config";

    inputs = {
        nixpkgs.url = "nixpkgs";
        home-manager = {
            url = "home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, home-manager, ... }: {
        homeConfigurations.droid = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.aarch64-linux;
            extraSpecialArgs = { inherit inputs; };
            modules = [ ./home.nix ];
        };
    };
}
