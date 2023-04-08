if [ "$#" -lt 1 ]
then
  @grip@ -b --quiet README.md
else
  @grip@ -b --quiet $1
fi
