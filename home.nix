{ config, pkgs, ... }:
{
    xdg.enable = true;
    nix.assumeXdg = true;
    targets.genericLinux.enable = true;

    home.username = "Kalium";
    home.homeDirectory = "/home/Kalium";
    home.stateVersion = "26.11";
    home.packages = with pkgs; [
        neovim
    ];
    home.sessionVariables = {
        EDITOR = "nvim";
    };
    programs.home-manager.enable = true;
    programs.bash.enable = true;
}
