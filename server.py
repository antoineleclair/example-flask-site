import uuid
from datetime import datetime
import os

from flask import Flask

app = Flask(__name__)

proc_id = uuid.uuid4().hex

@app.route("/")
def hello_world():
    print("new web request")
    return f"""<p>hello from disco7!!!!!!! !!!!!
    !!!             
        !!
        !!
        !!
        !!
        !!
        asdasdasdas
        dasdasd
        !!!
        ASDASDASD
        ASDasd
        ASDASDAS
        !!!!
        ASDASDAS
        !!!!
               <br>the datetime is {datetime.now()}
               <br>the commit is {os.getenv("DISCO_COMMIT")}
               <br>the deployment number is {os.getenv("DISCO_DEPLOYMENT_NUMBER")}
               <br>process {proc_id}</p>"""


@app.route("/health")
def health():
    print("HEALTH!!")
    return "OK"


if __name__ == "__main__":
    import time
    time.sleep(30)
    app.run(host="0.0.0.0", port=8080, debug=True)
