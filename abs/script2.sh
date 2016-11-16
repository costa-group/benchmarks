#Pablo, change the absfrontend path when you check everything is ok in your computer. 
  for dic in `ls -d */`
   do
   cd $dic
     for file in `ls *.abs`
     do
     mv $file $file".abs"
     java -jar /Users/Mike/Systems/abstools/frontend/dist/absfrontend.jar $file".abs"
    if [ $? == 0 ]; then 
       echo "Correcto... $file"
       mv $file".abs" $file
    else 
       echo "Error sintáctico en.... $file"
       mv $file".abs" $file"_error"
    fi
    done
  cd ..
  for file in `ls *.abs`
    do
    mv $file $file".abs"
    java -jar /Users/Mike/Systems/abstools/frontend/dist/absfrontend.jar $file".abs"
    if [ $? == 0 ]; then 
       echo "Correcto... $file"
       mv $file".abs" $file
    else 
       echo "Error sintáctico en.... $file"
       mv $file".abs" $file"_error"
    fi
    done
  done
  cd ..
#done

for file in `ls *.abs`
do 
    mv $file $file".abs"
    java -jar /Users/Mike/Systems/abstools/frontend/dist/absfrontend.jar $file".abs"
    if [ $? == 0 ]; then 
       echo "Correcto... $file"
       mv $file".abs" $file
    else 
       echo "Error sintáctico en.... $file"
#       NAMELIST=$(echo $file | awk -F ".abs$" '{print $1}')
#       echo ${NAMELIST}
       mv $file".abs" $file"_error"
    fi
done



