{ pkgs, lib, ... }:
{
  services.wayle = {
    enable = true;

    # tip: you can automatically translate your TOML config to Nix by running
    # nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./config.toml)' | nixfmt
    #cd ~/.config/wayle
    #nix-instantiate --eval --expr '(builtins.fromTOML (builtins.readFile ./config.toml)) // (builtins.fromTOML (builtins.readFile ./runtime.toml))' | nixfmt

    settings = {
      modules = {
        clock = {
          format = "%H:%M:%S";
          dropdown-show-seconds = false;
        };
      };
    };
  };

  home.packages = with pkgs; [
    awww
  ];
}
