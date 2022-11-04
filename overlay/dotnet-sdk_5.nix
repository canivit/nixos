{ lib
, stdenv
, fetchurl
, writeText
, libunwind
, openssl
, libuuid
, zlib
, curl
, icu
, gtk3
, libnotify
, lttng-ust_2_12
}:
stdenv.mkDerivation rec {
  pname = "dotnet-sdk_5";
  version = "5.0.403";

  rpath = lib.makeLibraryPath ([
    stdenv.cc.cc
    zlib
    curl
    icu
    libunwind
    libuuid
    openssl
    gtk3
    libnotify
  ] ++ lib.optionals stdenv.isLinux [
    lttng-ust_2_12
  ]);

  src = fetchurl {
    url = "https://download.visualstudio.microsoft.com/download/pr/b77183fa-c045-4058-82c5-d37742ed5f2d/ddaccef3e448a6df348cae4d1d271339/dotnet-sdk-5.0.403-linux-x64.tar.gz";
    sha512 = "7ba5f7f898dba64ea7027dc66184d60ac5ac35fabe750bd509711628442e098413878789fad5766be163fd2867cf22ef482a951e187cf629bbc6f54dd9293a4a";
  };

  sourceRoot = ".";

  dontPatchELF = true;
  noDumpEnvVars = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -r ./ $out
    ln -s $out/dotnet $out/bin/dotnet
    runHook postInstall
  '';

  postFixup = lib.optionalString stdenv.isLinux ''
    patchelf --set-interpreter "${stdenv.cc.bintools.dynamicLinker}" $out/dotnet
    patchelf --set-rpath "${rpath}" $out/dotnet
    find $out -type f -name "*.so" -exec patchelf --set-rpath '$ORIGIN:${rpath}' {} \;
    find $out -type f \( -name "apphost" -or -name "createdump" \) -exec patchelf --set-interpreter "${stdenv.cc.bintools.dynamicLinker}" --set-rpath '$ORIGIN:${rpath}' {} \;
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    $out/bin/dotnet --info
  '';

  setupHook = writeText "dotnet-setup-hook" ''
    if [ ! -w "$HOME" ]; then
      export HOME=$(mktemp -d) # Dotnet expects a writable home directory for its configuration files
    fi
    export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1 # Dont try to expand NuGetFallbackFolder to disk
    export DOTNET_NOLOGO=1 # Disables the welcome message
    export DOTNET_CLI_TELEMETRY_OPTOUT=1
  '';

  meta = with lib; {
    description = "dotnet-sdk_5 with additional libraries for CS4500";
    homepage = "https://dotnet.github.io/";
    license = licenses.mit;
    maintainers = [ "canivit" ];
    mainProgram = "dotnet";
    platforms = platforms.linux;
  };
}
