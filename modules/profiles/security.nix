{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.profiles.security = lib.mkEnableOption "security packages";

  config = lib.mkIf config.profiles.security {
    environment.systemPackages = with pkgs; [
      ghidra
      radare2
      binaryninja-free
      #cutter
      rizin
      gdb
      gef
      strace
      ltrace
      binwalk
      imhex
      scanmem
      pince
      volatility3
      age
      frida-tools
      /*
        > ***
        > Unfortunately, we cannot download file ida-free-pc_92_x64linux.run automatically.
        > Please go to https://my.hex-rays.com/dashboard/download-center/installers/release/9.2/ida-free to download it yourself, and add it to the Nix store
        > using either
        >   nix-store --add-fixed sha256 ida-free-pc_92_x64linux.run
        > or
        >   nix-prefetch-url --type sha256 file:///path/to/ida-free-pc_92_x64linux.run
        >
        > ***
      */
      #ida-free
      nmap
    ];
  };
}
