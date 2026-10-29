{
  pkgs,
  noctalia,
  config,
  ...
}: {
  home.file.".local/state/noctalia/settings.toml".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home/themes/noctalia/settings.toml";

  home.packages = with pkgs; [
    noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    mpvpaper
  ];
}
