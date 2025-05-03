{ inputs, pkgs, ... }:
{
  #
        #[Default Applications]
        #x-scheme-handler/mailto=userapp-Thunderbird-6FXC22.desktop
        #message/rfc822=userapp-Thunderbird-6FXC22.desktop
        #x-scheme-handler/mid=userapp-Thunderbird-6FXC22.desktop
        #x-scheme-handler/news=userapp-Thunderbird-PK9C22.desktop
        #x-scheme-handler/snews=userapp-Thunderbird-PK9C22.desktop
        #x-scheme-handler/nntp=userapp-Thunderbird-PK9C22.desktop
        #x-scheme-handler/feed=userapp-Thunderbird-NJ1A22.desktop
        #application/rss+xml=userapp-Thunderbird-NJ1A22.desktop
        #application/x-extension-rss=userapp-Thunderbird-NJ1A22.desktop
        #x-scheme-handler/webcal=userapp-Thunderbird-6JNL22.desktop
        #text/calendar=userapp-Thunderbird-6JNL22.desktop
        #application/x-extension-ics=userapp-Thunderbird-6JNL22.desktop
        #x-scheme-handler/webcals=userapp-Thunderbird-6JNL22.desktop
        #x-scheme-handler/discord=vesktop.desktop
        #x-scheme-handler/http=zen-beta.desktop
        #x-scheme-handler/https=zen-beta.desktop
        #x-scheme-handler/chrome=zen-beta.desktop
        #text/html=zen-beta.desktop
        #application/x-extension-htm=zen-beta.desktop
        #application/x-extension-html=zen-beta.desktop
        #application/x-extension-shtml=zen-beta.desktop
        #application/xhtml+xml=zen-beta.desktop
        #application/x-extension-xhtml=zen-beta.desktop
        #application/x-extension-xht=zen-beta.desktop
        #image/jpeg=viewnior.desktop
        #
        #[Added Associations]
        #x-scheme-handler/mailto=userapp-Thunderbird-6FXC22.desktop;
        #x-scheme-handler/mid=userapp-Thunderbird-6FXC22.desktop;
        #x-scheme-handler/news=userapp-Thunderbird-PK9C22.desktop;
        #x-scheme-handler/snews=userapp-Thunderbird-PK9C22.desktop;
        #x-scheme-handler/nntp=userapp-Thunderbird-PK9C22.desktop;
        #x-scheme-handler/feed=userapp-Thunderbird-NJ1A22.desktop;
        #application/rss+xml=userapp-Thunderbird-NJ1A22.desktop;
        #application/x-extension-rss=userapp-Thunderbird-NJ1A22.desktop;
        #x-scheme-handler/webcal=userapp-Thunderbird-6JNL22.desktop;
        #x-scheme-handler/webcals=userapp-Thunderbird-6JNL22.desktop;
        #x-scheme-handler/http=zen-beta.desktop;userapp-Zen-FFA612.desktop;
        #x-scheme-handler/https=zen-beta.desktop;userapp-Zen-FFA612.desktop;
        #x-scheme-handler/chrome=zen-beta.desktop;userapp-Zen-FFA612.desktop;
        #text/html=userapp-Zen-FFA612.desktop;zen-beta.desktop;
        #application/x-extension-htm=userapp-Zen-FFA612.desktop;zen-beta.desktop;
        #application/x-extension-html=userapp-Zen-FFA612.desktop;zen-beta.desktop;
        #application/x-extension-shtml=userapp-Zen-FFA612.desktop;zen-beta.desktop;
        #application/xhtml+xml=userapp-Zen-FFA612.desktop;zen-beta.desktop;
        #application/x-extension-xhtml=userapp-Zen-FFA612.desktop;zen-beta.desktop;
        #application/x-extension-xht=userapp-Zen-FFA612.desktop;zen-beta.desktop;
        #image/jpeg=viewnior.desktop;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen.desktop";
    };
  };
}
