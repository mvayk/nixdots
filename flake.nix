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

    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:epireyn/niri-flake";
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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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
    ...
  } @ inputs: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;

    pkgs-stable = nixpkgs-stable.legacyPackages.${system};

    matrix = {
      coerxion = {
        xfce = ["default"];
        gnome = ["default"];
        kde = ["default"];
        niri = ["dank"];
        hyprland = ["noctalia"];
      };

      flandre = {
        xfce = ["default"];
        gnome = ["default"];
        kde = ["default"];
        cinnamon = ["default"];
        niri = ["noctalia" "dank"];
        hyprland = ["noctalia" "dank"];
        mango = ["noctalia"];
      };
    };

    hostSpecs = lib.flatten (
      lib.mapAttrsToList (
        machine: des:
          lib.mapAttrsToList (
            de: themes:
              map (theme: {inherit machine de theme;}) themes
          )
          des
      )
      matrix
    );

    hostName = {
      machine,
      de,
      theme,
    }:
      lib.concatStringsSep "-" ([machine de] ++ lib.optional (theme != "default") theme);

    sharedArgs = inputs // {inherit inputs pkgs-stable;};

    mkHost = {
      machine,
      de,
      theme,
    } @ spec: let
      args = sharedArgs // spec;
    in
      lib.nixosSystem {
        specialArgs = args;
        modules = [
          {nixpkgs.hostPlatform = system;}

          ./hosts/${machine}/default.nix
          ./modules/features/${de}.nix

          sops-nix.nixosModules.sops
          spicetify-nix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = args;
              backupFileExtension = "backup";
              users.mvayk = import ./users/mvayk/home.nix;
            };
          }

          ./users/mvayk/system.nix
        ];
      };
  in {
    nixosConfigurations = lib.listToAttrs (
      map (spec: lib.nameValuePair (hostName spec) (mkHost spec)) hostSpecs
    );

    #nix fmt
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
