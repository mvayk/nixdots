{
    description = "NixOS from Scratch";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        matugen = {
            url = "github:/InioX/Matugen";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake/beta";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        spicetify-nix = {
            url = "github:Gerg-L/spicetify-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        firefox-nightly = {
            url = "github:nix-community/flake-firefox-nightly";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = { self, nixpkgs, home-manager, noctalia, quickshell, zen-browser, spicetify-nix, firefox-nightly, matugen, ... }:
        let
        system = "x86_64-linux";
        specialArgs = { inherit zen-browser spicetify-nix firefox-nightly; };
        mkNixosConfig = { machine, theme }: nixpkgs.lib.nixosSystem {
            inherit system specialArgs;
            modules = [
                ./common/configuration.nix
                ./machines/${machine}/configuration.nix
                ./machines/${machine}/hardware-configuration.nix
                ./modules/options.nix
                spicetify-nix.nixosModules.default
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.mvayk = import ./home/${theme}/base.nix;
                    home-manager.backupFileExtension = "backup";
                    home-manager.extraSpecialArgs = { 
                        inherit noctalia zen-browser quickshell spicetify-nix matugen machine; 
                    };
                }
            ];
        };
    in {
        nixosConfigurations = {
            desktop-noctalia-kanagawa = mkNixosConfig {
                machine = "desktop";
                theme = "hypr-noctalia-kanagawa";
            };
            laptop-noctalia-kanagawa = mkNixosConfig {
                machine = "laptop";
                theme = "hypr-noctalia-kanagawa";
            };
        };
    };
}
