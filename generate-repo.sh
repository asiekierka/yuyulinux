#!/bin/sh
cd packages
rm core.db
rm core.db.tar.gz
for i in *.pkg.tar.xz; do repo-add core.db.tar.gz $i; done
rm core.db.tar.gz.old
cd ..
