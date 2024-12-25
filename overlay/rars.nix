{
  lib,
  stdenvNoCC,
  fetchurl,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
  jre,
}:

stdenvNoCC.mkDerivation rec {
  pname = "rars-risc";
  version = "27a7c1f";

  src = fetchurl {
    url = "https://github.com/TheThirdOne/rars/releases/download/continuous/rars_27a7c1f.jar";
    sha256 = "sha256-PNLEtzZbNUE77e/A6tHwpzDNSRRU8uLZdxWAlmCo+gs=";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    makeWrapper
    copyDesktopItems
  ];

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = "RARS";
      exec = "rars-risc";
      comment = "RISC-V Assembler and Runtime Simulator";
      categories = [
        "Development"
        "IDE"
      ];
    })
  ];

  installPhase = ''
    runHook preInstall
    export JAR=$out/share/java/${pname}/${pname}.jar
    install -D $src $JAR
    makeWrapper ${jre}/bin/java $out/bin/${pname} \
      --add-flags "-jar $JAR"
    runHook postInstall
  '';

  meta = with lib; {
    description = "RISC-V Assembler and Runtime Simulator";
    homepage = "https://github.com/thethirdone/rars";
    license = licenses.mit;
    maintainers = [ "canivit" ];
    platforms = platforms.all;
  };
}
