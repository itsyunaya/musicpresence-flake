{ fetchurl, meta, pname, stdenvNoCC, undmg, version }:
stdenvNoCC.mkDerivation {
	inherit pname version;

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

	postFixup = ''
    	app=$(echo "$out/Applications"/*.app)
    	/usr/bin/codesign --force --deep --sign - "$app"
	'';

	meta = meta // {
		platforms = [ "aarch64-darwin" ];
	};
}
