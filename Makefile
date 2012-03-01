all: git-bz.html git-bz.1

%.xml: %.txt
	asciidoc -f asciidoc.conf -d manpage -b docbook $<

%.html: %.txt
	asciidoc -f asciidoc.conf -d manpage $<

%.1: %.xml
	xmlto man $<

upload-html: git-bz.html
	DEST=`git config local.upload-html-dest` ; \
	if [ $$? = 0 ] ; then : ; else echo "upload location not configured" ; exit 1 ; fi ; \
	scp $< $$DEST

clean:
	rm -f git-bz.xml git-bz.html git-bz.1
