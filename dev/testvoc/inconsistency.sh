#!/usr/bin/env bash

TMPDIR=/tmp

DICT=$1
DIR=$2

SED=sed

if [[ $DIR = "urd-hin" ]]; then

# Run the bilingual dictionary before to make sure we are only checking things we have.
lt-expand $DICT | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | $SED 's/:>:/%/g' | $SED 's/:/%/g' | cut -f2 -d'%' |  $SED 's/^/^/g' | $SED 's/$/$ ^.<sent>$/g' | apertium-pretransfer | lt-proc -b ../../urd-hin.autobil.bin | grep -v '/@' | cut -f1 -d'/' | $SED 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |\
        apertium-pretransfer|\
	lt-proc -b ../../urd-hin.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |\
        apertium-transfer -b ../../apertium-urd-hin.urd-hin.t1x  ../../urd-hin.t1x.bin | tee $TMPDIR/$DIR.tmp_testvoc3.txt |\
        lt-proc -d ../../urd-hin.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | $SED 's/\^.<sent>\$//g' | $SED 's/_/   --------->  /g'

elif [[ $DIR = "hin-urd" ]]; then 

# Run the bilingual dictionary before to make sure we are only checking things we have.
lt-expand $DICT | grep -v '<prn><enc>' | grep -v 'REGEX' | grep -v ':<:' | $SED 's/:>:/%/g' | $SED 's/:/%/g' | cut -f2 -d'%' |  $SED 's/^/^/g' | $SED 's/$/$ ^.<sent>$/g' | apertium-pretransfer | lt-proc -b ../../hin-urd.autobil.bin | grep -v '/@' | cut -f1 -d'/' | $SED 's/$/$ ^.<sent>$/g' | tee $TMPDIR/$DIR.tmp_testvoc1.txt |\
        apertium-pretransfer|\
	lt-proc -b ../../hin-urd.autobil.bin | tee $TMPDIR/$DIR.tmp_testvoc2.txt |\
        apertium-transfer -b ../../apertium-urd-hin.hin-urd.t1x  ../../hin-urd.t1x.bin | tee $TMPDIR/$DIR.tmp_testvoc3.txt |\
        lt-proc -d ../../hin-urd.autogen.bin > $TMPDIR/$DIR.tmp_testvoc4.txt
paste -d _ $TMPDIR/$DIR.tmp_testvoc1.txt $TMPDIR/$DIR.tmp_testvoc2.txt $TMPDIR/$DIR.tmp_testvoc3.txt $TMPDIR/$DIR.tmp_testvoc4.txt | $SED 's/\^.<sent>\$//g' | $SED 's/_/   --------->  /g'

else
	echo "bash inconsistency.sh <direction>";
fi
