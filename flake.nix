{
    description = "NixOS from Scratch";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        
        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        caelestia-cli = {
            url = "github:caelestia-dots/cli";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        caelestia-shell = {
            url = "github:caelestia-dots/shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.quickshell.follows = "quickshell";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake/beta";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        dgop = {
            url = "github:AvengeMedia/dgop";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        dms-cli = {
            url = "github:AvengeMedia/danklinux";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        dankMaterialShell = {
            url = "github:AvengeMedia/DankMaterialShell";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.dgop.follows = "dgop";
            inputs.dms-cli.follows = "dms-cli";
        };
    };
    outputs = { self, nixpkgs, home-manager, noctalia, quickshell, zen-browser, dankMaterialShell, dgop, dms-cli, caelestia-shell, caelestia-cli, ... }:
        let
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
            desktop = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./configuration.nix
                    ./machines/desktop/hardware-configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.mvayk = import ./home/icbm/home.nix;
                        home-manager.backupFileExtension = "backupbackup";
                        home-manager.extraSpecialArgs = { inherit noctalia zen-browser quickshell dankMaterialShell caelestia-shell caelestia-cli; };
                    }
                ];
            };
            
            laptop = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { inherit zen-browser; };
                modules = [
                    ./configuration.nix
                    ./machines/laptop/hardware-configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.mvayk = import ./home/kde/home.nix;
                        home-manager.backupFileExtension = "backup";
                        home-manager.extraSpecialArgs = { inherit noctalia zen-browser quickshell dankMaterialShell caelestia-shell caelestia-cli; };
                    }
                ];
            };
        };
    };
}
