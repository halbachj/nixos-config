{ pkgs, ... }:
{
  programs.helix = {
    extraPackages = with pkgs; [
      openjdk21  # or whichever JDK you use
      jdt-language-server
      google-java-format
    ];
    languages.language = [{
      name            = "java";
      language-servers = [ "jdtls" "typos-lsp" ];
      formatter       = { command = "google-java-format"; args = [ "-" ]; };
      roots           = [ ".git" "pom.xml" "build.gradle" ];
    }];
  };
}

