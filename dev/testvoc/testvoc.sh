#!/usr/bin/env bash

if [[ $2 = "urd-hin" ]]; then
echo "==Urdu->Hindi===========================";
bash inconsistency.sh $1 urd-hin > /tmp/urd-hin.testvoc; bash inconsistency-summary.sh /tmp/urd-hin.testvoc urd-hin
echo ""
elif [[ $2 = "hin-urd" ]]; then
echo "==Hindi->Urdu===========================";
bash inconsistency.sh $1 hin-urd > /tmp/hin-urd.testvoc; bash inconsistency-summary.sh /tmp/hin-urd.testvoc hin-urd
echo "";
fi
