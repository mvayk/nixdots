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
    noctalia-amoled = {
      url = "github:mvayk/noctalia-shell-amoled";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    /*
      plasma-manager = {
        url = "github:nix-community/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
      };
    */
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
    niri-blur = {
      url = "github:niri-wm/niri/wip/branch";
      flake = false;
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      # inputs.niri.follows = "niri-blur";
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
      caelestia-shell,
      # plasma-manager,
      future-hyprcursor,
      quickshell,
      zen-browser,
      spicetify-nix,
      niri,
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
          caelestia-shell
          quickshell
          future-hyprcursor
          # plasma-manager
          zen-browser
          spicetify-nix
          ;
      };
      mkHost =
        {
          machine,
          de,
          theme,
        }:
        lib.nixosSystem {
          system = hostSystem;
          specialArgs = extraArgs // {
            inherit
              machine
              de
              theme
              ;
          };
          modules = [
            ./hosts/common.nix
            ./hosts/${machine}/default.nix
            ./hosts/${machine}/hardware.nix
            ./modules/nixos/de/${de}.nix
            sops-nix.nixosModules.sops
            spicetify-nix.nixosModules.default
            home-manager.nixosModules.home-manager
            # niri.nixosModules.niri
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = extraArgs // {
                  inherit
                    machine
                    de
                    theme
                    ;
                };
                sharedModules = [
                  #plasma-manager.homeModules.plasma-manager
                ]
                ++
                  lib.optionals
                    (
                      theme == "noctalia"
                      || theme == "dms"
                      || theme == "noctalia"
                      || theme == "noctalia-glass"
                      || theme == "blackmetal"
                    )
                    [
                      niri.homeModules.niri
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
          theme = "default";
        };
        flandre-hyprland-noctalia = mkHost {
          machine = "flandre";
          de = "hyprland";
          theme = "noctalia";
        };
        flandre-hyprland-caelestia = mkHost {
          machine = "flandre";
          de = "hyprland";
          theme = "caelestia";
        };
        flandre-niri-noctalia = mkHost {
          machine = "flandre";
          de = "niri";
          theme = "noctalia";
        };
        flandre-niri-noctalia-glass = mkHost {
          machine = "flandre";
          de = "niri";
          theme = "noctalia-glass";
        };
        flandre-niri-dms = mkHost {
          machine = "flandre";
          de = "niri";
          theme = "dms";
        };
        flandre-niri-blackmetal = mkHost {
          machine = "flandre";
          de = "niri";
          theme = "blackmetal";
        };
        flandre-kde = mkHost {
          machine = "flandre";
          de = "kde";
          theme = "default";
        };
        flandre-gnome = mkHost {
          machine = "flandre";
          de = "gnome";
          theme = "default";
        };
        flandre-xfce = mkHost {
          machine = "flandre";
          de = "xfce";
          theme = "default";
        };
      };
    };
}
