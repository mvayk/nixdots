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
    tools.enable = mkSub cfg.enable "koboldcpp, aichat, opencode opencode-desktop";
    dev.enable = mkSub cfg.enable "opencode-desktop opencode";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.ollama.enable {services.ollama.enable = true;})
    (lib.mkIf cfg.tools.enable {
      environment.systemPackages = with pkgs; [koboldcpp aichat];
    })
    (lib.mkIf cfg.dev.enable {
      environment.systemPackages = with pkgs; [opencode opencode-desktop];
    })
  ];
}
