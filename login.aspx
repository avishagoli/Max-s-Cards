<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl" lang="he">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>MAX'S CARDS - התחברות</title>
    <meta name="description" content="MAX'S CARDS" />
    <meta name="keywords" content="max's cards, הקלפים של מקס, מחולל משחקים, משחק לימודי, אבישג אוליאל, דנה מלח, זיו פדידה" />
    <meta name="author" content="Avishag Oliel, Dana Malach, Ziv Fadida" />
    <link rel="shortcut icon" type="image/png" href="images/maxLogo.png" />
    <!-- CSS -->
    <!--Bootstrap-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.rtl.min.css" integrity="sha384-beJoAY4VI2Q+5IPXjI207/ntOuaz06QYCdpWfWRv4lSFDyUSqsM0W+wiAMr2I185" crossorigin="anonymous">
    <link href="styles/main.css" rel="stylesheet" />
    <link href="styles/controls.css" rel="stylesheet" />
</head>

<body dir="rtl" class="login_body">
    <header>
        <!--קישור לדף עצמו כדי להתחיל את המשחק מחדש בלחיצה על הלוגו-->
        <a href="./index.html">
            <img id="logo" src="images/maxLogo.png" />
            <!--הלוגו של המשחק שלכם-->
        </a>
        <!--תפריט הניווט בראש העמוד-->
        <nav>
            <ul>
                <li><a class="howToPlay" href="./index.html">למשחק</a></li>
                <li><a class="howToPlay" href="./Default.aspx">למחולל</a></li>
                <li><a class="howToPlay">איך משחקים?</a></li>
                <li><a class="about" >אודות</a></li>
            </ul>
        </nav>
        <div id="aboutDiv" class="popUp bounceInDown hide">
            <span class="close-about-holder">
                <a class="closeAbout close-btn">X</a>
            </span>

            <div id="about">
                <div class="key">
                    <img class="imgKey" src="images/about.png" />
                </div>
            </div>
            <div id="hitDiv">
                <img id="logoHit" src="images/HIT-logo.png" alt="hit logo" />
                <br />
                <a href="https://www.hit.ac.il/telem/overview">הפקולטה לטכנולוגיות למידה</a>

            </div>
            <p id="credits">
                קרדיט:
                <br />
                <a href="https://creativecommons.org/licenses/by/3.0/"> Freesound,</a>
                <a href="https://www.freepik.com/"> Freepik,</a>
                <a href="https://fontawesome.com/v5.15/icons?d=listing&p=2&q=re"> Font Awesome </a>
            </p>
        </div>
        <div id="howToPlayDiv" class="popUp bounceInDown hide">

            <span class="close-about-holder">
                <a class="closeHowToPlay close-btn">X</a>
            </span>
            <div class="key">
                <img class="imgKey" src="images/InstructionsPopUp.png" />

            </div>
            </div>
    </header>
    <!-- Login Section -->
    <form id="form" runat="server" dir="rtl">
    <div class="loginBackground">
        <asp:Panel ID="Panel1" runat="server" CssClass="login">
    </div>
    <div class="panel-title">
        <asp:Label ID="Label12" runat="server" Text="צד עורך"></asp:Label>
    </div>

    <div class="static container">

        <div class="col-sm-12">
            <label>שם משתמש:</label><br>
            <asp:TextBox ID="userName" runat="server" placeholder="הכנס שם משתמש"></asp:TextBox>
        </div>

        <div class="col-sm-12">
            <label>סיסמא:</label><br>
            <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="סיסמה"></asp:TextBox>
        </div>

        <div>
            <asp:Label ID="Label1" runat="server" Text="Label" Visible="false" CssClass="panel-warning"></asp:Label>
        </div>

        <div class="col-sm-12">
            <asp:Button ID="Goinse" runat="server" CssClass="btn_submit" Text="כניסה" OnClick="Entrance" />
        </div>

        <div class="panel-bottom">
            <asp:Label ID="userandpassord" runat="server" Text=" שם משתמש: admin סיסמה: telem"></asp:Label>
        </div>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
