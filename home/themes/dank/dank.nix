{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dsearch.homeModules.dsearch
  ];

  programs.dank-material-shell.enable = true;
  programs.dsearch.enable = true;

  home.file.".config/dms/settings.json".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/home/themes/dank/settings.json";

  home.packages = with pkgs; [];
}
