# dvtm version
VERSION = 0.11

# Customize below to fit your system
PREFIX = /
MANPREFIX = ${PREFIX}/share/man

INCS = -I. -I/include
LIBS = -lc -lutil -lncursesw

CFLAGS += -std=c99 -Os ${INCS} -DVERSION=\"${VERSION}\" -DNDEBUG
LDFLAGS += -L/lib ${LIBS}

DEBUG_CFLAGS = ${CFLAGS} -UNDEBUG -O0 -g -ggdb -Wall -Wextra -Wno-missing-field-initializers -Wno-unused-parameter

CC = cc
