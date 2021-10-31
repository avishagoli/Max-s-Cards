<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl" lang="he">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>MAX'S CARDS - מחולל משחקים</title>
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
<body dir="rtl">
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

    <div id="container" class="container">
        <div class="row">
            <div class="col-sm-3">
                <!-- Button trigger modal -->
                <button type="button" class="btn icon-btn" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="resetInputs()">
                    <img src="icons/plus-circle.svg" />
                    צור משחק
                </button>
            </div>
        </div>

        <form id="form1" runat="server">
            <div dir="rtl" class="games-table-container">
                <%--             <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/add.png" OnClick="ImageButton1_Click" />--%>
                <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/tree/games.xml" XPath="games/game"></asp:XmlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="XmlDataSource1" Width="100%" OnRowCommand="GridView1_RowCommand" BackColor="#F2EFDF" CssClass="games-table">
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="250px">
                            <HeaderTemplate>
                                <div class="table-header">שם המשחק</div>

                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="GameNameLbl" runat="server" Text='<%#Server.UrlDecode(XPathBinder.Eval(Container.DataItem, "GameName").ToString())%>'> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="100px">
                            <HeaderTemplate>
                                <div class="table-header">קוד המשחק</div>

                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="GameCodeLbl" runat="server" Text='<%#XPathBinder.Eval(Container.DataItem, "@GameCode").ToString()%>'> </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="50px">
                            <HeaderTemplate>
                                <div class="table-header">עריכה</div>

                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:ImageButton ID="EditGameBTN" runat="server" CssClass="img-btn" ImageUrl="~/icons/pen-fill.svg" CommandName="editGame" CommandArgument='<%#XPathBinder.Eval(Container.DataItem,"@GameCode")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="50px">
                            <HeaderTemplate>
                                <div class="table-header">מחיקה</div>

                            </HeaderTemplate>
                            <ItemTemplate>

                                <button onclick="openModal(event)" type="button" class="img-btn" id="<%#XPathBinder.Eval(Container.DataItem,"@GameCode")%>" data-bs-toggle="modal" data-bs-target="#deletGameModal">
                                    <img src="./icons/trash-fill.svg" />
                                </button>
                                <asp:Button CommandName="deleteGame" runat="server" CommandArgument='<%#XPathBinder.Eval(Container.DataItem,"@GameCode")%>' ID="delete" theGame='<%#XPathBinder.Eval(Container.DataItem,"@GameCode")%>' CssClass="d-none" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="51px">
                            <HeaderTemplate>
                                <div class="table-header">פרסום</div>

                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="GameIsPublishCB" AutoPostBack="true" runat="server" Checked='<%#Convert.ToBoolean(XPathBinder.Eval(Container.DataItem, "@isPublish"))%>' theCodeNum='<%#XPathBinder.Eval(Container.DataItem,"@GameCode")%>' OnCheckedChanged="GameIsPublishCB_CheckedChanged" CssClass="publish-checkbox"/>
                                <asp:Image ID="Image1" runat="server" src="icons/question-circle.svg" data-bs-toggle="tooltip" title="Some" onHover="toolTip" CssClass="publish-question-icon" />

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle BackColor="#4C5459" CssClass="table-header"/>
                </asp:GridView>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">הקלד שם למשחק והוראות משחק</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>


                        </div>
                        <div class="modal-body">
                            <!--CONTENT-->
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="mb-3">
                                        <label for="GameName" class="form-label"><b>שם המשחק:</b></label>
                                        <div class="input-wrapper">
                                            <asp:TextBox ID="GameName" CssClass="form-control" CharacterForLabel="nameCount" CharacterLimit="30" runat="server" placeholder="הקלד כאן"></asp:TextBox>
                                            <div class="counter-container"><span id="nameCount">0/30</span></div>
                                        </div>
                                        <small class="text-muted input-instruction">30 - 2</small>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="mb-3">
                                        <label for="GameInstructions" class="form-label"><b>הוראות משחק:</b> אספו את כל ה</label>
                                        <div class="input-wrapper">
                                            <asp:TextBox ID="GameInstructions" CssClass="form-control" CharacterForLabel="instructionsCount" CharacterLimit="30" runat="server" placeholder="הקלד כאן"></asp:TextBox>
                                            <div class="counter-container">
                                                <span id="instructionsCount">0/30</span>
                                            </div>

                                        </div>
                                        <small class="text-muted input-instruction">30 - 2</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="submitNewGame" runat="server" Text="שמירה" CssClass="btn btn-primary" OnClick="CreateGameClick" disabled="true" />
                        </div>
                    </div>
                </div>

            </div>

            <!-- Modal -->
            <div class="modal fade" id="deletGameModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="titleDeletModalLabel">מחיקת משחק</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            האם אתה בטוח שברצונך למחוק את המשחק?
                        </div>
                        <div class="modal-footer">
                            <button id="Button1" type="button" class="btn btn-secondary" data-bs-dismiss="modal">סגור</button>
                            <button id="okDelete" type="button" class="btn btn-primary">כן, מחק פריט</button>
                            <%--              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Save changes</button>--%>
                        </div>
                    </div>
                </div>
            </div>

        </form>

    </div>
    <div class="tooltip bs-tooltip-top" role="tooltip">
        <div class="tooltip-arrow"></div>
        <div class="tooltip-inner">
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="jScripts/jquery-3.6.0.min.js"></script>
    <script src="jScripts/default.js" type="text/javascript"></script>
    <script src="jScripts/myScript.js" type="text/javascript"></script>

</body>
</html>
