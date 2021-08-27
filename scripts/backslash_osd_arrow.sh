#read -r width height x y <<<$(import -identify /home/aaron/screens/screenshot$(date '+%m-%d-%y_%H-%M-%S').png | awk '{print $4}' | tr "x" " " | tr "+" " ")

#the identify flag gives lots of info about screenshot geometry
#the filename should really be fed to somewhere where it's immediately deleted?
#awk here is pulling out arguments and separating them with a space
#tr "x" " " replaces instances of x with a space
read -r width height screenx screeny x1 y1 <<<$(import -identify /home/aaron/screens/screenshot$(date '+%m-%d-%y_%H-%M-%S').png | awk '{print $3 " " $4}' | tr "x" " " | tr "+" " ")

x2=$(($x+$width))
y2=$(($y+$height))

echo screenx:$screenx screeny:$screeny width:$width height:$height x1:$x1 y1:$y1 x2:$x2 y2:$y2

#does weird bullshit with multiple screens. gotta figure out better absolute coordinates with osd_cat?
echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y1 -i $x1 -d 60 --color="#ff0000" &
echo . | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset=$y2 -i $x2 -d 60 --color="#00ff00" &
