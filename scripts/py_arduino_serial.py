#!/usr/bin/python
import serial
import time

def main():
    for i in xrange(10):
        try:
            #assuming your arduino appears in /dev as ttyACM<number>
            print("Trying /dev/ttyACM" + str(i) + "...")
            arduino = serial.Serial('/dev/ttyACM'+str(i), 9600, timeout=.1)
            print("Success! Connecting...")
            time.sleep(1)
            break
        except:
            print("/dev/ttyACM" + str(i) + " didn't work.")
    while True:
        data = arduino.readline()[:-2] #the last bit gets rid of the new-line chars
        if data:
            print data

def stop():
    print("\nGot keyboard interrupt, Stopping!")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        stop()

