from PIL import Image, ImageFilter

im = Image.open('/home/aaron/Downloads/pil_test.jpeg')
pixels = im.load()

min_sum = 255 * 3
max_sum = 0

for i in range(im.size[0]):
    for j in range(im.size[1]):
        sum_attributes = sum(pixels[i, j])
        if sum_attributes < min_sum:
            min_sum = sum_attributes
        if sum_attributes > max_sum:
            max_sum = sum_attributes
        if sum_attributes > 255:
            pixels[i, j] = (255, 0, 0)

print("max_sum: {}, min_sum: {}".format(max_sum, min_sum))
im.show()


