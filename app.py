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
    session.pop("email",None)
    session.pop("password")
    return redirect(url_for('index'))


@app.route("/baca_novel")
def baca_novel():
    login = False
    if "email" in session:
        login = True
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM chapter_idnovel;")
    novel = cur.fetchall()
    judul = [i[2] for i in novel]
    isi = [i[3] for i in novel]
    return render_template("/baca_novel.html", login=login, judul=judul, isi=isi)

@app.route("/create_story")
def create_story():
    login = False
    if "email" in session:
        login = True

    if request.method == "POST":
        gambar = request.form.get("gambar")
        judul = request.form.get("judul")
        sinopsis = request.form.get("sinopsis")
        chapter = request.form.get("kategori")
        review = request.form.get("review")

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO novel(judul, sinopsis, chapter, review) values (%s, %s, %s, %s)" % (judul, sinopsis, chapter, review))
        cur2 = cur.fetchall()
        mysql.connection.commit()
        cur.close()

        return redirect(url_for("index"))
    
    else:
        return render_template("create_story.html", login=login)


@app.route("/categories")
def categories():
    login = False
    if "email" in session:
        login = True
    return render_template("categories.html", login=login)

@app.route("/blog")
def blog():
    login = False
    if "email" in session:
        login = True
    return render_template("blog.html", login=login)

@app.route("/contact")
def contact():
    login = False
    if "email" in session:
        login = True
    return render_template("contact.html", login=login)

@app.route("/about")
def about():
    login = False
    if "email" in session:
        login = True
    return render_template("about.html", login=login)


@app.route("/textbook")
def textbook():
    return render_template("/categoriesbook/textbook.html")

@app.route("/science")
def science():
    return render_template("/categoriesbook/science.html")

@app.route("/history")
def history():
    return render_template("/categoriesbook/history.html")

@app.route("/biography")
def biography():
    return render_template("/categoriesbook/biography.html")

@app.route("/adventure")
def adventure():
    return render_template("/categoriesbook/adventure.html")

if __name__ == "__main__":
    app.run(debug=True)
