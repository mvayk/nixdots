{ config, pkgs, ... }:
{
    imports = getNixFiles nixDir ++ [
        ../../common/shared-home.nix
        ../../home/experimental/home.nix
    ];

    programs.zsh = {
        shellAliases = {
            nix-rebuild = "pushd /etc/nixos && sudo nixos-rebuild switch --flake .#desktop; popd";
        };
    };
}
