let
    pkgs = import <nixpkgs> {};
    LS_COLORS =  pkgs.fetchgit {
        url = "https://github.com/trapd00r/LS_COLORS";
        rev = "87e57851028f51304417143da54d8cc9a3b492f3";
        hash = "sha256-NLIu6VoQE8dHE0tinCuFbT8R2VLqIlHyRPTu6voHziw";
    };
in
    pkgs.runCommand "ls-colors" {} ''
        mkdir -p $out/bin $out/share
        ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
        ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
        cp ${LS_COLORS}/LS_COLORS $out/share/LS_COLORS
    ''
