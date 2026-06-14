{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.profiles.dev = lib.mkEnableOption "media packages";

  config = lib.mkIf config.profiles.media {
    environment.systemPackages = with pkgs; [
      mpv
      ffmpeg
      yt-dlp
      imagemagick
      cheese
      kdePackages.kdenlive
      krita
      audacity
      cmus
      ani-cli
      libreoffice-qt-fresh
      zathura
      foliate
      calibre
      kdePackage.okular
      #texlive.combined.scheme-medium
      ffmpegthumbnailer
      poppler-utils
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.victor-mono
      nerd-fonts.space-mono
      nerd-fonts.symbols-only
      noto-fonts-cjk-sans
      nerd-fonts._3270
      nerd-fonts.terminess-ttf
      nerd-fonts.bigblue-terminal
    ];
  };
}
