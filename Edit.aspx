<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Edit.aspx.cs" Inherits="edit" %>

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
<body class="GameTable">
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
                <li><a class="about">אודות</a></li>
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
                <a href="https://creativecommons.org/licenses/by/3.0/">Freesound,</a>
                <a href="https://www.freepik.com/">Freepik,</a>
                <a href="https://fontawesome.com/v5.15/icons?d=listing&p=2&q=re">Font Awesome </a>
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
    <form id="form1" runat="server">
        <div dir="rtl">
            <div class="container-fluid">
                <div class="card bg-yellow">
                    <div class="container">
                        <div id="headingOne">
                            <div class="mb-0 row">
                                <div class="col-1"></div>

                                <div class="col-sm-5">
                                    <b>שם המשחק: </b>
                                    <asp:Label CssClass="fw-bold" ID="GameNameLbl" runat="server"></asp:Label>
                                </div>
                                <div class="col-sm-5">
                                    <span><b>הוראות משחק: </b>אספו את כל ה </span>
                                    <asp:Label CssClass="text-decoration-underline" ID="GameInstructionLbl" runat="server"></asp:Label>

                                </div>
                                <div class="col-sm-1">
                                    <button type="button" class="icon-btn">
                                        <a href="Default.aspx">
                                            <img src="icons/house-fill.svg" />
                                        </a>
                                    </button>
                                </div>
                            </div>
                            <div class="collapse" id="collapseExample">
                                <div class="header-editable">
                                    <div class="mb-0 row">
                                        <div class="col-1"></div>
                                        <div class="col-sm-5">
                                            <b>שם המשחק:</b>
                                            <div class="input-wrapper">

                                                <asp:TextBox ID="GameNameEdit" CssClass="form-control" CharacterForLabel="nameCount" CharacterLimit="30" FormButtons="Button1, collapse-btn" runat="server"></asp:TextBox>
                                                <div class="counter-container">
                                                    <span id="nameCount">0/30</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-5">
                                            <b>הוראות משחק: </b>אספו את כל ה
                                            <div class="input-wrapper">

                                                <asp:TextBox ID="GameInstructionsEdit" CssClass="form-control" CharacterForLabel="instructionsCount" CharacterLimit="30" FormButtons="Button1, collapse-btn" runat="server"></asp:TextBox>
                                                <div class="counter-container">
                                                    <span id="instructionsCount">0/30</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-1">
                                            <asp:Button ID="Button1" runat="server" Text="שמירה" OnClick="Button1_Click" CssClass="btn btn-primary" />
                                            <%--   <button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    שמירה
                                </button>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button id="collapse-btn" onclick="resetHeaderControls()" class="btn collapse-btn icon-btn" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                            <img src="icons/chevron-down.svg" />
                        </button>
                    </div>
                </div>

                <div>
                     <h3 class="game-condition">עד 35 פריטים סך הכל במשחק</h3>
                    <div class="tables-wrapper">
                       

                        <!--====================== TABLE ONE ================-->
                        <div class="table-container">
                            <%-- פקד להוספת פריט מסוג תמונה --%>
                            <div class="table-header">
                                <b>טבלת פריטים נכונים</b>
                                 <asp:Label runat="server" ID="NumWrongTrue"></asp:Label>
                                <div class="add-items-container">
                                    <label>הוספה: </label>
                                    <button type="button" class="btn img-btn-header" data-bs-toggle="modal" data-bs-target="#add-modal" id="addTextTrueClient" onclick="toggle.modal('textUpload')"><i class="fas fa-font"></i></button>
                                    <asp:FileUpload ID="TrueFileUpload1" ImageUrl="~/icons/image.svg" runat="server" onchange="ShowPreview(this);" data-bs-toggle="modal" data-bs-target="#add-modal" class="img-btn-header" Style="display: none" />
                                    <button type="button" onclick="fileUploadTrueClick()" id="trueUploadBtn" class="btn img-btn-header"><i class="far fa-image"></i></button>
                                </div>
                            </div>

                            <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/tree/games.xml" XPath="games/game/items/item"></asp:XmlDataSource>
                            <asp:GridView ID="GridViewTrue" runat="server" AutoGenerateColumns="False" DataSourceID="XmlDataSource1" OnRowCommand="GridViewTrue_RowCommand" BackColor="#F2EFDF" CssClass="edit-game-table" GridLines="Horizontal" HeaderStyle-Wrap="True" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" ShowHeaderWhenEmpty="True">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="250px" HeaderStyle-CssClass="span-all" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Label ID="ItemLbl" runat="server" Text='<%#Server.UrlDecode(XPathBinder.Eval(Container.DataItem, "@id/..").ToString())%>' ItemLabel='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>'></asp:Label>
                                            <asp:Image ID="ItemNameImage" CssClass="table-image" runat="server" Height="50px" ImageUrl='<%#"uploadedFiles/" + XPathBinder.Eval(Container.DataItem, "@id/..").ToString()%>' Visible="false" ItemLabel='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="50px" ShowHeader="False" HeaderStyle-CssClass="d-none">
                                        <ItemTemplate>
                                            <asp:Button Data-Edit='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' runat="server" CommandName="editItemTrue" CommandArgument='<%#XPathBinder.Eval(Container.DataItem,"@id").ToString()%>' OnClick="EditText" CssClass="d-none" />
                                            <button type="button" class="img-btn" data-bs-toggle="modal" data-bs-target="#add-modal" id='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' onclick="editItem(event)"><i class="fas fa-edit"></i></button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="50px" ShowHeader="False" HeaderStyle-CssClass="d-none">
                                        <ItemTemplate>
                                            <button type="button" class="img-btn" data-bs-toggle="modal" data-bs-target="#add-modal" id='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' onclick="deleteItem(event)"><i class="fas fa-trash"></i></button>

                                            <asp:ImageButton Data-Delete='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' ID="deletItem" runat="server" CssClass="d-none" ImageUrl="./icons/trash-fill.svg" CommandName="deletItembtn" ItemID='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' CommandArgument='<%#XPathBinder.Eval(Container.DataItem,"@id").ToString()%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                </Columns>
                                <%--עיצוב--%>
                                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                <HeaderStyle BackColor="#4C5459" Font-Bold="True" ForeColor="#E7E7FF" />
                                <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#594B9C" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#33276A" />

                            </asp:GridView>
                        </div>
                        <asp:XmlDataSource ID="XmlDataSource2" runat="server" DataFile="~/tree/games.xml" XPath="games/game/items/item"></asp:XmlDataSource>

                        <!--====================== TABLE TWO ================-->
                        <div class="table-container">
                            <%-- פקד להוספת פריט מסוג תמונה --%>
                            <div class="table-header">
                                <b>טבלת פריטים לא נכונים </b>
                                <asp:Label runat="server" ID="NumWrongFalse"></asp:Label>
                                <div class="add-items-container">
                                    <label>הוספה: </label>
                                    <button type="button" class="btn img-btn-header" data-bs-toggle="modal" data-bs-target="#add-modal" id="addTextFalseClient" onclick="toggle.modal('textUploadFalse')"><i class="fas fa-font"></i></button>
                                    <asp:FileUpload ID="FalseFileUpload" ImageUrl="~/icons/image.svg" runat="server" onchange="ShowPreview(this);" data-bs-toggle="modal" data-bs-target="#add-modal" class="img-btn-header" Style="display: none" />
                                    <button type="button" onclick="fileUploadFalseClick()" id="falseUploadBtn" class="btn img-btn-header"><i class="far fa-image"></i></button>
                                </div>
                            </div>

                            <asp:XmlDataSource ID="XmlDataSource3" runat="server" DataFile="~/tree/games.xml" XPath="games/game/items/item"></asp:XmlDataSource>
                            <asp:GridView ID="GridViewFalse" runat="server" AutoGenerateColumns="False" DataSourceID="XmlDataSource2" OnRowCommand="GridViewFalse_RowCommand" BackColor="#F2EFDF" CssClass="edit-game-table" GridLines="Horizontal" HeaderStyle-Wrap="True" HeaderStyle-HorizontalAlign="Center" HeaderStyle-VerticalAlign="Middle" ShowHeaderWhenEmpty="True">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="250px" HeaderStyle-CssClass="span-all" ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Label ID="ItemLbl" runat="server" Text='<%#Server.UrlDecode(XPathBinder.Eval(Container.DataItem, "@id/..").ToString())%>' ItemLabel='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>'></asp:Label>
                                            <asp:Image ID="ItemNameImage" CssClass="table-image" runat="server" Height="50px" ImageUrl='<%#"uploadedFiles/" + XPathBinder.Eval(Container.DataItem, "@id/..").ToString()%>' Visible="false" ItemLabel='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="50px" ShowHeader="False" HeaderStyle-CssClass="d-none">
                                        <ItemTemplate>
                                            <asp:Button Data-Edit='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' runat="server" CommandName="editItemTrue" CommandArgument='<%#XPathBinder.Eval(Container.DataItem,"@id").ToString()%>' OnClick="EditText" CssClass="d-none" />
                                            <button type="button" class="img-btn" data-bs-toggle="modal" data-bs-target="#add-modal" id='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' onclick="editItem(event)"><i class="fas fa-edit"></i></button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-Width="50px" ShowHeader="False" HeaderStyle-CssClass="d-none">
                                        <ItemTemplate>
                                            <button type="button" class="img-btn" data-bs-toggle="modal" data-bs-target="#add-modal" id='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' onclick="deleteItem(event)"><i class="fas fa-trash"></i></button>

                                            <asp:ImageButton Data-Delete='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' ID="deletItem" runat="server" CssClass="d-none" ImageUrl="./icons/trash-fill.svg" CommandName="deletItembtn" ItemID='<%#XPathBinder.Eval(Container.DataItem, "@id").ToString()%>' CommandArgument='<%#XPathBinder.Eval(Container.DataItem,"@id").ToString()%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                </Columns>
                                <%--עיצוב--%>
                                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                <HeaderStyle BackColor="#4C5459" Font-Bold="True" ForeColor="#E7E7FF" />
                                <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                                <%--                        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />--%>
                                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#594B9C" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#33276A" />

                            </asp:GridView>
                        </div>
                        <asp:XmlDataSource ID="XmlDataSource4" runat="server" DataFile="~/tree/games.xml" XPath="games/game/items/item"></asp:XmlDataSource>

                        <!--====================== END ===================-->



                    </div>

                </div>
            </div>

        </div>


        <!-- Good Working Modal -->
        <div class="modal fade" id="add-modal" tabindex="-1" aria-labelledby="add-photo-modaLebel" aria-hidden="true">
            <div class="modal-dialog">
                <img src="" id="zoomImage" hidden="hidden" />
                <div class="modal-content" id="modal-content" hidden="hidden">
                    <div class="modal-header">
                        <h5 class="modal-title" id="imageModalLabel">%TITLE%</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div id="modalCard" class="modal-card" hidden="hidden">
                            <asp:TextBox TextMode="MultiLine" ID="textItem" runat="server" placeholder="הקלד כאן" CssClass="textItem" CharacterLimit="30" CharacterForLabel="letterIndex" FormButtons="randomBtn, editTextBtn, randomBtn_FALSE" hidden="hidden"></asp:TextBox>
                            <asp:HiddenField ID="FileUploadHiddenField" runat="server" />
                            <asp:Image ID="output" CssClass="output" runat="server" Width="60%" hidden="hidden" />
                            <div id="letterIndex" class="counter-container-inner" hidden="hidden">0/30</div>
                        </div>
                        <div class="modal-footer">
                            <button id="close-image-modal" class="btn btn-secondary" data-bs-dismiss="modal" hidden="hidden">
                                בטל
                            </button>



                            <asp:Button runat="server" ID="randomBtn" OnClick="addTextTrue" Text="שמור טקסט" hidden="hidden" disabled="true" />
                            <asp:Button ID="SaveImageBtns" runat="server" Text="שמור תמונה" OnClick="addImgTrue" hidden="hidden" />
                            <asp:Button runat="server" ID="randomBtn_FALSE" OnClick="addTextFalse" Text="שמור טקסט" hidden="hidden" disabled="true" />
                            <asp:Button ID="SaveImageBtns_FALSE" runat="server" Text="שמור תמונות" OnClick="addImgFalse" hidden="hidden" />
                            <asp:FileUpload ID="editUplaod" runat="server" onchange="ShowPreview(this);" Style="display: none" />
                            <label for="editUplaod" id="editUplaodBtn" class="btn btn-secondary fas fa-sync-alt" hidden="hidden"></label>
                            <button type="button" id="editTextBtn" hidden="hidden">שמור</button>
                            <button type="button" id="sureDelete" hidden="hidden">כן, מחק</button>
                            <button type="button" id="okButton" class="btn btn-secondary" hidden="hidden" data-bs-dismiss="modal">הבנתי, סגור</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="collapse-backdrop" id="collapse-backdrop"></div>



    </form>

    <!-- THIS IS THE DEPRECATED SECTION WHICH ALL THE THINGS WE DONT NEED ARE SAVED!!! -->

    <!-- Modal -->
    <!--    
        <div class="modal fade" id="add-text-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" style="margin: auto">
                        <div style='background: url("images/card_new.png") no-repeat right top; background-size: 309.09px 400px; height: 400px; width: 309.09px; padding-top: 60%; margin: auto;'>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        
        
        
        
        <div class="modal fade" id="idiotText" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">1
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">הוסף פריט מסוג טקסט</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button id="close-modal" class="btn btn-secondary" data-bs-dismiss="modal">פח</button>
                                                                <button id="add-text-modal-btn" type="button" class="btn btn-primary">שמירה</button>
                                                                <%--<asp:Button ID="Button3" runat="server" Text="שמירה" CssClass="btn btn-primary" OnClick="SaveItemToXML" />--%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="collapse-backdrop" id="collapse-backdrop"></div>-->


    <!-- THIS IS THE END OF THE DEPRECATED SECTION WHICH ALL THE THINGS WE DONT NEED ARE SAVED!!! -->


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
    <script src="jScripts/jquery-3.6.0.min.js"></script>
    <!-- LET OUR FONTS BE AWESOME!!!!-->
    <script src="https://kit.fontawesome.com/96a2be8b3c.js" crossorigin="anonymous"></script>
    <script src="jScripts/edit.js" type="text/javascript"></script>

</body>
</html>


