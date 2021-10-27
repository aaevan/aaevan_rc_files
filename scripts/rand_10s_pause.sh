monitor_state="`xset q | grep Monitor`"
echo "monitor_state is: $monitor_state"

aplay ~/scripts/bell.wav -q &

if [[ "$monitor_state" == *"is On"* ]]; then
    rand_val=$RANDOM
    one_in_32=$(($(($rand_val<2000))==1))

    echo "rand_val is $rand_val."
    echo "one_in_32 is $one_in_32."

    if [ $one_in_32 == 1 ];
        then
        aplay ~/scripts/chime.wav -q &
        sleep 40
        killall aplay
    fi
fi

