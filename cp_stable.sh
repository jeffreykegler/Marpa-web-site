#!sh
set -x

# NOTE: This is NOT portable
# It relies on my directory layout
libmarpa_dir=$HOME/projects/libmarpa

if test -d $libmarpa_dir
then :
else
    echo $libmarpa_dir not found 1>&2
    exit 1
fi

# These are the "configurable" settings
branch=stable
target_d=libmarpa_api/stable

source_d=stage/$branch.d
work_d=$source_d/work
dev_d="$work_d"/dev
doc_d="$work_d"/doc
doc1_d="$work_d"/doc1

test -d stage || mkdir stage
rm -rf $source_d
git clone -b "$branch" file://$libmarpa_dir "$source_d"

test -d "$dev_d" || exit 1
(cd "$dev_d" && make ../doc/api.html/index.html)
test -d libmarpa_api || exit 1
(cd $source_d && make doc_dist doc1_dist)
rm -rf "$target_d"
mkdir "$target_d"
test -d "$doc_d" || exit 1
(cd $doc_d && ./configure && make html)
test -d "$doc1_d" || exit 1
(cd $doc1_d && ./configure && make html)
(cd "$target_d" && rm *.html)
(cd "$target_d" && perl ../../api_doc_here.pl "../../$doc_d/api.html")
cp "$doc1_d/api.html" temp/api_one_page.html
(cd "$target_d" && perl ../../api_doc_here.pl ../../temp/api_one_page.html)
