{ inputs, pkgs, ... }: {

  home.packages = with pkgs; [

    # ELECTRONIC ENGINEERING
    # ----------------------

    # ARDUINO
    arduino
    arduino-ide
    arduino-cli

    # FRITZING
    #fritzing

    # KICAD
    #kicad

    # QUCS
    qucs-s # WITH N-SPICE

    # MATHS
    geogebra

    # SOFTWARE DESIGN
    #umlet
    graphviz


    # COMMUNICATIONS
    # ----------------------

    # MATRIX CLIENT
    #element

    # SIGNAL
    signal-desktop


    # GAMES AND SUCH
    # ----------------------

    # BSDGAMES
    bsdgames

    # STEAM
    #steam


    # IMAGES AND DESIGN
    # ----------------------

    # INKSCAPE
    #inkscape

    # RAW THERAPEE
    rawtherapee


    # FILES AND SUCH
    # ----------------------

    # FILE BROWSER (probably deserves its own config)
    nemo

    # NEXTCLOUD
    nextcloud-client


    # OFFICE 
    # ----------------------

    # ONLY OFFICE
    onlyoffice-desktopeditors

    # Zoom
    zoom-us

    # SCUBA
    # ----------------------
    subsurface

    # VPNS
    # ----------------------
    # PROTON
    protonvpn-gui
    protonvpn-cli


    # UTILITIES
    # ----------------------

    # DESKTOP BACKGROUD SWITCHER
    variety

    # IMAGE VIEWER
    viewnior

    # VLC
    vlc

    # PDF
    zathura

  ];

}
