{
  lib,
  appimageTools,
  fetchurl,
}: let
  pname = "curseforge";
  version = "latest";

  src = fetchurl {
    url = "https://curseforge.overwolf.com/downloads/curseforge-${version}-linux.AppImage";
    hash = "sha256-aljM1fS5P8v9kkklNx05jMmHJDFfUMbUQj231hrAoc8=";
  };

  contents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -Dm444 ${contents}/*.desktop -t $out/share/applications/
      install -Dm444 ${contents}/*.png -t $out/share/icons/hicolor/512x512/apps/

      sed -i 's|^Exec=[^ ]*|Exec=${pname}|' $out/share/applications/*.desktop
    '';

    meta = {
      description = "Curseforge";
      mainProgram = pname;
      platforms = ["x86_64-linux"];
      license = lib.licenses.unfree;
    };
  }
