{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.reversing;
in {
  options.my.reversing = {
    enable = lib.mkEnableOption "reverse engineering";
    cli.enable = mkSub cfg.enable "gdb, gef, radare2, rizin, strace, ltrace, frida, volatility";
    gui.enable = mkSub (cfg.enable && config.my.desktop.enable) "ghidra, binaryninja, imhex";
    java.enable = mkSub cfg.enable "recaf, jasmin";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.cli.enable {
      environment.systemPackages = with pkgs; [
        gdb
        gef
        radare2
        rizin
        strace
        ltrace
        frida-tools
        volatility3
        #binwalk
        #scanmem
        #pince
      ];
    })

    (lib.mkIf cfg.gui.enable {
      environment.systemPackages = with pkgs; [
        ghidra
        binaryninja-free
        imhex
        #cutter
        #   nix-store --add-fixed sha256 ida-free-pc_92_x64linux.run
      ];
    })

    (lib.mkIf cfg.java.enable {
      environment.systemPackages = with pkgs; [recaf-launcher jasmin];
    })
  ];
}
