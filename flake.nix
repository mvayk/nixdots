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
            #inputs.quickshell.follows = "quickshell";
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
            homeManagerExtraSpecialArgs = { inherit noctalia zen-browser quickshell spicetify-nix matugen; };
        in {
            nixosConfigurations = {
                desktop = nixpkgs.lib.nixosSystem {
                    inherit system;
                    inherit specialArgs;
                    modules = [
                        ./common/configuration.nix
                        ./machines/desktop/configuration.nix
                        ./machines/desktop/hardware-configuration.nix
                        spicetify-nix.nixosModules.default
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.mvayk = import ./machines/desktop/home.nix;
                            home-manager.backupFileExtension = "backupbackup";
                            home-manager.extraSpecialArgs = homeManagerExtraSpecialArgs;
                        }
                    ];
                };
                
                laptop = nixpkgs.lib.nixosSystem {
                    inherit system;
                    inherit specialArgs;
                    modules = [
                        ./common/configuration.nix
                        ./machines/laptop/configuration.nix
                        ./machines/laptop/hardware-configuration.nix
                        spicetify-nix.nixosModules.default
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.mvayk = import ./machines/laptop/home.nix;
                            home-manager.backupFileExtension = "backup";
                            home-manager.extraSpecialArgs = homeManagerExtraSpecialArgs;
                        }
                    ];
                };
            };
        };
}
