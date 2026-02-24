{ pkgs, ... }:
{
  imports = [
    ./features/zsh.nix
    ./features/tmux.nix
    ./features/yazi.nix
    ./features/fish.nix
    ./features/git.nix
    ./features/starship.nix
  ];

  services.syncthing.enable = true;
  programs.brave.enable = true;

  home.packages = with pkgs; [
    nix-tree
    nix-output-monitor
    nvd
    direnv
    zoxide
    fzf
    bat
    eza
    ripgrep
    fd
    wl-clipboard
  ];
}
