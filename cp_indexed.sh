#!sh
set -x
test -d $HOME/Desktop/stage/Marpa--R2/cpan/libmarpa/dev || exit 1
(cd $HOME/Desktop/stage/Marpa--R2/cpan/libmarpa/dev && make ../doc/api.html/index.html)
test -d libmarpa_api || exit 1
rm -rf libmarpa_api/cpan_indexed
mkdir libmarpa_api/cpan_indexed
test -d $HOME/Desktop/stage/Marpa--R2/cpan/libmarpa/doc/api.html || exit 1
(cd libmarpa_api/cpan_indexed && rm *.html)
(cd libmarpa_api/cpan_indexed && perl ../../api_doc_here.pl $HOME/Desktop/stage/Marpa--R2/cpan/libmarpa/doc/api.html)
