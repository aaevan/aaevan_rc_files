#requires yeelight-shell-scripts repo in same directory

for NUM in `seq 100`;
do
    ./yeelight-shell-scripts/yeelight-brightness.sh 0 $NUM;
    sleep 10; 
done

