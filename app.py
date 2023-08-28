import os
from flask import Flask, request, send_from_directory, jsonify
from flask_cors import CORS, cross_origin

app = Flask(__name__)

#répertoire contenant les images

IMAGES_FOLDER = 'Bureau/api resi/img'
app.config['IMAGES_FOLDER'] = IMAGES_FOLDER

# récupération d'un certain nombre d'images
@app.route('/images/<int:num_images>', methods=['GET'])
def get_images(num_images):
    images_path = app.config['IMAGES_FOLDER']
    image_filenames = os.listdir(images_path)[:num_images]

    image_urls = [request.host_url + 'images/' + filename for filename in image_filenames]

    return jsonify(image_urls)

#distribution des images
@app.route('/images/<path:filename>', methods=['GET'])
def serve_image(filename):
    return send_from_directory(app.config['IMAGES_FOLDER'], filename)

if __name__ == '__main__':
    app.run(debug=True)
