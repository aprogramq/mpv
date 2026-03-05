{
  description = "mpv development shell for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        maybe = name:
          if builtins.hasAttr name pkgs then
            [ (builtins.getAttr name pkgs) ]
          else
            [ ];
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs;
            [
              glib
              glibc
              clang
              clang-tools

              meson
              ninja
              pkg-config
              python3
              gnumake

              ffmpeg-full
              libass
              libplacebo
              lcms2
              libarchive
              libbluray
              mujs
              lua5_2
              rubberband
              vapoursynth
              zimg
              zlib

              alsa-lib
              jack2
              openal
              pipewire
              pulseaudio
              SDL2

              libdrm
              libva
              libvdpau
              vulkan-loader

              libglvnd
              egl-wayland

              wayland
              wayland-protocols
              wayland-scanner
              libxkbcommon
              libx11
              libxext
              libxpresent
              libxrandr
              libxscrnsaver
              libxfixes
              libxv

              libjpeg
              libdvdnav
              libdvdread

            ] ++ maybe "uchardet"
            ++ maybe "sndio"
            ++ maybe "libdisplay-info"
            ++ maybe "shaderc"
            ++ maybe "spirv-cross"
            ++ maybe "ffnvcodec"
            ++ maybe "ffnvcodec-headers"
            ++ maybe "libcdio"
            ++ maybe "libcdio-paranoia"
            ++ maybe "libdvdnav"
            ++ maybe "libsixel"
            ++ maybe "subrandr";
        };
      });
}
