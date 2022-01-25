def main():
    video_length = input("Video length? (hh:mm:ss): ")
    split_vals = [int(val) for val in video_length.split(":")]
    if len(split_vals) == 3:
        hh, mm, ss = split_vals
    elif len(split_vals) == 2:
        hh, mm, ss = (0, *split_vals)
    else:
        print(f'Bad input ("{video_length}"), exiting')
        exit()
    pomo_length = 25 * 60 # assuming a 25m pomodoro
    total_seconds = (hh * 3600) + (mm * 60) + ss
    stretch_factor = round(total_seconds / pomo_length, 1)
    print(f"\nWith a run time of {hh}:{mm}:{ss} (total seconds: {total_seconds})")
    print(f"... run your video at {stretch_factor}x speed to fit within 25m.\n")

if __name__ == "__main__":
    main()
