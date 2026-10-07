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
      url = "github:noctalia-dev/noctalia-shell";
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
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kwin-effects-glass = {
      url = "github:4v3ngR/kwin-effects-glass";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    future-hyprcursor.url = "github:mvayk/nix-future-hyprcursor";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-nightly = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    sops-nix,
    spicetify-nix,
    niri,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    pkgs-stable = import nixpkgs-stable {localSystem = system;};
    sharedArgs = inputs // {inherit inputs pkgs-stable;};

    valid = {
      machines = ["flandre" "coerxion"];
      des = ["hyprland" "niri" "kde" "gnome" "xfce" "cinnamon"];
      themes = ["default" "noctalia" "dank" "custom"];
    };

    niriModuleThemes = ["noctalia" "default"];

    check = label: allowed: value:
      lib.throwIfNot (builtins.elem value allowed)
      "${label}: '${value}' must be one of [ ${lib.concatStringsSep " " allowed} ]"
      value;

    mkHost = {
      machine,
      de,
      theme,
    }: let
      c = {
        machine = check "machine" valid.machines machine;
        de = check "de" valid.des de;
        theme = check "theme" valid.themes theme;
      };

      useNiriModule = c.de == "niri" || builtins.elem c.theme niriModuleThemes;
    in
      lib.nixosSystem {
        specialArgs = sharedArgs // c;
        modules = [
          {nixpkgs.hostPlatform = system;}
          ./hosts/${c.machine}/default.nix
          ./hosts/${c.machine}/hardware.nix
          ./modules/features/${c.de}.nix
          ./modules/overlays.nix
          sops-nix.nixosModules.sops
          spicetify-nix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = sharedArgs // c;
              backupFileExtension = "backup";
              sharedModules = lib.optional useNiriModule niri.homeModules.niri;
              users.mvayk = import ./users/mvayk/home.nix;
            };
          }
          ./users/mvayk/system.nix
        ];
      };

    host = machine: de: theme: {inherit machine de theme;};

    hostName = {
      machine,
      de,
      theme,
    }:
      lib.concatStringsSep "-" ([machine de] ++ lib.optional (theme != "default") theme);

    hostSpecs = [
      (host "coerxion" "xfce" "default")
      (host "coerxion" "gnome" "default")
      (host "coerxion" "kde" "default")
      (host "coerxion" "niri" "default")
      (host "coerxion" "niri" "dank")
      (host "coerxion" "hyprland" "default")
      (host "coerxion" "hyprland" "noctalia")

      (host "flandre" "xfce" "default")
      (host "flandre" "gnome" "default")
      (host "flandre" "kde" "default")
      (host "flandre" "cinnamon" "default")
      (host "flandre" "niri" "default")
      (host "flandre" "niri" "noctalia")
      (host "flandre" "niri" "dank")
      (host "flandre" "hyprland" "noctalia")
      (host "flandre" "hyprland" "dank")
    ];

    hosts = lib.listToAttrs (map (h: lib.nameValuePair (hostName h) h) hostSpecs);
  in {
    nixosConfigurations = lib.mapAttrs (_: mkHost) hosts;
  };
}
