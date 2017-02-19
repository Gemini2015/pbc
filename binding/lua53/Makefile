CC = gcc
CFLAGS = -O2 -fPIC -Wall
LUADIR = /usr/local/include
TARGET = protobuf.so

.PHONY : all clean macosx

all : $(TARGET)

$(TARGET) : pbc-lua53.c
	$(CC) $(CFLAGS) -shared -o $@ -I../.. -I$(LUADIR) -L../../build $^ -lpbc

macosx: pbc-lua53.c
	$(CC) -O2 -bundle -undefined dynamic_lookup -o $(TARGET) $^ -L../../build -lpbc -I../.. -I$(LUADIR)

clean :
	rm -f $(TARGET)
