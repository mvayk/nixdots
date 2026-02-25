{
  description = "mvayk nixos config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:mvayk/noctalia-shell-amoled";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    future-hyprcursor = {
      url = "github:mvayk/nix-future-hyprcursor";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
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
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      sops-nix,
      noctalia,
      plasma-manager,
      future-hyprcursor,
      quickshell,
      zen-browser,
      spicetify-nix,
      ...
    }@inputs:
    let
      hostSystem = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs-stable = import nixpkgs-stable {
        system = hostSystem;
        config.allowUnfree = true;
      };
      extraArgs = {
        inherit
          inputs
          pkgs-stable
          noctalia
          quickshell
          future-hyprcursor
          plasma-manager
          zen-browser
          spicetify-nix
          ;
      };
      mkHost =
        { machine, de }:
        lib.nixosSystem {
          system = hostSystem;
          specialArgs = extraArgs // {
            inherit machine de;
          };
          modules = [
            ./hosts/common.nix
            ./hosts/${machine}/default.nix
            ./hosts/${machine}/hardware.nix
            ./modules/nixos/de/${de}.nix
            sops-nix.nixosModules.sops
            spicetify-nix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = extraArgs // {
                  inherit machine de;
                };
                sharedModules  = [
                    plasma-manager.homeModules.plasma-manager 
                ];
                users.mvayk = import ./users/mvayk/home.nix;
                backupFileExtension = "backup";
              };
            }
            ./users/mvayk/system.nix
          ];
        };
    in
    {
      nixosConfigurations = {
        flandre-hyprland = mkHost {
          machine = "flandre";
          de = "hyprland";
        };
        flandre-kde = mkHost {
          machine = "flandre";
          de = "kde";
        };
        flandre-gnome = mkHost {
          machine = "flandre";
          de = "gnome";
        };
        flandre-xfce = mkHost {
          machine = "flandre";
          de = "xfce";
        };
        remilia-hyprland = mkHost {
          machine = "remilia";
          de = "hyprland";
        };
        remilia-kde = mkHost {
          machine = "remilia";
          de = "kde";
        };
        remilia-gnome = mkHost {
          machine = "remilia";
          de = "gnome";
        };
        remilia-xfce = mkHost {
          machine = "remilia";
          de = "xfce";
        };
      };
    };
}
