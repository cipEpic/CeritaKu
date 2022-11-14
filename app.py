from flask import Flask, render_template, request, redirect, session, url_for
from flask_mysqldb import MySQL
app = Flask(__name__)

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "ceritaku"
app.secret_key='asdsdfsdfs13sdf_df%&'

mysql = MySQL(app)
@app.route("/")
def index():
    global curfet
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM akun")
    curfet = cur.fetchall()
    user = [i[0] for i in curfet]
    login = False
    if "email" in session:
        login = True
    return render_template("index.html", login=login, user=user)


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form.get("email1")
        password = request.form.get("password1")
        user = [i[0] for i in curfet]
        pw = [i[1] for i in curfet]
        print(user)
        print(pw)
        print(email)
        print(password)
        if email in user and password in pw:
            session["email"] = email
            session["password"] = password
            return redirect(url_for("index"))
        else:
            return render_template("loginregister.html")

    else:
        return render_template("loginregister.html")

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        email = request.form.get("email")
        username = request.form.get("name")
        password = request.form.get("password")
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO akun(email, nama, password) values (%s, %s, %s)", (email, username, password))
        cur2 = cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return redirect(url_for("login"))
    else:
        return render_template("loginregister.html")

@app.route("/logout")
def logout():
    session.pop('username',None)
    return redirect(url_for('index'))

@app.route("/create_story")
def create_story():
    return render_template("create_story.html")

@app.route("/categories")
def categories():
    return render_template("categories.html")

@app.route("/blog")
def blog():
    return render_template("blog.html")

if __name__ == "__main__":
    app.run(debug=True)
