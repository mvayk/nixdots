{ config, pkgs, ... }:
{
    imports = getNixFiles nixDir ++ [
        ../../common/shared-home.nix
        ../../home/kde/home.nix
    ];
    programs.zsh = {
        envExtra = ''
            export FART="test";
        '';

        shellAliases = {
            nix-rebuild = "pushd /etc/nixos && sudo nixos-rebuild switch --flake .#laptop; popd";
        };
    };
}
