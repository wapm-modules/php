#!/usr/bin/env bash

set -e

PHP_VERSION=7.3.0
PHP_PATH=php-${PHP_VERSION}
PHP_SHA256SUM=7d195cad55af8b288c3919c67023a14ff870a73e3acc2165a6d17a4850a560b5

echo "Get PHP source"
wget https://php.net/distributions/${PHP_PATH}.tar.xz
echo "${PHP_SHA256SUM}  ${PHP_PATH}.tar.xz" | sha256sum -c
tar xf ${PHP_PATH}.tar.xz
rm ${PHP_PATH}.tar.xz

echo "Apply patch"
patch -p0 -i mods.diff
patch -p0 -i osx_fix.diff

echo "Configure"
cd $PHP_PATH
emconfigure ./configure \
  --disable-all \
  --disable-cgi \
  --disable-rpath \
  --with-valgrind=no \
  --without-pear \
  --without-pcre-jit \
  --with-layout=GNU \
  --enable-embed=static \
  --enable-bcmath \
  --enable-json \
  --enable-ctype \
  --enable-tokenizer \
  --enable-mbstring \
  --disable-mbregex 

echo "Build"
emmake make cli -j8
# rename bitcode file to something EMCC will accept
cp sapi/cli/php sapi/cli/php.o

emcc -O3 \
  -g2 \
  --llvm-lto 2 \
  -s EXPORTED_FUNCTIONS='["_pib_eval", "_php_embed_init", "_zend_eval_string", "_php_embed_shutdown", "_main", "main"]' \
  -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall"]' \
  -s MODULARIZE=1 \
  -s EXPORT_NAME="'PHP'" \
  -s TOTAL_MEMORY=536870912 \
  -s ASSERTIONS=0 \
  -s INVOKE_RUN=0 \
  -s ERROR_ON_UNDEFINED_SYMBOLS=0 \
  sapi/cli/php.o -o php.wasm

cp php.wasm ..

echo "Done"
