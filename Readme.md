# PHP

You can install php with:

```shell
wapm install php
```

*Note: The first time you execute `wapm run php` will take up to 1 minute (spent on compilation). Next times will be instant. We are working on making it instant on the first run.*

*Note: This project is a fork of the original pib (PHP in Browser) implementation: [pib](https://github.com/oraoto/pib).*

## Running

You can run any php file.

```shell
$ wapm run php examples/rot13.php "Hello World"
Uryyb Jbeyq
```

## Building from Source

You will need Emscripten SDK (emsdk) to build the `php.wasm` file.

Steps:

1. Setup emsdk (>= 1.38.11), see [Installation Instructions](https://github.com/juj/emsdk#installation-instructions)
2. Run `bash build.sh`
