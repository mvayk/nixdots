{pkgs, ...}: {
  imports = [./features/ghostty.nix ./features/swayimg.nix ./features/starship.nix];
  programs.ghostty.enable = true;
  programs.starship.enable = true;
  programs.swayimg.enable = true;
}
