{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.ai;
in {
  options.my.ai = {
    enable = lib.mkEnableOption "local AI tooling";
    ollama.enable = mkSub cfg.enable "ollama service";
    tools.enable = mkSub cfg.enable "koboldcpp, aichat, opencode";
    gui.enable = mkSub (cfg.enable && config.my.desktop.enable) "opencode-desktop";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.ollama.enable {services.ollama.enable = true;})
    (lib.mkIf cfg.tools.enable {
      environment.systemPackages = with pkgs; [koboldcpp aichat opencode];
    })
    (lib.mkIf cfg.gui.enable {environment.systemPackages = [pkgs.opencode-desktop];})
  ];
}
