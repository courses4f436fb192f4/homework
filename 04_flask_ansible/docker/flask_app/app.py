from flask import Flask, request
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

if __name__ == '__main__':
    app.run()
