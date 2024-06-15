# MeCab as KKC

For using MeCab as a Kana-Kanji converter (KKC), this repository provides scripts to convert Mozc dictionary to MeCab dictionary.

## Dependencies

- Git
- MeCab
  - mecab, mecab-config and mecab-dict-index
  - one dictionary should be installed (Example: ipadic)
- Python 3

## Preparation

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
```

If you do not want to add the dictionary entry, we recommend executing the following commands.
These save the disk usage (about 160MB).

```
$ rm `mecab-config --dicdir`/mecab-as-kkc/lex.csv
$ rm `mecab-config --dicdir`/mecab-as-kkc/matrix.def
```

## Uninstall

```
$ make uninstall
```

or

```
$ rm -r <target directory>/maceb-as-kkc
```

## Example of usage

```
$ echo ここではきものをぬぎます | mecab -d `mecab-config --dicdir`/mecab-as-kkc -N 5
ここでは着物を脱ぎます
ここでは着物を脱ぎます
ここではきものを脱ぎます
ここではきものを脱ぎます
ここで履物を脱ぎます
```

## How to Add new entry to this dictionary

### Formatting
In lex.csv, we can add an entry as 1 line 1 entry.
The line formatting of lex.csv is as follows:

```
めかぶ,670,1250,4000,和布蕪
```

From the left, reading (Hiragana), left-cotext ID, right-context ID, cost, and word are corresponded to.
In this case, the reading "めかぶ" is converted to the word "和布蕪".

### Determine context IDs
left-cotext ID and right-context ID are chosen from `mozc`/src/data/dictionary_oss/id.def` file.

Usually, the following context IDs are used:
```
1837 名詞,サ変接続,*,*,*,*,*
1847 名詞,一般,*,*,*,*,*
1895 名詞,代名詞,一般,*,*,*,*
1916 名詞,固有名詞,一般,*,*,*,*
1917 名詞,固有名詞,人名,一般,*,*,*
1918 名詞,固有名詞,人名,名,*,*,*
1919 名詞,固有名詞,人名,姓,*,*,*
1920 名詞,固有名詞,地域,一般,*,*,*
1921 名詞,固有名詞,地域,一般,*,*,府名
1922 名詞,固有名詞,地域,一般,*,*,県名
1923 名詞,固有名詞,地域,一般,*,*,都名
1924 名詞,固有名詞,地域,国,*,*,*
1925 名詞,固有名詞,組織,*,*,*,*
```

NOTE that choosing the appropriate context ID needs Japanese language domain knowledge.

### Tuning cost
How to tune cost value is as follows:
Give 4000 points cost to the new entry
2. Recompile the dictionary with the following command:
```
$ `mecab-config --libexecdir`/mecab-dict-index -d mecab-as-kkc -o mecab-as-kkc
```
3. Check result:
```
$ echo めかぶ | mecab -d `mecab-config --dicdir`/maceb-as-kkc`
```
4. If the new word "和布蕪" is not the best candidate, then the cost value of the new entry should be decreased gradually

## Limitation

Currently, this repository does not support Kana-Symbol conversion and Kana-Emoji conversion because we do not know how to determine their appropriate costs.

Contributions are welcome.

## License

WTFPL

## Acknowledgments
We thank MeCab and Mozc since this repository relies on them.

- [MeCab](https://taku910.github.io/mecab/)
  - T. Kudo, H. Komatsu, T. Hanaoka, A. Mukai, Y. Tabata, K. Yamamoto, Y. Matsumoto. 2004. Applying Conditional Random Fields to Japanese Morphological Analysis. In Proceedings of the EMNLP 2004, pp 230-237.
- [Mozc](https://github.com/google/mozc)
  - T. Kudo, T. Hanaoka, J. Mukai, Y. Tabata, H. Komatsu. 2011. Efficient dictionary and language model compression for input method editors. In Proceedings of the Workshop on Advances in Text Input Methods (WTIM 2011), pp 19-25.
