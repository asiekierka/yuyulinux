#!/bin/sh
mkdir -p "$1"/getty-tty$2
cat >"$1"/getty-tty$2/run <<-"EOF"
#!/bin/sh
exec /bin/getty 38400 tty_TN_ linux
EOF
cat >"$1"/getty-tty$2/finish <<-"EOF"
#!/bin/sh
exec utmpset -w tty_TN_
EOF
sed -i "s/_TN_/"$2"/g" "$1"/getty-tty$2/finish
sed -i "s/_TN_/"$2"/g" "$1"/getty-tty$2/run
chmod +x "$1"/getty-tty$2/finish
chmod +x "$1"/getty-tty$2/run
