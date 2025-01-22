{ config, pkgs, lib, ...}: with lib; {
  options.glamdring.firefox = {
    enable = mkEnableOption "Enable Firefox";
  };

  config = let 
    cfg = config.glamdring.firefox;
  in mkIf cfg.enable {
    programs.firefox = with pkgs; {
      enable = true;

      package = wrapFirefox firefox-unwrapped {
        extraPolicies = {
          CaptivePortal = false;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DisableFirefoxAccounts = false;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          OfferToSaveLoginsDefault = false;
          PasswordManagerEnabled = false;
          FirefoxHome = {
            Search = true;
            Pocket = false;
            Snippets = false;
            TopSites = false;
            Highlights = false;
          };
          UserMessaging = {
            ExtensionRecommendations = false;
            SkipOnboarding = true;
          };
        };
      };

      profiles = {
        jfredett = {
          id = 0;
          name = "jfredett";
          search = {
            force = true;
            default = "DuckDuckGo";
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.nixos.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "${nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@nw" ];
              };
              "Wikipedia (en)".metaData.alias = "@wiki";
              "Google".metaData.hidden = true;
              "Amazon.com".metaData.hidden = true;
              "Bing".metaData.hidden = true;
              "eBay".metaData.hidden = true;
            };
          };
          settings = {
            "general.smoothScroll" = true;
          };
          extraConfig = ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("full-screen-api.ignore-widgets", true);
            user_pref("media.ffmpeg.vaapi.enabled", true);
            user_pref("media.rdd-vpx.enabled", true);
          '';
          # TODO: Group and add enable flags for each group of addons.
          extensions = let
            ryceePkgs = pkgs.nur.repos.rycee.firefox-addons;
            bandiPkgs = pkgs.nur.repos.bandithedoge.firefoxAddons;
          in [
            ryceePkgs.onepassword-password-manager

            # Efficiency Stuff
            bandiPkgs.auto-tab-discard
            bandiPkgs.dont-fuck-with-paste
            bandiPkgs.tridactyl
            bandiPkgs.violentmonkey
            ryceePkgs.tree-style-tab
            ryceePkgs.tst-tab-search
            ryceePkgs.tst-wheel-and-double
            #ryceePkgs.pushbullet # TODO: Determine if I actually want this.
            ryceePkgs.tab-counter-plus
            ryceePkgs.tab-reloader
            ryceePkgs.terms-of-service-didnt-read
            ryceePkgs.tomato-clock
            ryceePkgs.toolkit-for-ynab
            ryceePkgs.torrent-control

            # Privacy Stuff
            ryceePkgs.duckduckgo-privacy-essentials
            ryceePkgs.canvasblocker
            ryceePkgs.censor-tracker
            ryceePkgs.clearurls
            ryceePkgs.decentraleyes
            ryceePkgs.link-cleaner
            ryceePkgs.ninja-cookie
            ryceePkgs.privacy-possum
            ryceePkgs.proton-vpn

            # Security Stuff
            ryceePkgs.ublock-origin
            ryceePkgs.privacy-badger
            ryceePkgs.disable-javascript
            ryceePkgs.user-agent-string-switcher

            # Site Enhancements Stuff

            ## General
            ryceePkgs.native-mathml
            ryceePkgs.new-tab-override
            ryceePkgs.re-enable-right-click


            ## Github
            bandiPkgs.enhanced-github
            bandiPkgs.octolinker
            bandiPkgs.github-code-folding
            bandiPkgs.github-repo-size
            bandiPkgs.material-icons-for-github
            ryceePkgs.buster-captcha-solver

            ## SoundCloud
            ryceePkgs.darkcloud

            ## YouTube
            ryceePkgs.enhancer-for-youtube

            # Social Stuff
            bandiPkgs.pronoundb
            bandiPkgs.reddit-enhancement-suite
            bandiPkgs.sponsorblock
            ryceePkgs.betterttv
            ryceePkgs.blocktube

            # MuseScore
            ryceePkgs.musescore-downloader

            # Reddit
            ryceePkgs.old-reddit-redirect

            # Unreviewed

            # ryceePkgs.https-everywhere
            # ryceePkgs.bitwarden
            # ryceePkgs.clearurls
            # ryceePkgs.floccus
            # ryceePkgs.ghostery
            # ryceePkgs.privacy-redirect
            # ryceePkgs.privacy-badger
            # ryceePkgs.languagetool
            # ryceePkgs.disconnect
            # ryceePkgs.react-devtools

            # Broken

            # ryceePkgs.bypass-paywalls-clean # BUG: Broken link
          ];
        userChrome = '' '';
        userContent = '' '';
      };
    };
  };
};
}
