# musicpresence-flake
This is a Nix Flake for the [Music Presence](https://musicpresence.app/) app by ungive,
packaged for Linux devices and Apple Silicon Macs

## Usage
1. Add the repository to your flake inputs:
```nix
musicpresence = {
    url = "https://github.com/itsyunaya/musicpresence-flake.git";
    inputs.nixpkgs.follows = "nixpkgs";
};
```

2. Add the package overlay (Recommended):
```nix
# in your nixos/darwin-configuration block
modules = [
    {
        nixpkgs.overlays = [ musicpresence.overlays.default ];
    }
];
```

3. Install the package:
```nix
environment.systemPackages = [
    pkgs.musicpresence
];
```

Or without the overlay:
```nix
environment.systemPackages = [
    (pkgs.callPackage "${musicpresence}/package.nix" { })
];
```

## Note
Since Music Presence's licence is defined as "unfree redistributable", Nix will refuse to
evaluate the package unless you set either of the following in your config:
```nix
# global override
allowUnfree = true;

# scoped just for musicpresence
nixpkgs.config.allowUnfreePackages = [ "musicpresence" ];
```