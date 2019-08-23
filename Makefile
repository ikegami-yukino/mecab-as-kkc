.PHONY: update_mozc build install uninstall clean

MECAB_LIBEXEC_DIR = $(shell mecab-config --libexecdir)
MECAB_DIC_DIR = $(shell mecab-config --dicdir)

all: build

update_mozc:
	git submodule init
	git submodule update

build: update_mozc
	./script/generate_matrix_def.py
	cat mozc/src/data/dictionary_oss/dictionary*.txt | tr "\\t" "," | grep -v "^," > mecab-as-kkc/lex.csv
	$(MECAB_LIBEXEC_DIR)/mecab-dict-index -d mecab-as-kkc -o mecab-as-kkc

install:
	cp -r mecab-as-kkc $(MECAB_DIC_DIR)/mecab-as-kkc
	rm $(MECAB_DIC_DIR)/mecab-as-kkc/lex.csv
	rm $(MECAB_DIC_DIR)/mecab-as-kkc/matrix.def

uninstall:
	rm -rf $(MECAB_DIC_DIR)/mecab-as-kkc

clean:
	rm -f mecab-as-kkc/*.bin
	rm -f mecab-as-kkc/*.dic
	rm -f mecab-as-kkc/lex.csv
	rm -f mecab-as-kkc/matrix.def
