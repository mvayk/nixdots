{ config, pkgs, machine, theme, ... }:
let
    nixDir = ./nix;
    getNixFiles = dir:
    if builtins.pathExists dir then
    let
        files = builtins.attrNames (builtins.readDir dir);
        isNixFile = name: builtins.match ".*\.nix$" name != null;
        nixFiles = builtins.filter isNixFile files;
    in
        map (name: "${dir}/${name}") nixFiles
    else [];
in
{
    imports = getNixFiles nixDir ++ [
        ../modules/tmux.nix
        ../modules/zshrc.nix
    ];

    home.username = "mvayk";
    home.homeDirectory = "/home/mvayk";
    home.stateVersion = "25.05";

# pray to the overlords that the order of overrides is correct
    home.file = {
        ".config" = {
            source = ./mvayk/.config;
            recursive = true;
        };
    };

    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "mvayk";
                email = "mvayk@mvayk.mvayk";
            };
        };
    };

    services.syncthing = {
        enable = true;
    };

    programs.zsh = {
        enable = true;
    };

    programs.yazi = {
        enable = true;
    };

    home.packages = with pkgs; [
    ];

    home.sessionVariables = {
        NIXOS_MACHINE = machine;
        NIXOS_THEME   = theme;
        PAGER = "bat";
    };
}
