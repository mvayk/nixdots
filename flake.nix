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
    };
    outputs = { self, nixpkgs, home-manager, noctalia, quickshell, ... }:
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
                        home-manager.backupFileExtension = "backup";
                        home-manager.extraSpecialArgs = { inherit noctalia quickshell; };
                    }
                ];
            };
            
            laptop = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./configuration.nix
                    ./machines/laptop/hardware-configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.mvayk = import ./home/dream_quickshell/home.nix;
                        home-manager.backupFileExtension = "backup";
                        home-manager.extraSpecialArgs = { inherit noctalia quickshell; };
                    }
                ];
            };
        };
    };
}
