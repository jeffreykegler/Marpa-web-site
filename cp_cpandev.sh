#!sh
set -x
work_d=$HOME/stage/libmarpa.d/cpandev.d/work
dev_d="$work_d"/dev
doc_d="$work_d"/doc
test -d "$dev_d" || exit 1
(cd "$dev_d" && make ../doc/api.html/index.html)
test -d libmarpa_api || exit 1
rm -rf libmarpa_api/cpan_indexed
mkdir libmarpa_api/cpan_indexed
test -d "$doc_d" || exit 1
(cd libmarpa_api/cpan_indexed && rm *.html)
(cd libmarpa_api/cpan_indexed && perl ../../api_doc_here.pl "$doc_d/api.html")
