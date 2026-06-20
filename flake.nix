{
  description = "mvayk nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:mvayk/noctalia-shell-amoled";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };
    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # mshell = {
    #   url = "path:/home/mvayk/dev/mshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    future-hyprcursor.url = "github:mvayk/nix-future-hyprcursor";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    sops-nix,
    noctalia,
    future-hyprcursor,
    quickshell,
    zen-browser,
    helium,
    spicetify-nix,
    niri,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    pkgs-stable = import nixpkgs-stable {
      localSystem = system;
    };

    sharedArgs = {
      inherit
        inputs
        pkgs-stable
        noctalia
        quickshell
        future-hyprcursor
        zen-browser
        helium
        spicetify-nix
        ;
    };

    valid = {
      machines = ["flandre" "coerxion"];
      des = ["hyprland" "niri" "kde" "gnome" "xfce"];
      themes = ["default" "noctalia" "custom"];
    };

    niriModuleThemes = ["noctalia" "default"];

    check = value: allowed: label:
      assert lib.assertMsg
      (builtins.elem value allowed)
      "${label}: '${value}' must be one of [ ${lib.concatStringsSep " " allowed} ]"; value;

    mkHost = {
      machine,
      de,
      theme,
    }: let
      _m = check machine valid.machines "machine";
      _d = check de valid.des "de";
      _t = check theme valid.themes "theme";

      hostArgs = sharedArgs // {inherit machine de theme;};

      useNiriModule = de == "niri" || builtins.elem theme niriModuleThemes;
    in
      lib.nixosSystem {
        specialArgs = hostArgs;
        modules = [
          {nixpkgs.hostPlatform = system;}
          ./hosts/${machine}/default.nix
          ./hosts/${machine}/hardware.nix
          ./modules/features/${de}.nix
          sops-nix.nixosModules.sops
          spicetify-nix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = hostArgs;
              backupFileExtension = "backup";
              sharedModules = lib.optionals useNiriModule [
                niri.homeModules.niri
              ];
              users.mvayk = import ./users/mvayk/home.nix;
            };
          }
          ./users/mvayk/system.nix
        ];
      };

    hosts = {
      flandre-hyprland = {
        machine = "flandre";
        de = "hyprland";
        theme = "default";
      };
      flandre-niri = {
        machine = "flandre";
        de = "niri";
        theme = "default";
      };
      flandre-kde = {
        machine = "flandre";
        de = "kde";
        theme = "default";
      };
      flandre-gnome = {
        machine = "flandre";
        de = "gnome";
        theme = "default";
      };
      flandre-xfce = {
        machine = "flandre";
        de = "xfce";
        theme = "default";
      };

      coerxion-niri-noctalia = {
        machine = "coerxion";
        de = "niri";
        theme = "noctalia";
      };
      coerxion-niri = {
        machine = "coerxion";
        de = "niri";
        theme = "default";
      };
      coerxion-hyprland-noctalia = {
        machine = "coerxion";
        de = "hyprland";
        theme = "noctalia";
      };
      coerxion-kde = {
        machine = "coerxion";
        de = "kde";
        theme = "default";
      };
      coerxion-xfce = {
        machine = "coerxion";
        de = "xfce";
        theme = "default";
      };
      coerxion-gnome = {
        machine = "coerxion";
        de = "gnome";
        theme = "default";
      };
    };
  in {
    nixosConfigurations = lib.mapAttrs (_: mkHost) hosts;
  };
}
