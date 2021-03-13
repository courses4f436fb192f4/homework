from flask import Flask, request
import emoji

app = Flask(__name__)

thumb_def="¯_(ツ)_/¯"

def ret_emoji(_word, _count):
    res=""
    s = ":" + _word + ":"
    thumb = emoji.emojize(":" + _word + ":")
    
    if thumb != s:
        for x in range(int(_count)):
            res += thumb + _word
        res += thumb
    else:
        for x in range(int(_count)):
            res += thumb_def + " " + _word + " "
        res += thumb_def
            
    return res

@app.route('/', methods=['GET','POST'])
def json_example():
    
    if request.method == 'POST':
        request_data = request.get_json(force=True)

        word = request_data['word']
        count = request_data['count']
        res = ret_emoji(word, count)
        
        return '''{}\n'''.format(res)

    if request.method == 'GET':
        word = request.args.get('word')
        count = request.args.get('count')
        res = ret_emoji(word, count)
         
        return '''{}\n'''.format(res)

@app.route('/form', methods=['GET', 'POST'])
def form_example():
    if request.method == 'POST':

        word = request.form.get('list_box')
        count = request.form.get('count')
        res = ret_emoji(word, count)

        return '''<h1>Result is:<p> {}</h1>
                  <p><a href="/form">Go back</a>'''.format(res)

# else method GET
    return '''
           <form method="POST">
               <div><label>count: <input type="text" value="3" name="count"></label></div>
               <input type="submit" value="Submit">
               
               <select Name="list_box" Size="10">  
                 <option> musical_note </option>  
                 <option> mountain_cableway </option>  
                 <option> octopus </option>  
                 <option> office_building </option>  
                 <option selected="selected"> Belarus </option>  
                 <option> snowman </option>  
                 <option> volcano </option>  
                 <option> no_emoji </option>  
               </select>  
           </form>'''
           
