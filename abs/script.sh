echo $1
# for dic in `ls -d */`
# do
#   cd $dic
  for dic in `ls -d */`
  do
  cd $dic
    for file in `ls *.abs`
    do
    echo "Renombrando... $file"
    mv $file $file$1
    done
  cd ..
  for file in `ls *.abs`
    do
    echo "Renombrando... $file"
    mv $file $file$1
    done
  done
#  cd ..
#done

for file in `ls *.abs`
do
echo "Renombrando... $file"
mv $file $file$1
done



