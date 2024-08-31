VERSION = 0.8.0
PROGRAM_NAME = pass-rofi-sc-ctrl


PREFIX ?= /usr
PATH_BIN ?= $(PREFIX)/bin
PATH_MAN ?= $(PREFIX)/share/man/man1
PATH_SKEL ?= $(PREFIX)/share/$(PROGRAM_NAME)
PATH_CONFIG ?= $(HOME)/.config/$(PROGRAM_NAME)
Q ?= @

src/$(PROGRAM_NAME).src.tmp: src/$(PROGRAM_NAME).src 
# it will only be executed if src/$(PROGRAM_NAME).src is newer than src/$(PROGRAM_NAME).src.tmp
# if src/$(PROGRAM_NAME).src.tmp does not exist, it will be created
# You can use e.g.  create-tmp, if it does not matter if the file is newer or not 
	$(Q)sed -e "s|@PROGRAM_NAME@|$(PROGRAM_NAME)|g" -e "s|@VERSION@|$(VERSION)|g" -e "s|@PATH_SKEL@|$(PATH_SKEL)|g" src/$(PROGRAM_NAME).src > src/$(PROGRAM_NAME).src.tmp

clean:
	$(Q)rm -f src/$(PROGRAM_NAME).src.tmp

install: src/$(PROGRAM_NAME).src.tmp # call the target src/$(PROGRAM_NAME).src.tmp to ensure it is created
	$(Q)install -Dm755 src/$(PROGRAM_NAME).src.tmp $(DESTDIR)$(PATH_SKEL)/$(PROGRAM_NAME) # install the file with the correct permissions
	$(Q)ln -sf $(DESTDIR)$(PATH_SKEL)/$(PROGRAM_NAME) $(DESTDIR)$(PATH_BIN)/$(PROGRAM_NAME) # create a symlink to the global user binary

uninstall:
	$(Q)rm -f $(DESTDIR)$(PATH_BIN)/$(PROGRAM_NAME) # remove the symlink
	$(Q)rm -rf $(DESTDIR)$(PATH_SKEL) # remove the directory

uninstall-all: uninstall
	$(Q)rm -f $(PATH_CONFIG)/$(PROGRAM_NAME).conf # remove the user configuration file

