{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "eza --icons -l";
      l = "eza --icons";
      vim = "nvim";
      sue = "sudo -E nvim";
    };

    interactiveShellInit = ''
      direnv hook fish | source
      zoxide init fish | source
    '';
  };
}
