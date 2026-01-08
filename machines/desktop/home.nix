{ config, pkgs, ... }:
{
    imports = [
        ../../common/shared-home.nix
        ../../home/experimental/home.nix
    ];
}
