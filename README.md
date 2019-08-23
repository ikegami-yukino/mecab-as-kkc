# MeCab as KKC

For using MeCab as a Kana-Kanji converter (KKC), this repository provides scripts to convert Mozc dictionary to MeCab dictionary.

## Dependencies

- Git
- MeCab
  - mecab, mecab-config and mecab-dict-index
- Python 3

## Preparetion

```
$ git clone --depth 1 https://github.com/ikegami-yukino/mecab-as-kkc.git
```

## Build dictionary

```
$ make
```

## Install

```
$ make install
```

or

```
$ cp -r maceb-as-kkc <target directory>/maceb-as-kkc
$ rm <target directory>/maceb-as-kkc/lex.csv
$ rm <target directory>/maceb-as-kkc/matrix.def
```

## Uninstall

```
$ make uninstall
```

## Example of usage

```
$ echo ここではきものをぬぎます | mecab -d `mecab-config --dicdir`/maceb-as-kkc -N 5
ここでは着物を脱ぎます
ここでは着物を脱ぎます
ここではきものを脱ぎます
ここではきものを脱ぎます
ここで履物を脱ぎます
```

## Limitation

Currently, this repository does not support Kana-Symbol conversion and Kana-Emoji conversion because we do not know how to determine their appropriate costs.

Contributions are welcome.

## License

WTFPL

## Acknowledgements

We thank for MeCab and Mozc since this repository rely on them.

- [MeCab](https://taku910.github.io/mecab/)
  - T. Kudo, H. Komatsu, T. Hanaoka, A. Mukai, Y. Tabata, K. Yamamoto, Y. Matsumoto. 2004. Applying Conditional Random Fields to Japanese Morphological Analysis. In Proceedings of the EMNLP 2004, pp 230-237.
- [Mozc](https://github.com/google/mozc)
  - T. Kudo, T. Hanaoka, J. Mukai, Y. Tabata, H. Komatsu. 2011. Efficient dictionary and language model compression for input method editors. In Proceedings of the Workshop on Advances in Text Input Methods (WTIM 2011), pp 19-25.
