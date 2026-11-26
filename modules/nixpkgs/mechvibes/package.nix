{
  appimageTools,
  fetchurl,
}: let
  pname = "mechvibes";
  version = "3.5.11";

  src = fetchurl {
    url = "https://github.com/hainguyents13/mechvibes/releases/download/v${version}/mechvibes-${version}-x86_64.AppImage";
    hash = "sha256-aFoHKXkZTnbTOgoxH1CNyESPjeRAxdbpUA5Jor7K9X4=";
  };

  appimageContents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs = pkgs:
      with pkgs; [
        webkitgtk_4_1
        libsoup_3
        libayatana-appindicator
        alsa-lib
      ];

    extraInstallCommands = ''
      # Menu entry
      install -Dm444 ${appimageContents}/*.desktop -t $out/share/applications
      sed -i 's|^Exec=.*|Exec=${pname} %U|' $out/share/applications/*.desktop

      # Icons
      if [ -d ${appimageContents}/usr/share/icons ]; then
        mkdir -p $out/share
        cp -r ${appimageContents}/usr/share/icons $out/share/
      fi
    '';
  }
