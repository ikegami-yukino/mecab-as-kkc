.PHONY: update_mozc build install uninstall clean

MECAB_LIBEXEC_DIR = $(shell mecab-config --libexecdir)
MECAB_DIC_DIR = $(shell mecab-config --dicdir)

MATRIX_DEF = matrix.def
LEX_CSV = lex.csv

all: build

update_mozc:
	git submodule init
	git submodule update

$(MATRIX_DEF):
	./script/generate_matrix_def.py

$(LEX_CSV):
	cat mozc/src/data/dictionary_oss/dictionary*.txt | tr "\\t" "," | grep -v "^," > mecab-as-kkc/lex.csv

build: update_mozc $(MATRIX_DEF) $(LEX_CSV)
	$(MECAB_LIBEXEC_DIR)/mecab-dict-index -d mecab-as-kkc -o mecab-as-kkc

install:
	@if [ ! -d ${MECAB_DIC_DIR}/mecab-as-kkc ] ; then\
		mkdir $(MECAB_DIC_DIR)/mecab-as-kkc;\
	fi
	install mecab-as-kkc/* $(MECAB_DIC_DIR)/mecab-as-kkc/

uninstall:
	$(RM) -r $(MECAB_DIC_DIR)/mecab-as-kkc

clean:
	$(RM) mecab-as-kkc/*.bin
	$(RM) mecab-as-kkc/*.dic
	$(RM) mecab-as-kkc/lex.csv
	$(RM) mecab-as-kkc/matrix.def
