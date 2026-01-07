# SPDX-FileCopyrightText: 2025 2025
# SPDX-FileContributor: Darragh Elliott
#
# SPDX-License-Identifier: MIT

{ pkgs, lib, ... }:
let
  common-policies = {
    BlockAboutAddons = false;
    BlockAboutConfig = false;
    BlockAboutProfiles = false;
    BlockAboutSupport = false;
    Certificates = {
      ImportEnterpriseRoots = false;
    };
    Cookies = {
      Behavior = "reject-tracker-and-partition-foreign";
      BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
    };
    DNSOverHTTPS = {
      Enabled = true;
      Locked = false;
      ProviderURL = "https://dns.quad9.net/dns-query";
      Fallback = false;
    };
    DisableTelemetry = true;
    EnterprisePoliciesEnabled = true;
    ExtensionSettings = {
      "dynamic-probe-telemetry-extension@mozilla.com" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla 'Dynamic Probe Telemetry' https://github.com/mozilla-extensions/dynamic-probe-telemetry-extension";
      };
      "1und1@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in 1&1 Internet Search Engine in some regions. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/1und1/manifest.json";
      };
      "allegro-pl@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Allegro Search Engine in some regions. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/allegro-pl/manifest.json";
      };
      "amazon@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Amazon Search Engine. Amazon should be avoided due to its horrible privacy practices; but regardless; Amazon still appears to be selectable as a search engine with this removed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/amazon/manifest.json";
      };
      "amazondotcn@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Amazon Search Engine. Amazon should be avoided due to its horrible privacy practices; but regardless; Amazon still appears to be selectable as a search engine with this removed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/amazondotcn/manifest.json";
      };
      "amazondotcom@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Amazon Search Engine. Amazon should be avoided due to its horrible privacy practices; but regardless; Amazon still appears to be selectable as a search engine with this removed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/amazondotcom/manifest.json";
      };
      "baidu@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Baidu Search Engine in some regions. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/baidu/manifest.json";
      };
      "bing@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Bing Search Engine. Bing should be avoided due to its horrible privacy practices; but regardless; Bing still appears to be selectable as a search engine with this removed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/bing/manifest.json";
      };
      "ceneji@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Ceneje Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/ceneji/manifest.json";
      };
      "coccoc@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Cốc Cốc Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/coccoc/manifest.json";
      };
      "daum-kr@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Daum Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/daum-kr/manifest.json";
      };
      "ebay@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in eBay Search Engine. eBay should be avoided due to its horrible privacy practices; but regardless; eBay still appears to be selectable as a search engine with this removed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/ebay/manifest.json";
      };
      "ecosia@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Ecosia Search Engine. Should be avoided due to poor privacy practices; but regardless; can still be added manually if needed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/ecosia/manifest.json";
      };
      "eudict@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in EUdict Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/eudict/manifest.json";
      };
      "gmx@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in GMX Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/gmx/manifest.json";
      };
      "google@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Google Search Engine. Google should be avoided due to its horrible privacy practices; but regardless; Google still appears to be selectable as a search engine with this removed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/google/manifest.json";
      };
      "gulesider-NO@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Gulesider.no Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/gulesider-NO/manifest.json";
      };
      "leo_ende_de@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in LEO Eng-Deu Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/leo_ende_de/manifest.json";
      };
      "longdo@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Longdo Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/longdo/manifest.json";
      };
      "mailcom@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in mail.com Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/mailcom/manifest.json";
      };
      "mailru@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in @ Mail (mail.ru) Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/mailru/manifest.json";
      };
      "mapy-cz@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Mapy.cz Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/mapy-cz/manifest.json";
      };
      "mercadolibre@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in MercadoLibre Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/mercadolibre/manifest.json";
      };
      "mercadolivre@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in MercadoLivre Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/mercadolivre/manifest.json";
      };
      "naver-kr@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in NAVER Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/naver-kr/manifest.json";
      };
      "odpiralni@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Odpiralni Časi Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/odpiralni/manifest.json";
      };
      "pazaruvaj@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Pazaruvaj Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/pazaruvaj/manifest.json";
      };
      "priberam@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Priberam Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/priberam/manifest.json";
      };
      "prisjakt-sv-SE@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Prisjakt Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/prisjakt-sv-SE/manifest.json";
      };
      "qwant@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Qwant Search Engine. Should be avoided due to poor privacy practices; but regardless; can still be added manually if needed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/qwant/manifest.json";
      };
      "qwantjr@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Qwant Junior Search Engine. Should be avoided due to poor privacy practices; but regardless; can still be added manually if needed. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/qwant/manifest.json";
      };
      "rakuten@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Rakuten Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/rakuten/manifest.json";
      };
      "readmoo@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Readmoo Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/readmoo/manifest.json";
      };
      "salidzinilv@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Salidzini.lv Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/salidzinilv/manifest.json";
      };
      "seznam-cz@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Seznam Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/seznam-cz/manifest.json";
      };
      "tyda-sv-SE@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Tyda.se Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/tyda-sv-SE/manifest.json";
      };
      "vatera@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Vatera.hu Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/vatera/manifest.json";
      };
      "webde@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in WEB.DE Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/webde/manifest.json";
      };
      "wolnelektury-pl@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Wolne Lektury Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/wolnelektury-pl/manifest.json";
      };
      "yahoo-jp@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Yahoo! Search Engine. Should be avoided due to its horrible privacy practices; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/yahoo-jp/manifest.json";
      };
      "yahoo-jp-auctions@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Yahoo! Auctions Search Engine. Should be avoided due to its horrible privacy practices; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/yahoo-jp-auctions/manifest.json";
      };
      "yandex@search.mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Mozilla's extension for the built-in Yandex Search Engine. Should be avoided; but regardless; can still be added manually. https://searchfox.org/mozilla-release/source/browser/components/search/extensions/yandex/manifest.json";
      };
      "{44df5123-f715-9146-bfaa-c6e8d4461d44}" = {
        installation_mode = "blocked";
        blocked_install_message = "Fakespot; by Mozilla. Poor privacy policy.";
      };
      "firefox-translations-addon@mozilla.org" = {
        installation_mode = "blocked";
        blocked_install_message = "Firefox Translations; by Mozilla. Dead. Also unnecessary since the Translations feature is now built in.";
      };
      "@contain-facebook" = {
        installation_mode = "blocked";
        blocked_install_message = "Facebook Container; by Mozilla. Unnecessary since cookies are now isolated by default; and if you still wish to create a container for Facebook; you can do so at about=preferences#general or through the Multi-Account Containers extension instead.";
      };
      "uBlock0@raymondhill.net" = {
        installation_mode = "force_installed";
        install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/ublock-origin/addon-988489-latest.xpi";
        private_browsing = true;
        temporarily_allow_weak_signatures = false;
        updates_disabled = false;
      };
    };
    Proxy.UseProxyForDNS = true;
  };
  common-profiles = {
    default = {
      isDefault = true;
      search = {
        force = true;
        default = "ddg";
      };
    };
  };
in
{
  programs.firefox = {
    enable = true;
    # See https://mozilla.github.io/policy-templates/ for all options
    # Based on https://codeberg.org/celenity/Phoenix/src/branch/pages/policies.json
    # I dislike some of its behaviour, and also how it needs to be installed system wide
    # Or needs a complicated custom firefox override, and building firefox locally is too much work
    policies = lib.attrsets.recursiveUpdate {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      Bookmarks = [
        {
          Title = "search";
          URL = "https://search.nixos.org/packages";
          Placement = "toolbar";
          Folder = "nix";
        }
        {
          Title = "search hm";
          URL = "https://home-manager-options.extranix.com/";
          Placement = "toolbar";
          Folder = "nix";
        }
        {
          Title = "nix-manual";
          URL = "https://nixos.org/manual/nix/unstable/";
          Placement = "toolbar";
          Folder = "nix";
        }
        {
          Title = "nixpkgs-manual";
          URL = "https://nixos.org/manual/nixpkgs/unstable/";
          Placement = "toolbar";
          Folder = "nix";
        }
        {
          Title = "nixos-manual";
          URL = "https://nixos.org/manual/nixos/unstable/";
          Placement = "toolbar";
          Folder = "nix";
        }
        {
          Title = "discourse";
          URL = "https://discourse.nixos.org";
          Placement = "toolbar";
          Folder = "nix";
        }
        {
          Title = "nixpkgs";
          URL = "https://github.com/NixOS/nixpkgs";
          Placement = "toolbar";
          Folder = "nix";
        }
        {
          Title = "blackboard";
          URL = "https://tcd.blackboard.com/";
          Placement = "toolbar";
          Folder = "tcd";
        }
        {
          Title = "library-search";
          URL = "https://www.tcd.ie/library/";
          Placement = "toolbar";
          Folder = "tcd";
        }
        {
          Title = "cc search";
          URL = "https://search.creativecommons.org/";
          Placement = "toolbar";
          Folder = "image-search";
        }
        {
          Title = "wikimedia";
          URL = "https://commons.wikimedia.org/wiki/Main_Page";
          Placement = "toolbar";
          Folder = "image-search";
        }
        {
          Title = "smithsonian open access";
          URL = "https://www.si.edu/OpenAccess";
          Placement = "toolbar";
          Folder = "image-search";
        }
        {
          Title = "Gitea";
          URL = "https://git.fsfe.org";
          Placement = "toolbar";
          Folder = "fsfe";
        }
      ];
      Certificates.ImportEnterpriseRoots = false;
      ContentAnalysis = {
        DefaultResult = 0;
        Enabled = false;
        InterceptionPoints = {
          Clipboard = {
            Enabled = false;
          };
          DragAndDrop = {
            Enabled = false;
          };
          FileUpload = {
            Enabled = false;
          };
          Print = {
            Enabled = false;
          };
        };
        ShowBlockedResult = true;
      };
      DisableDefaultBrowserAgent = true;
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisablePrivateBrowsing = false;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisplayBookmarksToolbar = "always";
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = {
        Cryptomining = true;
        EmailTracking = true;
        Fingerprinting = true;
        Value = true;
        Locked = true;
      };
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = true;
      };
      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = false;
          updates_disabled = false;
        };
        "bibitnow018@aqpl.mc2.chalmers.se" = {
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bibitnow/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = false;
          updates_disabled = false;
        };
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        ImproveSuggest = false;
        SponsoredSuggestions = false;
        WebSuggestions = false;
        Locked = true;
      };
      Homepage = {
        URL = "";
        Additional = [ ];
        StartPage = "previous-session";
        Locked = true;
      };
      HttpsOnlyMode = "force_enabled";
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      Permissions = {
        Microphone = {
          BlockNewRequests = false;
          Locked = true;
        };
        Camera = {
          BlockNewRequests = false;
          Locked = true;
        };
        Autoplay = {
          Default = "block-audio-video";
          Locked = true;
        };
        Location = {
          BlockNewRequests = true;
          Locked = true;
        };
        Notifications = {
          BlockNewRequests = true;
          Locked = true;
        };
        VirtualReality = {
          BlockNewRequests = true;
          Locked = true;
        };
      };
      PopupBlocking = {
        Default = true;
        Locked = true;
      };
      PrivateBrowsingModeAvailability = 0;
      Proxy = {
        UseProxyForDNS = true;
      };
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = false;
        History = false;
        Sessions = false;
        SiteSettings = false;
        Locked = true;
      };
      SearchBar = "unified";
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };
    } common-policies;
    profiles = lib.attrsets.recursiveUpdate {
      default.search.engines = {
        # Thanks to xunuwu on github for being a reference for use of these functions
        "Nix search packages" = {
          urls = lib.singleton {
            template = "https://search.nixos.org/packages";
            params = lib.attrsToList {
              "channel" = "unstable";
              "from" = "0";
              "size" = "50";
              "sort" = "relevance";
              "type" = "packages";
              "query" = "{searchTerms}";
            };
          };
          definedAliases = [ "@nsp" ];
          icon = "https://nixos.org/favicon.ico";
        };
        "Nix search options" = {
          urls = lib.singleton {
            template = "https://search.nixos.org/options";
            params = lib.attrsToList {
              "channel" = "unstable";
              "from" = "0";
              "size" = "50";
              "sort" = "relevance";
              "type" = "packages";
              "query" = "{searchTerms}";
            };
          };
          definedAliases = [ "@nso" ];
          icon = "https://nixos.org/favicon.ico";
        };
        "HM search" = {
          urls = lib.singleton {
            template = "https://home-manager-options.extranix.com/";
            params = lib.attrsToList {
              "release" = "master";
              "query" = "{searchTerms}";
            };
          };
          definedAliases = [ "@hmo" ];
          icon = "https://home-manager-options.extranix.com/images/home-manager-option-search2.png";
        };
        "Noogle" = {
          urls = lib.singleton {
            template = "https://noogle.dev/q";
            params = lib.attrsToList {
              "term" = "{searchTerms}";
            };
          };
          definedAliases = [ "@ng" ];
          icon = "https://noogle.dev/favicon.ico";
        };
        "Nixpkgs" = {
          urls = lib.singleton {
            template = "https://github.com/search";
            params = lib.attrsToList {
              "type" = "code";
              "q" = "repo:NixOS/nixpkgs lang:nix {searchTerms}";
            };
          };
          definedAliases = [ "@npkgs" ];
          icon = "https://nixos.org/favicon.ico";
        };
      };
    } common-profiles;
  };
  programs.thunderbird = {
    enable = true;
    # Thunderbird unfortunately has no policies option in hm
    # If it did this file would only contain common stuff, and then thunderbird + firefox in separate files.
    # But as thunderbird does no, this is more elegant.
    # Based on https://codeberg.org/celenity/Dove/src/branch/pages/policies.json
    package = pkgs.thunderbird-latest.override {
      extraPolicies = lib.attrsets.recursiveUpdate {
        "3rdparty" = {
          Extensions = {
            "dkim_verifier@pl" = {
              "dns.nameserver" = "9.9.9.9";
              "error.algorithm.rsa.weakKeyLength.treatAs" = 1;
              "error.algorithm.sign.rsa-sha1.treatAs" = 1;
              "error.illformed_i.treatAs" = 1;
              "error.illformed_s.treatAs" = 1;
              "error.policy.key_insecure.treatAs" = 1;
              "key.storing" = 2;
              "policy.dkim.unsignedHeadersWarning.mode" = 30;
              "policy.DMARC.shouldBeSigned.neededPolicy" = "none";
              "policy.signRules.autoAddRule.for" = 0;
              "showDKIMFromTooltip" = 50;
              "showDKIMHeader" = 50;
            };
          };
        };
        ExtensionSettings = {
          "dkim_verifier@pl" = {
            installation_mode = "force_installed";
            install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/dkim-verifier/latest.xpi";
            private_browsing = false;
            temporarily_allow_weak_signatures = false;
            updates_disabled = false;
          };
        };
        OfferToSaveLoginsDefault = true;
      } common-policies;
    };
    profiles = lib.attrsets.recursiveUpdate { } common-profiles;
  };
}
