from PIL import Image, ImageSequence
from copy import deepcopy
import os

def unify_size_list(images, width, height):
	max_width = 0
	max_height = 0

	for i in range(len(images)):
		cur_width, cur_height = images[i].size
		max_width = max(max_width, cur_width)
		max_height = max(max_height, cur_height)
	
	if width == 0 and height == 0:
		width = max_width
		height = max_height
	elif width == 0:
		width = height
	elif height == 0:
		height = width

	for i in range(len(images)):
		images[i] = unify_size(images[i], width, height)

def unify_size(image, width, height):
	cur_width, cur_height = image.size
	ret_image = Image.new("RGB", (width, height), (0, 0, 0)) # background (black)
	
	if height > int(cur_height * width / cur_width):
		new_width, new_height = width, int(cur_height * width / cur_width)
		image = image.resize((new_width, new_height))
		box =  (0, int((height - new_height)/2), width, int((height + new_height)/2))
	else:
		new_width, new_height = int(cur_width * height / cur_height), height
		image = image.resize((new_width, new_height))
		box =  (int((width - new_width)/2), 0, int((width + new_width)/2), height)
	
	ret_image.paste(image, box)
	return ret_image

def get_saturation(value, quadrant):
	if value > 223:
		return 255
	elif value > 159:
		if quadrant != 1:
			return 255
    	
		return 0
	elif value > 95:
		if quadrant == 0 or quadrant == 3:
			return 255
		
		return 0
	elif value > 32:
		if quadrant == 1:
			return 255
	
		return 0
	else:
		return 0

# Floyd-Steinberg Dithering
def dithering(image):
	width, height = image.size

	ret_image = Image.new("RGB", (width, height), (0, 0, 0))
	ret_pixels = ret_image.load()
	origin_pixels = image.load()

	for i in range(0, width - 1, 2):
		for j in range(0, height - 1, 2):
			p1 = origin_pixels[i, j]
			p2 = origin_pixels[i, j + 1]
			p3 = origin_pixels[i + 1, j]
			p4 = origin_pixels[i + 1, j + 1]

			red   = (p1[0] + p2[0] + p3[0] + p4[0]) / 4
			green = (p1[1] + p2[1] + p3[1] + p4[1]) / 4
			blue  = (p1[2] + p2[2] + p3[2] + p4[2]) / 4

			r = [0, 0, 0, 0]
			g = [0, 0, 0, 0]
			b = [0, 0, 0, 0]

			for x in range(0, 4):
				r[x] = get_saturation(red, x)
				g[x] = get_saturation(green, x)
				b[x] = get_saturation(blue, x)

			ret_pixels[i, j]         = (r[0], g[0], b[0])
			ret_pixels[i, j + 1]     = (r[1], g[1], b[1])
			ret_pixels[i + 1, j]     = (r[2], g[2], b[2])
			ret_pixels[i + 1, j + 1] = (r[3], g[3], b[3])

	return ret_image

def dithering_animated_gif(path):
	image = Image.open(path)
	durations = []
	frames = []
	for frame in ImageSequence.Iterator(image):
		cur_image = frame.copy()
		cur_image = cur_image.convert('RGB')
		frames.append(dithering(cur_image))
		durations.append(cur_image.info['duration'])
	frames[0].save(path, format='GIF', append_images=frames[1:], save_all=True, duration=durations, loop=0)
	image.close()

def fade_out(images, durations, n):
	ret_images = []
	ret_images.append(images[0])
	ret_durations = []
	ret_durations.append(durations[0])

	for i in range(1, len(images)):
		images[i] = images[i].convert('RGB')
		width, height = images[i].size
		prev_pixels = images[i-1].load()
		cur_pixels = images[i].load()

		for j in range(n):
			ret_image = Image.new("RGB", (width, height), (0, 0, 0))
			ret_pixels = ret_image.load()
			for w in range(width):
				for h in range(height):
					r = prev_pixels[w, h][0] + int((cur_pixels[w, h][0] - prev_pixels[w, h][0]) * (j+1) / n)
					g = prev_pixels[w, h][1] + int((cur_pixels[w, h][1] - prev_pixels[w, h][1]) * (j+1) / n)
					b = prev_pixels[w, h][2] + int((cur_pixels[w, h][2] - prev_pixels[w, h][2]) * (j+1) / n)
					ret_pixels[w, h] = (r, g, b)
			ret_images.append(ret_image)
			ret_durations.append(durations[i-1] / n)
		ret_images.append(images[i])
		ret_durations.append(durations[i])
	
	return ret_images, ret_durations

"""
FROM_PATH = '/Users/jy/Downloads/from/'
TO_PATH = '/Users/jy/Downloads/to/'

def read_file(images):
	file_list = os.listdir(FROM_PATH)
	file_list.sort()
	for filename in file_list:
		if filename.endswith(".jpg") or filename.endswith(".png") or filename.endswith(".gif"):
			images.append(Image.open(FROM_PATH+filename))

def write_file(images):
	for i in range(len(images)):
		images[i].save(TO_PATH+str(i)+'.jpg')

if __name__ == '__main__':
	images = []
	read_file(images)

	unify_size_list(images, 500, 500)
	images = fade_out(images, 3)

	write_file(images)
"""
