#!sh
set -x
test -d ../r2/cpan/libmarpa/dev || exit 1
(cd ../r2/cpan/libmarpa/dev && make ../doc/api.html/index.html)
test -d libmarpa_api || exit 1
rm -rf libmarpa_api/latest
mkdir libmarpa_api/latest
test -d ../r2/cpan/libmarpa/doc/api.html || exit 1
(cd libmarpa_api/latest && rm *.html)
(cd libmarpa_api/latest && perl ../../api_doc_here.pl ../../../r2/cpan/libmarpa/doc/api.html)
