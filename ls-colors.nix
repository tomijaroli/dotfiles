let
    pkgs = import <nixpkgs> {};
    LS_COLORS =  pkgs.fetchgit {
        url = "https://github.com/arcticicestudio/nord-dircolors";
        rev = "addb3b427e008d23affc721450fde86f27566f1d";
        hash = "sha256-kuJW3M2+2TOtS+jROv4QcLU1JdMWJGdkWuQnI9Bo62g=";
    };
in
    pkgs.runCommand "ls-colors" {} ''
        mkdir -p $out/bin $out/share
        ln -s ${pkgs.coreutils}/bin/ls $out/bin/ls
        ln -s ${pkgs.coreutils}/bin/dircolors $out/bin/dircolors
        cp ${LS_COLORS}/src/dir_colors $out/share/LS_COLORS
    ''
