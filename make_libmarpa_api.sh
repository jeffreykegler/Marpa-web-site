#!sh

rm -rf libmarpa_api/latest
mkdir libmarpa_api/latest
cd libmarpa_api/latest
(cd ../../../r2/r2/libmarpa/doc/api.html; tar -cf - .) | tar -xvf -
