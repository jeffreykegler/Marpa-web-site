#!sh
set -x
work_d=$HOME/stage/libmarpa.d/cpandev.d/work
dev_d="$work_d"/dev
doc_d="$work_d"/doc
target_d=libmarpa_api/cpan_developer
test -d "$dev_d" || exit 1
(cd "$dev_d" && make ../doc/api.html/index.html)
test -d libmarpa_api || exit 1
rm -rf "$target_d"
mkdir "$target_d"
test -d "$doc_d" || exit 1
(cd "$target_d" && rm *.html)
(cd "$target_d" && perl ../../api_doc_here.pl "$doc_d/api.html")
