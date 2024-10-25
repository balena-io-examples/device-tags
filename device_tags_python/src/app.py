from flask import Flask, render_template
app = Flask(__name__, template_folder='../views', static_folder='../views/public')

import os
import datetime
from balena import Balena
balena_sdk = Balena({
    "balena_host": os.environ['BALENA_API_URL'].replace('https://api.', '')
})
balena_sdk.auth.login_with_token(os.environ['BALENA_API_KEY'])

@app.route('/')
def hello_world():
    balena_sdk.models.device.tags.set(os.environ['BALENA_DEVICE_UUID'], 'device_tags_python.last_request', datetime.datetime.now().isoformat())
    return render_template('index.html')

if __name__ == '__main__':
    balena_sdk.models.device.tags.set(os.environ['BALENA_DEVICE_UUID'], 'device_tags_python.last_server_start', datetime.datetime.now().isoformat())
    app.run(host='0.0.0.0', port=80)
