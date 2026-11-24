{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
  writeShellScriptBin,
  symlinkJoin,
  makeDesktopItem,
  pkgs,
}: let
  pname = "cheat-engine-trial";
  version = "7.7.1";

  src = fetchurl {
    url = "https://cheatengine.org/download/CheatEngineLinux771.zip";
    hash = "sha256-D7DZBDroVqzeA7W4caLzYn689nSurNBF+G1W2RoH8Xc=";
  };

  icon = fetchurl {
    url = "https://raw.githubusercontent.com/cheat-engine/cheat-engine/master/Cheat%20Engine/images/celogo.png";
    hash = "sha256-MNq3cEvgjE7Jl5isoajMTt2CutdjuvwKidZdM0aYFuo=";
  };

  unwrapped = stdenvNoCC.mkDerivation {
    pname = "${pname}-unwrapped";
    inherit version src;

    nativeBuildInputs = [unzip];
    sourceRoot = ".";
    dontFixup = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/opt/cheat-engine
      cp -r ./* $out/opt/cheat-engine/
      chmod +x $out/opt/cheat-engine/cheatengine-x86_64
      runHook postInstall
    '';
  };

  libs = with pkgs; [
    libsForQt5.qtbase
    libsForQt5.libqtpas
    qt6.qtbase
    qt6Packages.libqtpas
    libxkbcommon
    libxcb
    xcb-util-cursor
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxcb-wm
    libx11
    libxext
    libxi
    libxrender
    libGL
    fontconfig
    freetype
    dbus
    glib
    zlib
    openssl
    libpulseaudio
    libxcrypt-legacy
  ];

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = "Cheat Engine (Trial)";
    icon = pname;
    exec = pname;
    categories = ["Utility"];
  };

  launcher = writeShellScriptBin pname ''
    export QT_QPA_PLATFORM=xcb
    export NIX_LD_LIBRARY_PATH=${lib.makeLibraryPath libs}:$NIX_LD_LIBRARY_PATH
    cd ${unwrapped}/opt/cheat-engine
    exec ./cheatengine-x86_64 "$@"
  '';
in
  symlinkJoin {
    name = "${pname}-${version}";
    paths = [launcher desktopItem];

    postBuild = ''
      install -Dm444 ${icon} $out/share/icons/hicolor/128x128/apps/${pname}.png
    '';

    meta = {
      description = "Trial Cheat Engine";
      mainProgram = pname;
      platforms = ["x86_64-linux"];
      license = lib.licenses.unfree;
    };
  }
