#!/bin/bash
#
# repo local manifest changer
#

SCRIPTDIR="$PWD"

echo "For what revision are you want to build? (xx,jv,ds)"
echo ""
echo -n "manifest changer> "
read revision
case "$revision" in
xx) echo "Sony camera choosed"
;;
jv) echo "Samsung camera choosed"
;;
ds) echo "Duos choosed"
;;
*)
;;
esac

echo "Please enter directory with Android OS source:"
echo ""
echo -n "manifest changer> $HOME/"
read androidsource
if [ -d "$HOME/$androidsource" ]; then
androidsource="$HOME/$androidsource"
echo "Creating folder..."
mkdir $androidsource/.repo/local_manifests
echo "Putting manifest..."
cp $SCRIPTDIR/manifests/main.xml $androidsource/.repo/local_manifests/s3ve3g_main.xml
cp $SCRIPTDIR/manifests/s3ve3g$revision.xml $androidsource/.repo/local_manifests/s3ve3g$revision.xml
echo "Done! Please do 'repo sync' in Android source directory for S3 Neo sources download."
else
echo "Invalid directory! Abort..." && exit 0
fi
