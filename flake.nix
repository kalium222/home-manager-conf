{
    description = "nix config";

    inputs = {
        nixpkgs.url = "nixpkgs";
        home-manager = {
            url = "home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ nixpkgs, home-manager, ... }: {
        homeConfigurations.Kalium = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs; };
            modules = [ ./home.nix ];
        };
    };
}
