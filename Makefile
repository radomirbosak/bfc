install:
	if [ ! -d "/usr/share/bfc" ]; then mkdir /usr/share/bfc; fi
	cp bfcskel.asm bfpreproc.py /usr/share/bfc/
	cp bfc /usr/bin/
	chmod g+x,o+x /usr/bin/bfc
