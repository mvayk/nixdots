{pkgs, ...}: {
  imports = [./features/kitty.nix];
  programs.kitty.enable = true;
}
