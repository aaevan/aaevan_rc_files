eval $(xdotool getmouselocation --shell)
x_resolution=1600
x_real=$(($x_resolution - $X - 10))
y_real=$(($Y - 37))
DURATION=10
DIRECTION='left'
string_output="-->"

while getopts ":d:rl" opt; do
  case $opt in
    d)
      echo "-d was triggered, Parameter: $OPTARG" >&2
      DURATION=$OPTARG
      ;;
    r)
      echo "-r was triggered, Parameter: $OPTARG" >&2
      DIRECTION='right'
      ;;
    l)
      echo "-l was triggered, Parameter: $OPTARG" >&2
      DIRECTION='left'
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

echo direction:$DIRECTION

if [ $DIRECTION == "left" ]; then
    echo "to the left!"
    x_real=$(($x_resolution - $X - 10))
    y_real=$(($Y - 37))
    string_output="-->"
elif [ $DIRECTION == "right" ]; then
    echo "to the right!"
    x_real=$(($x_resolution - $X - 84))
    y_real=$(($Y - 37))
    string_output="<--"
fi


echo $string_output | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y_real -i $x_real -d $DURATION -O 3 --color=green &
echo x:$X y:$Y
