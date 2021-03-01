from flask import Flask, request
import emoji

app = Flask(__name__)

@app.route('/', methods=['GET','POST'])
def json_example():

    if request.method == 'POST':
        request_data = request.get_json(force=True)

        word = request_data['word']
        count = request_data['count']
        thumb = emoji.emojize(":" + word + ":")
        res = ""
    
        for x in range(int(count)):
            res += thumb + word

        return '''{}\n'''.format(res)

    if request.method == 'GET':
         word = request.args.get('word')
         count = request.args.get('count')
         thumb = emoji.emojize(":" + word + ":")
         res = ""

         for x in range(int(count)):
            res += thumb + word
         
         return '''{}\n'''.format(res)

@app.route('/form', methods=['GET', 'POST'])
def form_example():
    if request.method == 'POST':

        word = request.form.get('list_box')
        count = request.form.get('count')
        thumb = emoji.emojize(":" + word + ":")
        res = ""
    
        for x in range(int(count)):
            res += thumb + word

        return '''<h1>Result is:<p> {}</h1>
                  <p><a href="/form">Go back</a>'''.format(res)

# else method GET
    return '''
           <form method="POST">
               <div><label>count: <input type="text" name="count"></label></div>
               <input type="submit" value="Submit">
               
               <select Name="list_box" Size="10">  
                 <option> musical_note </option>  
                 <option> mountain_cableway </option>  
                 <option> octopus </option>  
                 <option> office_building </option>  
                 <option> Belarus </option>  
                 <option> snowman </option>  
                 <option> volcano </option>  
                 <option> alien </option>  
               </select>  
           </form>'''