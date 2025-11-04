{
    description = "NixOS from Scratch";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        quickshell = {
            url = "github:outfoxxed/quickshell";
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
    outputs = { self, nixpkgs, home-manager, noctalia, quickshell, zen-browser,  ... }:
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
                        home-manager.extraSpecialArgs = { inherit noctalia quickshell zen-browser; };
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
                        home-manager.users.mvayk = import ./home/dream_quickshell/home.nix;
                        home-manager.backupFileExtension = "backup";
                        home-manager.extraSpecialArgs = { inherit noctalia quickshell zen-browser; };
                    }
                ];
            };
        };
    };
}
