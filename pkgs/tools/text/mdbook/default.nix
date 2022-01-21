{ lib, stdenv, fetchFromGitHub, rustPlatform, CoreServices }:

rustPlatform.buildRustPackage rec {
  pname = "mdbook";
  version = "0.4.12";

  src = fetchFromGitHub {
    owner = "rust-lang";
    repo = "mdBook";
    rev = "v${version}";
    sha256 = "sha256-2lxotwL3Dc9jRA12iKO5zotO80pa+RfUZucyDRgFOsI=";
  };

  cargoSha256 = "sha256-TNd4pj4qSKgmmVtSCSKFCxNtv96xD7+24BPsLXPgiEI=";

  buildInputs = lib.optionals stdenv.isDarwin [ CoreServices ];

  # test 'missing_optional_backends_are_not_fatal' fails on riscv64/qemu due to https://github.com/rust-lang/rust/issues/90825
  doCheck = (!stdenv.hostPlatform.isRiscV);

  meta = with lib; {
    description = "Create books from MarkDown";
    homepage = "https://github.com/rust-lang/mdBook";
    license = [ licenses.mpl20 ];
    maintainers = [ maintainers.havvy ];
  };
}
