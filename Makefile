PANDOC = pandoc
TALK_FILE=talk.md
REVEALJS_TGZ = https://github.com/hakimel/reveal.js/archive/4.2.1.tar.gz

paper.jats.xml: paper.md filters/abstract-to-meta.lua
	$(PANDOC) \
	    --defaults=data/shared.yaml \
	    --to=jats_articleauthoring+element_citations \
	    --output=$@ \
	    $<

paper.pdf: paper.md filters/abstract-to-meta.lua
	$(PANDOC) \
	    --defaults=data/latex.yaml \
	    --to=latex \
	    --pdf-engine=lualatex \
	    --output=$@ \
	    $<

talk.html: $(TALK_FILE) reveal.js
	$(PANDOC) \
	    --self-contained \
		  --mathml \
	    --to=revealjs \
	    --slide-level=2 \
		  --variable=theme:serif \
		  --variable=revealjs-url:reveal.js \
	    --output=$@ \
	    $<

reveal.js:
	mkdir -p reveal.js
	curl --location -Ss $(REVEALJS_TGZ) | \
		tar zvxf - -C $@ --strip-components 1

.PHONY: watch
watch:
	find . -type f \! -path './.git/*' \! -path './reveal.js/*' | entr make talk.html

.PHONY: clean
clean:
	rm -f talk.html
