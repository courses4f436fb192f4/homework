from flask import Flask, request
from unidecode import unidecode
import emoji

app = Flask(__name__)

@app.route('/', methods=['POST'])
def json_example():

    request_data = request.get_json(force=True)

    word = request_data['word']
    count = request_data['count']
    thumb = emoji.emojize(":" + word + ":")
    res = ""
    for x in range(int(count)):
        res += thumb + word

    return '''{}\n
      '''.format(res)

#curl -i -H "Content-Type: application/json" -X POST -d '{"word":"PYTHON", "count": 3}' http://127.0.0.1:5000/

#curl -XPOST -d'{"word":"thumbs_up", "count": 3}' http://127.0.0.1:5000/
#curl -XPOST -d'{"word":"books", "count": 3}' http://127.0.0.1:5000/
# https://github.com/carpedm20/emoji/blob/master/emoji/unicode_codes/en.py
#if __name__ == '__main__':
    # run app in debug mode on port 5000
#    app.run(debug=True, port=5000)