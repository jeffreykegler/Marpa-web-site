#!sh
set -x
test -d ../r2/r2/libmarpa/dev || exit 1
(cd ../r2/r2/libmarpa/dev && make ../doc/api.html/index.html)
test -d libmarpa_api/latest || exit 1
test -d ../r2/r2/libmarpa/doc/api.html || exit 1
(cd libmarpa_api/latest && rm *.html)
(cd libmarpa_api/latest && perl ../../api_doc_here.pl ../../../r2/r2/libmarpa/doc/api.html)
