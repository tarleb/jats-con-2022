PANDOC = pandoc

paper.jats.xml: paper.md filters/abstract-to-meta.lua
	$(PANDOC) \
	    --defaults=data/shared.yaml \
	    --to=jats_articleauthoring+element_citations \
	    --output=$@ \
	    $<

paper.pdf: paper.md filters/abstract-to-meta.lua
	$(PANDOC) \
	    --defaults=data/shared.yaml \
	    --to=latex \
	    --pdf-engine=lualatex \
	    --output=$@ \
	    $<
