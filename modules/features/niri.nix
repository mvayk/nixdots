{
  pkgs,
  inputs,
  ...
}: {
  imports = [../wayland.nix];

  programs.niri = {
    enable = true;
  };

  services.displayManager.defaultSession = "niri";
}
