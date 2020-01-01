{pkgs ? import (if pin == false then <nixpkgs> else pin) {},
 pin ? ./nixpkgs.nix, ... }:
with pkgs;
let
  # --------------- Commands ----------------

  # ------------------Rust-------------------
  rust-pkgs = [
    lldb
    rustup
#    racer
    rustracer
    gcc
    cmake
    pkgconfig
    zlib
    gnumake
    openssl
    # gcc-arm-embedded
    binutils.bintools
  ];

  # embedded-tools = [
  #   gdb-multitarget
  #   openocd
  #   usbutils
  # ];

  shell = mkShell rec {
    name = "rust-env";
    buildInputs = with pkgs; [] 
    ++ rust-pkgs
    ++ embedded-tools;

    shellHook = ''
      echo "##### ${name} #####"
    '';
  };


in {
  inherit pkgs rust-pkgs embedded-tools shell;

} 
