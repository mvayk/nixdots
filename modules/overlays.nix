{
  config,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      stable = import inputs.nixpkgs-stable {
        inherit (prev.stdenv.hostPlatform) system;
        config = config.nixpkgs.config;
      };
    })

    (final: prev: {
      trilium-desktop = prev.trilium-desktop.overrideAttrs (old: rec {
        version = "0.107.0";
        src = prev.fetchurl {
          url = "https://github.com/TriliumNext/Trilium/releases/download/v${version}/TriliumNotes-v${version}-linux-x64.zip";
          hash = "sha256-pv6WquROAy8YJFLC7zmm/VZGIVO/FRvQu6ezvgaTebo=";
        };
      });
    })
  ];
}
