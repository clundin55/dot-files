let
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-22.11";
    pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShell {
  packages = with pkgs; [
    zsh
    git
    neovim
    cargo
    rust-analyzer
    asciinema
    cmake
    fd
    fzf
    gh
    go
    htop
    jq
    python311
    ripgrep
    readline
    tealdeer
    starship
    tmux
    shellcheck
    stow
    tree
    direnv
    glibcLocales
  ];

  LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  shellHook = ''
    echo "Hello $USER"
  '';
}
