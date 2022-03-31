PANDOC = pandoc

paper.jats.xml: paper.md filters/abstract-to-meta.lua
	$(PANDOC) \
	    --standalone \
	    --lua-filter=filters/abstract-to-meta.lua \
	    --to=jats_articleauthoring+element_citations \
	    --output=$@ \
	    $<