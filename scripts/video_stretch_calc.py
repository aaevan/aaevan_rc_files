video_length = input("Video length? (hh:mm:ss): ")
hh, mm, ss = [int(val) for val in video_length.split(":")]

total_seconds = (hh * 3600) + (mm * 60) + ss

pomo_length = 25 * 60 # assuming a 25m pomodoro

stretch_factor = round(total_seconds / pomo_length, 1)

print(f"With a run time of {hh}:{mm}:{ss} (total seconds: {total_seconds}")
print(f"... run your video at {stretch_factor} speed to fit within 25m.")
