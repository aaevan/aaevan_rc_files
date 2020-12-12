#exercise bell!
for i in `seq 3`
    do
    aplay ~/bell.wav &
    sleep 1
done

sleep 1

for i in `seq 15`
    do
    aplay ~/bell.wav &
    sleep 60
done

#finish: 3*.1, 3*.1
for i in `seq 3`
    do
    aplay ~/bell.wav &
    sleep .12
done
sleep 1
for i in `seq 3`
    do
    aplay ~/bell.wav &
    sleep .12
done
