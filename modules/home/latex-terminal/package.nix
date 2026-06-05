{
  lib,
  pkgs,
  fetchFromGitHub,
  python3Packages,
}:
let
  inherit (python3Packages) buildPythonPackage matplotlib setuptools;
in
buildPythonPackage rec {
  pname = "latex-terminal";
  version = "0.1.1-unstable-2025-02-10";

  src = fetchFromGitHub {
    owner = "GuyAzene";
    repo = "latex-terminal";
    rev = "61937c999af299355894b5354207d731c323067c";
    hash = "sha256-ZvH+PO6G2yEE5rM/jIOkl6Qpx8yee2JnR6NulXypzqU=";
  };

  pyproject = true;
  build-system = [ setuptools ];

  propagatedBuildInputs = [ matplotlib ];

  nativeBuildInputs = [ setuptools ];

  doCheck = false;

  pythonImports = [ "latex_terminal" ];

  meta = with lib; {
    description = "Terminal-native LaTeX rendering using the Kitty graphics protocol";
    homepage = "https://github.com/GuyAzene/latex-terminal";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.unix;
  };
}
