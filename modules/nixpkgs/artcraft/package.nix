{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "artcraft-launcher";
  version = "0.19.2";

  src = fetchurl {
    url = "https://github.com/storytold/craft-launcher/releases/download/v${version}/artcraft-launcher-${version}-linux-x86_64.AppImage";
    hash = "sha256-AhgImRbWC00oiCXRVC8Tyyyl+2kUGPQQIgH0OoTRvns=";
  };

  contents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -Dm444 ${contents}/*.desktop -t $out/share/applications/
      install -Dm444 ${contents}/*.png -t $out/share/icons/hicolor/512x512/apps/

      sed -i 's|^Exec=.*|Exec=${pname} %U|' $out/share/applications/*.desktop
    '';

    meta = {
      description = "Artcraft Launcher";
      mainProgram = pname;
      platforms = ["x86_64-linux"];
    };
  }
