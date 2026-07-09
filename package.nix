{ lib, stdenv, callPackage }: let
	common = {
		pname = "musicpresence";
		version = "2.3.6";

		meta = {
			description = "The Discord music status that works with any media player";
			homepage = "https://musicpresence.app/";
			downloadPage = "https://github.com/ungive/discord-music-presence";
			license = lib.licenses.unfreeRedistributable;
			sourceProvenance = lib.sourceTypes.binaryNativeCode;
		};
	};
in
	if stdenv.hostPlatform.isLinux
	then callPackage ./linux.nix common
	else if stdenv.hostPlatform.isDarwin
	then callPackage ./darwin.nix common
	else throw "Unsupported platform: ${stdenv.hostPlatform.system}"
