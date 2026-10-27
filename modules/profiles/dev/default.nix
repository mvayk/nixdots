{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.dev;
in {
  imports = [./languages.nix ./editors.nix ./libs.nix];

  options.my.dev = {
    enable = lib.mkEnableOption "dev environment";
    tools.enable = mkSub cfg.enable "direnv, nix-direnv, tree-sitter, libfaketime";
    docs.enable = mkSub cfg.enable "man pages and developer documentation";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.tools.enable {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      environment.systemPackages = with pkgs; [tree-sitter libfaketime];
    })

    (lib.mkIf cfg.docs.enable {
      documentation = {
        enable = true;
        man.man-db.enable = true;
        dev.enable = true;
      };
    })
  ];
}
