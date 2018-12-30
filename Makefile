CC=gcc
LDFLAGS=$(shell pkg-config --libs ncurses)
CFLAGS=$(shell pkg-config --cflags  ncurses) -O2 -Wall -std=c99 -I. -DNCURSES_WIDECHAR=1
#CFLAGS+= -ffunction-sections -fdata-sections
#LDFLAGS+= --gc-sections
DESTDIR=/usr/local/

OFILES=buffers.o \
	configfile.o \
	correlation.o \
	gpl.o \
	hexcalc.o \
	input.o \
	machine_type.o \
	main.o \
	markers.o \
	menu.o \
	output.o \
	search.o \
	ui.o

all:dhex

dhex:$(OFILES)
	$(CC)  -o $@ $(OFILES) $(LDFLAGS) $(LIBS)

install:all
	strip dhex
	cp dhex $(DESTDIR)/bin
	cp dhex.1 $(DESTDIR)/man/man1
	cp dhexrc.5 $(DESTDIR)/man/man5
	cp dhex_markers.5 $(DESTDIR)/man/man5
	cp dhex_searchlog.5 $(DESTDIR)/man/man5

.c.o:
	$(CC) -c $(CFLAGS) $<

clean:
	rm -f dhex $(OFILES)
