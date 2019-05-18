from flask import Flask, render_template, request, send_file, after_this_request, jsonify
from PIL import Image, ImageSequence, GifImagePlugin, ImageFile
import os
import image_processing
from wand.image import Image as Image2

app = Flask(__name__)
DOWNLOAD_PATH = "/home/hackday/image/downloads/"
UPLOAD_PATH = "/home/hackday/image/gifs/"


# upload page
@app.route('/api/makeGif', methods = ['POST'])
def upload_file():
	if request.method == 'POST':
		
		data = request.json
		requestId = data['requestId']
		files = data['fileList']
		loopCount = 0
		if 'loopCount' in data:
			loopCount = int(data['loopCount'])

		# make PIL image list
		frames = []
		durations = []
		for f in files:
			file_path = DOWNLOAD_PATH + f['fileName']
			rotate = 0
			if 'rotation' in f:
				rotate = int(f['rotation'])

			image = Image.open(file_path)		
			if image.format == "GIF":
				for frame in ImageSequence.Iterator(image):
					cur_image = frame.copy()
					cur_image = cur_image.rotate(rotate, expand=1)
					frames.append(cur_image)
					durations.append(cur_image.info['duration'])
			else:
				cur_image = image.copy()
				cur_image = cur_image.rotate(rotate, expand=1)
				frames.append(cur_image)
				durations.append(int(f['duration']))
			image.close()

		# images processing (resize images and fill margins)
		width = 0
		height = 0
		if 'width' in data:
			width = int(data['width'])
		if 'height' in data:
			height = int(data['height'])
		image_processing.unify_size_list(frames, width, height)

		# images processing (dithering)
		if 'changeEffect' in data:
			if int(data['changeEffect']) == 1:
				print("Making Fade Out Effect..", requestId)
				frames, durations = image_processing.fade_out(frames, durations, 3)

		# make gif file
		print ("Making gif..", requestId)
		gif_name = requestId + '.gif'
		frames[0].save(UPLOAD_PATH + gif_name, format='GIF', append_images=frames[1:], save_all=True, duration=durations, loop=loopCount)

		# images processing (dithering)
		if 'dithering' in data:
			if data['dithering'] == True:
				print("Dithering..", requestId)
				image_processing.dithering_animated_gif(UPLOAD_PATH + gif_name)

		# images processing (optimizing)
		if 'optimizing' in data:
			if data['optimizing'] == True:
				print("Optimizing..", requestId)
				with Image2(filename=UPLOAD_PATH + gif_name) as img:
					for i, cursor in enumerate(img.sequence):
						cursor.delay = (durations[i] / 10)
					img.type = 'optimize'
					img.save(filename=UPLOAD_PATH + gif_name)

		print (requestId, get_size(os.path.getsize(UPLOAD_PATH + gif_name)))
		return jsonify(
			result="OK",
			requestId=requestId,
			filePath='/image/gifs/'+gif_name
		)

# print gif file size
def get_size(file_size):
	if file_size / 1024.0 > 0:
		file_size /= 1024.0
		if file_size / 1024.0 > 0:
			file_size /= 1024.0
			return ('%.2f' % file_size) + ' MB'
		else:
			return ('%.2f' % file_size) + ' KB'
	else:
		return file_size + ' B'


if __name__ == '__main__':
	app.run(host='0.0.0.0', port='20000')
	
