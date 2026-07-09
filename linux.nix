{
	autoPatchelfHook,
	e2fsprogs,
	fetchzip,
	fontconfig,
	libgcc,
	libGL,
	libgpg-error,
	libxcb,
	libx11,
	makeWrapper,
	meta,
	pname,
	stdenv,
	version,
	wayland,
	xkeyboard_config
}:
stdenv.mkDerivation {
	inherit pname version;

	src = fetchzip {
		url = "https://github.com/ungive/discord-music-presence/releases/download/v${version}/musicpresence-${version}-linux-x86_64.tar.gz";
		hash = "sha256-MUGFGEJwXcx66G8sJPvOlmpuoM9B7/PsPG6MnlKt/8M=";
	};

	nativeBuildInputs = [ autoPatchelfHook makeWrapper ];

	buildInputs = [
		e2fsprogs
		fontconfig
		libgcc
		libGL
		libgpg-error
		libxcb
		libx11
		wayland
		stdenv.cc.cc.lib
	];

	installPhase = ''
    	runHook preInstall
    	mkdir -p $out/bin
    	cp -r usr/share $out/
    	makeWrapper $out/share/musicpresence/bin/musicpresence $out/bin/musicpresence \
    		--set XKB_CONFIG_ROOT "${xkeyboard_config}/share/X11/xkb"
    	runHook postInstall
	'';

	meta = meta // {
		mainProgram = "musicpresence";
		platforms = [ "x86_64-linux" ];
	};
}
