TEX2PDF = rubber -d

PDF = cv.pdf

all: $(PDF)

%.pdf: %.tex
	$(TEX2PDF) $<
