{lib, ...}: {
  imports = [
    ./bundles.nix
    ./cli.nix
    ./desktop.nix
    ./fonts.nix
    ./dev
    ./ai.nix
    ./gaming.nix
    ./media.nix
    ./virtualisation.nix
    ./hardware.nix
    ./network.nix
    ./reversing.nix
  ];

  _module.args.mkSub = default: description:
    lib.mkOption {
      type = lib.types.bool;
      inherit default description;
    };
}
