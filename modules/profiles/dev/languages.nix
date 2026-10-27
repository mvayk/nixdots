{
  pkgs,
  lib,
  config,
  mkSub,
  ...
}: let
  cfg = config.my.dev;
  triple = pkgs.stdenv.hostPlatform.config;
  gccInc = "${pkgs.gcc.cc}/include/c++/${pkgs.gcc.version}";
in {
  options.my.dev = {
    cpp.enable = mkSub cfg.enable "C/C++: gcc, clang, clangd, cmake, make";
    asm.enable = mkSub cfg.enable "assembly: nasm";
    rust.enable = mkSub cfg.enable "Rust: rustc, cargo, clippy, rust-analyzer";
    go.enable = mkSub cfg.enable "Go";
    java.enable = mkSub cfg.enable "Java: JDK 21 + 17";
    lua.enable = mkSub cfg.enable "Lua: lua, luajit, luarocks, lua-language-server, stylua";
    python.enable = mkSub cfg.enable "Python: python3, pylsp, pynvim";
    node.enable = mkSub cfg.enable "Node.js";
    nix.enable = mkSub cfg.enable "Nix: nil, alejandra";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.cpp.enable {
      environment = {
        systemPackages = with pkgs; [gcc clang clang-tools cmake gnumake pkg-config flex bison];
        sessionVariables.CPLUS_INCLUDE_PATH = [gccInc "${gccInc}/${triple}"];
      };
    })

    (lib.mkIf cfg.asm.enable {environment.systemPackages = [pkgs.nasm];})

    (lib.mkIf cfg.rust.enable {
      environment = {
        systemPackages = with pkgs; [rustc cargo rustfmt clippy rust-analyzer];
        sessionVariables.RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
      };
    })

    (lib.mkIf cfg.go.enable {environment.systemPackages = [pkgs.go];})

    (lib.mkIf cfg.java.enable {
      environment.systemPackages = [pkgs.openjdk21 (lib.lowPrio pkgs.openjdk17)];
    })

    (lib.mkIf cfg.lua.enable {
      environment.systemPackages = with pkgs; [lua luajit luarocks lua-language-server stylua];
    })

    (lib.mkIf cfg.python.enable {
      environment.systemPackages = with pkgs; [
        python3
        python3Packages.python-lsp-server
        python3Packages.pynvim
      ];
    })

    (lib.mkIf cfg.node.enable {environment.systemPackages = [pkgs.nodejs];})

    (lib.mkIf cfg.nix.enable {environment.systemPackages = with pkgs; [nil alejandra];})
  ];
}
