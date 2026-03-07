{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Default";
      theme_background = false;
      rounded_corners = false;
      vim_keys = true;
    };
  };
}
