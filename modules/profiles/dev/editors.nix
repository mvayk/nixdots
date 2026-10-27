{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.dev;
in {
  options.my.dev = {
    editors.terminal.enable = mkSub cfg.enable "neovim + spellcheck";
    editors.gui.enable = mkSub (cfg.enable && config.my.desktop.enable) "neovide, zed, vscodium, mousepad, IntelliJ";
    emacs.enable = mkSub cfg.enable "emacs daemon";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.editors.terminal.enable {
      environment = {
        systemPackages = with pkgs; [neovim-unwrapped ispell];
        variables.EDITOR = lib.mkOverride 900 "nvim";
      };
    })

    (lib.mkIf cfg.editors.gui.enable {
      environment.systemPackages = with pkgs; [neovide zed-editor vscodium mousepad jetbrains.idea];
    })

    (lib.mkIf cfg.emacs.enable {
      services.emacs = {
        enable = true;
        package = pkgs.emacs;
      };
    })
  ];
}
