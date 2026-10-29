{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.media;
in {
  options.my.media = {
    enable = lib.mkEnableOption "media";
    tools.enable = mkSub cfg.enable "ffmpeg, yt-dlp, imagemagick, poppler";
    players.enable = mkSub cfg.enable "mpv, vlc, webcam";
    creative.enable = mkSub cfg.enable "kdenlive, krita, audacity";
    documents.enable = mkSub cfg.enable "office suites, pdf/ebook readers";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.tools.enable {
      environment.systemPackages = with pkgs; [ffmpeg yt-dlp imagemagick poppler-utils];
    })
    (lib.mkIf cfg.players.enable {
      environment.systemPackages = with pkgs; [mpv vlc cheese ffmpegthumbnailer];
    })
    (lib.mkIf cfg.creative.enable {
      environment.systemPackages = with pkgs; [kdePackages.kdenlive krita audacity];
    })
    (lib.mkIf cfg.documents.enable {
      environment.systemPackages = with pkgs; [
        libreoffice-qt
        onlyoffice-desktopeditors
        #zathura
        foliate
        #calibre
        kdePackages.okular
        #texlive.combined.scheme-medium
      ];
    })
  ];
}
