{
	autoPatchelfHook,
	e2fsprogs,
	fetchzip,
	fontconfig,
	libgcc,
	libGL,
	libgpg-error,
	libx11,
	libxcb,
	makeWrapper,
	meta,
	pname,
	stdenv,
	version,
	wayland,
	xkeyboard_config
}:
stdenv.mkDerivation {
	inherit pname version meta;

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
		libx11
		libxcb
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
}
