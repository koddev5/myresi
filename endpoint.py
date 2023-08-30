from flask import Flask, Response
import requests


app = Flask(__name__)

# Liste d'URLs d'images en ligne
image_urls = [
    'https://drive.google.com/file/d/15h6z6C05kw4QN_1ygacEx4HVs_GioC3l/view?usp=drive_link',
    'https://drive.google.com/file/d/1AMTWPSTvsmyD4lG19cRDqpv6CuslqtWl/view?usp=drive_link',
    'https://drive.google.com/file/d/1c9_EOTgv6tG_jI2kb1itp8-gZ1KTfAd5/view?usp=drive_link'
]

@app.route('/images', methods=['GET'])
def get_images():
    def generate():
        for image_url in image_urls:
            response = requests.get(image_url, stream=True)
            if response.status_code == 200:
                for chunk in response.iter_content(1024):
                    yield chunk

    return Response(generate(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
    app.run(debug=True)
