for i in `cat $1  |sed 's/ /_/g' | cut -f1 -d'<'`; do 
	echo -ne $i";\t"
	wget http://en.wiktionary.org/wiki/$i -q -O -  | grep -A 400 '>English<' | grep -e Hindi -e Urdu | python /home/fran/scripts/strip_html.py  | python /home/fran/scripts/entities-to-unicode.py  | sed 's/$/; /g' | sh ~/scripts/remove-newline.sh 
done

