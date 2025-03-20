let
 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/2025-03-17.tar.gz") {};
 
  pypkgs = builtins.attrValues {
    inherit (pkgs.python312Packages) 
      pandas
      polars
      pyarrow;
  };

  system_packages = builtins.attrValues {
    inherit (pkgs) 
      glibcLocales
      glibcLocalesUtf8
      nix
      python312;
  };
  
shell = pkgs.mkShell {
  LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then "${pkgs.glibcLocales}/lib/locale/locale-archive" else "";
  LANG = "en_US.UTF-8";
   LC_ALL = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";

  buildInputs = [ pypkgs system_packages ];
  
};
in
{
  inherit pkgs shell;
}