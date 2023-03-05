SELECTION=$(@fd@ -e epub -e pdf | @fzf@)

if [ -z "$SELECTION" ]
then
  exit
else
  @zathura@ --fork "${SELECTION}"
fi
