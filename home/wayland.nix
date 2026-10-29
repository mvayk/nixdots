{pkgs, ...}: {
  imports = [./features/ghostty.nix ./features/swayimg.nix];
  programs.ghostty.enable = true;
  programs.swayimg.enable = true;
}
