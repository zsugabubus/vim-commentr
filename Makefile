RM:=rm
VIM?=nvim
VIMFLAGS?=-u NONE

helptags: doc/tags

doc/tags: doc/commentr.txt
	$(VIM) $(VIMFLAGS) --cmd 'helptags doc/ | quit'

clean:
	$(RM) doc/tags

.PHONY: clean helptags
