{
	description = "Nix Flake for the Music Presence app";

	inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

	outputs = { self, nixpkgs }: let
		systems = [
			"x86_64-linux"
			"aarch64-darwin"
		];

		forAllSystems = f: nixpkgs.lib.genAttrs systems f;
	in {
		packages = forAllSystems (
			system: let
				pkgs = nixpkgs.legacyPackages.${system};
				musicpresence = pkgs.callPackage ./package.nix {};
			in {
				inherit musicpresence;
				default = musicpresence;
			}
		);

		overlays.default = final: prev: {
			musicpresence = final.callPackage ./package.nix {};
		};
	};
}
