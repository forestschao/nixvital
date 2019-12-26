# For development of this package, run
#
#   nix-build -E "with import <nixpkgs> {}; callPackage ./default.nix {}"

{ stdenv, pkgs, ... }:

let python = pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
      clint
      click
      cement
      tabulate
    ]);

in stdenv.mkDerivation {
  name = "nixvital_installer";
  srcs = ./srcs;
  buildInputs = [ python ];

  unpackPhase = ":";
  buildPhase = ":";
  
  installPhase = ''
    mkdir -p $out/bin
    cp $srcs/install.py $out/bin/nixvital_install
    chmod +x $out/bin/nixvital_install
  '';
}