#!/bin/bash

# Execute from python-debian-skeleton dir

if [ $# -ne 1 ]; then
	echo "Usage: ./initialize.sh repo_new_name"
	exit 1
fi

old_repo=`pwd`
new_repo=$1
sanitized_new_repo=`echo "$new_repo" | sed -r 's/-/_/g'`


if [ -d build/$new_repo ]; then
    rm -rf build/$new_repo
fi

mkdir -p build/$new_repo
cp -r docs/ python-debian-skeleton/ src/ CHANGELOG.rst \
	LICENSE README.rst make_package.sh tools/ build/$new_repo/

cd build/$new_repo/
mv python-debian-skeleton ${new_repo}

mv \
	${new_repo}/usr/bin/python-debian-skeleton \
	${new_repo}/usr/bin/${new_repo}
mv \
	${new_repo}/etc/python-debian-skeleton \
	${new_repo}/etc/${new_repo}
mv \
	${new_repo}/usr/lib/python3.5/dist-packages/python-debian-skeleton \
	${new_repo}/usr/lib/python3.5/dist-packages/${sanitized_new_repo}
mv \
	${new_repo}/usr/lib/python2.7/dist-packages/python-debian-skeleton \
	${new_repo}/usr/lib/python2.7/dist-packages/${sanitized_new_repo}
mv \
	${new_repo}/lib/systemd/system/python-debian-skeleton.service \
	${new_repo}/lib/systemd/system/${new_repo}.service
mv \
	${new_repo}/etc/${new_repo}/python-debian-skeleton.conf \
	${new_repo}/etc/${new_repo}/${new_repo}.conf

mv src/python-debian-skeleton src/${sanitized_new_repo}
mv src/python-debian-skeleton.conf src/${new_repo}.conf
mv src/python-debian-skeleton.conf-prod src/${new_repo}.conf-prod
mv src/python-debian-skeleton.py src/${sanitized_new_repo}.py

find . \
	-exec sed \
	-i "s/python-debian-skeleton-sanitized/${sanitized_new_repo}/g" {} \; &> /dev/null
find . \
	-exec sed \
	-i "s/python-debian-skeleton/${new_repo}/g" {} \; &> /dev/null

cd - > /dev/null

echo "Done. New python-debian-skeleton generated at: build/$new_repo"

exit 0
