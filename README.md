# Bin

A set of static, clang-built binaries for multiple [platforms](https://github.com/nix-systems/default/blob/da67096a3b9bf56a91d16901293e51ba5b49a27e/default.nix), built with nix. About half of them will fail to build, until `pkgs/top-level/stage.nix` gets better support.

Successful builds are available in [latest release](https://github.com/usertam/bin/releases/latest).

## Fixed dependencies
- aarch64-darwin: `nixpkgs#pkgsLLVM.stdenv.cc.bintools.bintools`

## Broken dependencies
- aarch64-linux and x86_64-linux: `nixpkgs#pkgsStatic.pkgsLLVM.gmp`, (but not with single `pkgsStatic` or `pkgsLLVM`)  
```
checking C++ compiler aarch64-unknown-linux-musl-clang++  -O2 -pedantic -march=armv8-a... no, std iostream
checking C++ compiler aarch64-unknown-linux-musl-clang++  -g -O2... no, std iostream
configure: error: C++ compiler not available, see config.log for details
```
- aarch64-linux and x86_64-linux: `ncurses-static-aarch64-unknown-linux-musl-6.4`, `boehm-gc-static-aarch64-unknown-linux-musl-8.2.4`, ...
```
[...]
aarch64-unknown-linux-musl-ld: error: undefined symbol: std::exception::~exception()
aarch64-unknown-linux-musl-ld: error: undefined symbol: typeinfo for std::exception
aarch64-unknown-linux-musl-ld: error: undefined symbol: __cxa_pure_virtual
aarch64-unknown-linux-musl-ld: error: too many errors emitted, stopping now (use --error-limit=0 to see all errors)
clang++: error: linker command failed with exit code 1 (use -v to see invocation)
```
- aarch64-linux: `gnugrep-static-aarch64-unknown-linux-musl-3.11`
```
============================================================================
Testsuite summary for GNU grep 3.11
============================================================================
# TOTAL: 127
# PASS:  108
# SKIP:  16
# XFAIL: 2
# FAIL:  1
# XPASS: 0
# ERROR: 0
============================================================================
See tests/test-suite.log
Please report to bug-grep@gnu.org
============================================================================
make[3]: *** [Makefile:2309: test-suite.log] Error 1
make[3]: Leaving directory '/build/grep-3.11/tests'
make[2]: *** [Makefile:2417: check-TESTS] Error 2
make[2]: Leaving directory '/build/grep-3.11/tests'
make[1]: *** [Makefile:3378: check-am] Error 2
make[1]: Leaving directory '/build/grep-3.11/tests'
make: *** [Makefile:1844: check-recursive] Error 1
```
- aarch64-darwin: `system_cmds` > `meson` > `openldap`
```
test failed - provider and consumer databases differ
>>>>> 00:25:49 Failed   test018-syncreplication-persist for mdb after 122 seconds
```
- aarch64-darwin: `libcxx`, nix daemon crashed
```
don't know how to build these paths:
  /nix/store/dwsxfqvig15bzbmh7f072ln7y6z290dk-libcxx-16.0.6-dev
  /nix/store/hs9gmci0mkjgb8czkyixn57ba6fim1ry-libcxx-16.0.6
  /nix/store/w2s2a3q8xwd5frspaqpmfsyidybjq76i-expand-response-params
[...]
error: Nix daemon disconnected unexpectedly (maybe it crashed?)
```
- x86_64-darwin:
```
error:
… while calling the 'derivationStrict' builtin
  at <nix/derivation-internal.nix>:9:12:
     8|
     9|   strict = derivationStrict drvAttrs;
      |            ^
    10|

… while evaluating derivation 'bash-static-x86_64-apple-darwin-5.2p26'
  whose name attribute is located at /nix/store/gqsny7pjz6n08x3aghm0z26nl9xd2v16-source/pkgs/stdenv/generic/make-derivation.nix:331:7

… while evaluating attribute 'NIX_CFLAGS_LINK' of derivation 'bash-static-x86_64-apple-darwin-5.2p26'
  at /nix/store/gqsny7pjz6n08x3aghm0z26nl9xd2v16-source/pkgs/stdenv/adapters.nix:136:7:
   135|     (mkDerivationSuper args).overrideAttrs (prevAttrs: {
   136|       NIX_CFLAGS_LINK = toString (prevAttrs.NIX_CFLAGS_LINK or "")
      |       ^
   137|         + lib.optionalString (stdenv.cc.isGNU or false) " -static-libgcc";

(stack trace truncated; use '--show-trace' to show the full trace)

error: don't yet have a `targetPackages.darwin.LibsystemCross for x86_64-apple-darwin`
```
- and more after them

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
