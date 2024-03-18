{ lib, stdenvNoCC }:
stdenvNoCC.mkDerivation {
  name = "nixfiles-assets";
  src = ./.;
  phases = [ "installPhase" ];
  installPhase = ''
    cd $src
    pwd
    ls
    mkdir -p $out/share/
    cp -a wallpapers $out/share/
  '';
}
