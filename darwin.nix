{ fetchurl, meta, pname, stdenvNoCC, undmg, version }:
stdenvNoCC.mkDerivation {
	inherit pname version meta;

	src = fetchurl {
		url = "https://github.com/ungive/discord-music-presence/releases/download/v${version}/musicpresence-${version}-mac-arm64.dmg";
		hash = "sha256-IvUyzR9amMhyWHRuhTuqUFALCE3QTRjHmsASKydnj8Q=";
	};

	nativeBuildInputs = [ undmg ];

	sourceRoot = ".";

	installPhase = ''
    	runHook preInstall
    	mkdir -p "$out/Applications"
    	cp -R *.app "$out/Applications/"
		runHook postInstall
	'';
}
