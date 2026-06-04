{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    file
    tree
    sops

    zsh
    oh-my-zsh
    tmux

    bat
    eza
    ripgrep
    fd
    fzf
    jq
    zoxide
    btop
    htop
    fastfetch
    tldr

    bottom
    dust
    procs

    nnn
    feh
    dmenu
    lazygit
    starship

    more
    most
    yad
    zenity

    man-pages
    man-pages-posix

    wl-clipboard
    xclip
    xinput
    libnotify

    termdown
    hollywood
  ];
}
