#exercise bell!
echo "waiting 30 seconds..."
sleep 30
echo "Starting!"
for i in `seq 3`
    do
    aplay ~/scripts/bell.wav -q &
    sleep 1
done

sleep 1

for i in `seq 15`
    do
        echo "($i)"
        aplay ~/scripts/bell.wav -q &
    sleep 60
done

#finish: 3*.1, 3*.1
for i in `seq 3`
    do
    aplay ~/scripts/bell.wav -q &
    sleep .12
done
sleep 1
for i in `seq 3`
    do
    aplay ~/scripts/bell.wav -q &
    sleep .12
done
