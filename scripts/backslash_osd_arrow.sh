#read -r width height x y <<<$(import -identify /home/aaron/screens/screenshot$(date '+%m-%d-%y_%H-%M-%S').png | awk '{print $4}' | tr "x" " " | tr "+" " ")

#the identify flag gives lots of info about screenshot geometry
#the filename should really be fed to somewhere where it's immediately deleted?
#awk here is pulling out arguments and separating them with a space
#tr "x" " " replaces instances of x with a space
read -r width height screenx screeny x1 y1 <<<$(import -identify /home/aaron/screens/screenshot$(date '+%m-%d-%y_%H-%M-%S').png | awk '{print $3 " " $4}' | tr "x" " " | tr "+" " ")

x_offset=19
y_offset=45

x2=$(($screenx-$x1))
y2=$(($screeny-$y1))

x3=$(($x2-$x_offset))
y3=$(($y1-$y_offset))

x4=$(($x3-$width))
y4=$(($y3+$height))

echo screenx:$screenx screeny:$screeny width:$width height:$height 
echo x1:$x1 y1:$y1 x2:$x2 y2:$y2 x3:$x3 y3:$y3

#does weird bullshit with multiple screens.
#I've gotta figure out how to get absolute coordinates with multiple screens 
# and translate that to what osd_cat uses.

echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y3 -i $x3 -d 60 --color="#ff0000" &
echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y4 -i $x4 -d 60 --color="#00ff00" &
echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y3 -i $x4 -d 60 --color="#0000ff" &
echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y4 -i $x3 -d 60 --color="#ffffff" &
