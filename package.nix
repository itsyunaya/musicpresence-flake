{ callPackage, lib, stdenv, systems }: let
	pname = "musicpresence";
	version = "2.3.6";

	meta = {
		description = "The Discord music status that works with any media player";
		homepage = "https://musicpresence.app/";
		downloadPage = "https://github.com/ungive/discord-music-presence";
		license = lib.licenses.unfreeRedistributable;
		sourceProvenance = lib.sourceTypes.binaryNativeCode;
		platforms = systems;
	};

	path =
		if stdenv.hostPlatform.isLinux
		then ./linux.nix
		else if stdenv.hostPlatform.isDarwin
		then ./darwin.nix
		else throw "Unsupported platform: ${stdenv.hostPlatform.system}";
in
	callPackage path { inherit pname version meta; }
