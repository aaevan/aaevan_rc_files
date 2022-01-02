#how-to:
#download youtube video mp4 using https://9convert.com/en110 (or similar)
#strip audio from youtube using "ffmpeg -i foo.mp4 bar.mp3"
#using audacity, edit, trim and fade audio to just relevant section.
#export to .WAV (other formats probably work)
#place audio file in relevant directory (~/Scripts in this case)

echo playing "$1" sound effect
#play sound effect and pipe text output of aplay to /dev/null
aplay $1 >/dev/null 2>&1
