{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.dms.homeModules.dank-material-shell];

  programs.dank-material-shell.enable = true;

  home.packages = with pkgs; [];
}
