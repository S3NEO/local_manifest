# local_manifest
## Description
Puts repo local manifest into .repo folder for your revision

## Usage
```bash
$ ./use_local_manifest.sh
Welcome! Choose device (or number) to use local manifest from (Android 11):
1) s3ve3gxx 2) s3ve3gjv 3) s3ve3gds 4) milletwifi 5) milletlte 6) milletltetmo 7) millet3g 8) matissewifi 9) matisselte 
chman> s3ve3gxx
OK (using alias to 1)
Where's your sources directory?
chman> /home/roman/11-android
Putting manifest...
All done.

# Then, do repo sync in sources directory
$ cd /home/roman/11-android
$ repo sync
```
