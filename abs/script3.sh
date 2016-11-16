find . -type 'f' \( -name '*.abs2' -o -name '*.abs2' \) | while read f; do g=`echo "$f" | sed -e 's/.abs2/.abs/g'`; mv -- "$f" "$g"; done

for dic in `ls -d */`
  do
  cd $dic
    find . -type 'f' \( -name '*.abs2' -o -name '*.abs2' \) | while read f; do g=`echo "$f" | sed -e 's/.abs2/.abs/g'`; mv -- "$f" "$g"; done
  cd ..
  find . -type 'f' \( -name '*.abs2' -o -name '*.abs2' \) | while read f; do g=`echo "$f" | sed -e 's/.abs2/.abs/g'`; mv -- "$f" "$g"; done

#  cd ..
done

