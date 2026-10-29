{
  pkgs,
  lib,
  config,
  ...
}: {
  options.my.fonts.enable = lib.mkEnableOption "desktop sets by default";

  config = lib.mkIf config.my.fonts.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.victor-mono
      nerd-fonts.daddy-time-mono
      nerd-fonts.mononoki
      nerd-fonts.space-mono
      nerd-fonts.symbols-only
      nerd-fonts._3270
      nerd-fonts.terminess-ttf
      nerd-fonts.bigblue-terminal
      nerd-fonts.comic-shanns-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      liberation_ttf
      dejavu_fonts
      font-awesome
      unifont
    ];
  };
}
