from datetime import datetime
import os

from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello_world():
    print("new web request")
    return f"""<p>hello from disco7!!!
               <br>the datetime is {datetime.now()}
               <br>the commit is {os.getenv("DISCO_COMMIT")}</p>"""


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
