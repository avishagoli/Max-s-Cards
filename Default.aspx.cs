using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Init(object sender, EventArgs e)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        XmlDocument myDoc = XmlDataSource1.GetXmlDocument();
        foreach (GridViewRow gvr in GridView1.Rows)
        {
            bool canPublish = true;
            CheckBox Publish = ((CheckBox)gvr.FindControl("GameIsPublishCB"));
            string GameId = Publish.Attributes["theCodeNum"].ToString();

            XmlNode gameNode = myDoc.SelectSingleNode("/games/game[@GameCode='" + GameId + "']");
            XmlNodeList TrueItems = gameNode.SelectNodes("items/item[@feedback='true']");
            XmlNodeList FalseItems = gameNode.SelectNodes("items/item[@feedback='false']");

            string tooltipText = "";
            if (FalseItems.Count < 5)
            {
                canPublish = false;
                tooltipText = "משחק חייב להכיל לפחות 5 מסיחים בכל קטגוריה";
            }
            if (TrueItems.Count < 5)
            {
                canPublish = false;
                tooltipText = "משחק חייב להכיל לפחות 5 מסיחים בכל קטגוריה";
            }
            if (TrueItems.Count + FalseItems.Count > 35)
            {
                canPublish = false;
                tooltipText += "משחק לא יכול להכיל יותר מ-35 מסיחים";
            }

            if (canPublish == false)
            {
                gameNode.Attributes["isPublish"].InnerText = "false";
                XmlDataSource1.Save();
                Publish.Checked = false;
                Publish.Enabled = false;
            }
            else
            {
                Publish.Enabled = true;
                tooltipText = "המשחק ניתן לפרסום";
            }

            Image tooltipImg = (Image)gvr.FindControl("Image1");
            tooltipImg.Attributes["title"] = tooltipText;


        }
    }
    protected void CreateGameClick(object sender, EventArgs e)
    {
        XmlDocument myDoc = XmlDataSource1.GetXmlDocument();
        // הקפצה של מונה קוד משחק בתוך קובץ האקס אם אל באחד
        int MaxId = Convert.ToInt16(myDoc.SelectSingleNode("//game[not(@GameCode < //game/@GameCode)]/@GameCode").Value);
        MaxId++;

        // יצירת ענף משחק     
        XmlElement myNewGameNode = myDoc.CreateElement("game");
        myNewGameNode.SetAttribute("isPublish", "false");
        myNewGameNode.SetAttribute("GameCode", MaxId.ToString());


        // יצירת ענף שם משחק
        XmlElement newGameSubject = myDoc.CreateElement("GameName");
        XmlText newGameSubjectText = myDoc.CreateTextNode(GameName.Text);

        //יצירת גזע השאלה
        XmlElement newGameInstructions = myDoc.CreateElement("GameInstructions");
        XmlText newGameInstructionsText = myDoc.CreateTextNode(GameInstructions.Text);

        //יצירת תגית מסיחים
        XmlElement newItems = myDoc.CreateElement("items");

        //הכנסה להיררכיה
        newGameInstructions.AppendChild(newGameInstructionsText);
        newGameSubject.AppendChild(newGameSubjectText);
        myNewGameNode.AppendChild(newGameSubject);
        myNewGameNode.AppendChild(newGameInstructions);

        myNewGameNode.AppendChild(newItems);

        // הוספת ענף המשחק לעץ כמשחק הראשון
        XmlNode FirstGame = myDoc.SelectNodes("/games/game").Item(0);
        myDoc.SelectSingleNode("/games").InsertBefore(myNewGameNode, FirstGame);

        XmlDataSource1.Save();
        GridView1.DataBind();

        // ניקוי תיבת הטקסט
        GameName.Text = "";
        GameInstructions.Text = "";


        Session["GameCodeSession"] = MaxId.ToString();
        Response.Redirect("Edit.aspx");

    }


    protected void GameIsPublishCB_CheckedChanged(object sender, EventArgs e)
    {
        // טעינה של העץ
        XmlDocument xmlDoc = XmlDataSource1.GetXmlDocument();

        // תחילה אנו מבררים מהו קוד המשחק בעץ ה אקס אם אל
        CheckBox myCheckBox = (CheckBox)sender;
        // מושכים את הקוד של המשחק באמצעות המאפיין שהוספנו באופן ידני לתיבה
        string theCode = myCheckBox.Attributes["theCodeNum"];

        //שאילתא למציאת המשחק שברצוננו לעדכן
        XmlNode theGames = xmlDoc.SelectSingleNode("/games/game[@GameCode=" + theCode + "]");

        //קבלת הערך החדש של התיבה לאחר הלחיצה
        bool NewIsPublish = myCheckBox.Checked;

        //עדכון של המאפיין בעץ
        theGames.Attributes["isPublish"].InnerText = NewIsPublish.ToString().ToLower();

        //שמירה בעץ והצגה
        XmlDataSource1.Save();

    }
    //protected void toolTip(string id)
    //{
    //    bool canPublish = false; //משתנה בוליאני - כברירת מחדל - לא ניתן לפרסום
    //    List<string> disCalss = new List<string>(4); //משתנה ל class
    //    disCalss[0] = "disabled";
    //    string[] disCalss = new string[5];
    //    //    //במידה ולא ניתן לפרסם
    //    if (canPublish == false)
    //    {
    //        if ("GameInstructions".Length < 2)
    //        {
    //            canPublish = false;
    //        }
    //        else
    //        {
    //            canPublish = true;
    //        }

    //        if (GameName.Length < 2)
    //        {
    //            canPublish = false;
    //        }
    //        else
    //        {
    //            canPublish = true;
    //        }
    //        if (items.ChildNodes.Count < 5)
    //        {
    //            canPublish = false;
    //        }
    //        else if (questions.ChildNodes.Count >= 20)
    //        {
    //            int correctQuestions = questions.SelectNodes("question[@true='true']").Count;
    //            int wrongQuestions = questions.SelectNodes("question[@true='false']").Count;
    //            if (correctQuestions < 1 || wrongQuestions < 1)
    //            {
    //                disCalss[3] = "קטגוריה";
    //                canPublish = false;
    //            }
    //            else
    //            {
    //                disCalss[3] = "";
    //            }

    //        }

    //        if (disCalss[1] == "" && disCalss[2] == "" && disCalss[3] == "")
    //        {
    //            canPublish = true;
    //            disCalss[0] = "enabled";
    //        }

    //        if (canPublish == false)
    //        {
    //            disCalss[0] = "disabled";
    //            myGame.Attributes["published"].InnerText = "false";
    //            XmlDataSource1.Save();
    //        }

    //       // הוספת קלאס של לא מאופשר – שלב 2
    //                }
    //    disCalss[4] = questions.ChildNodes.Count.ToString();
    //    var result = string.Join(",", disCalss);
    //    return result;

    //}

    ////public string CheckIfCanPublish(string id)
    ////{
    ////    XmlDocument xmlDoc = XmlDataSource1.GetXmlDocument(); //טעינה של העץ
    ////    XmlNode myGame = xmlDoc.SelectSingleNode("/games/game[@id=" + id + "]"); //קבלת המשחק שאנו רוצים
    ////    string GameInstructions = Server.UrlDecode(myGame.SelectSingleNode("GameName/GameInstructions").InnerXml);
    ////    string GameName = Server.UrlDecode(myGame.SelectSingleNode("game/GameName").InnerXml);
    ////    //string unCatagory = Server.UrlDecode(myGame.SelectSingleNode("props/uncatagory").InnerXml);
    ////    XmlNode items = myGame.SelectSingleNode("items");
    ////    bool canPublish = false; //משתנה בוליאני - כברירת מחדל - לא ניתן לפרסום
    ////                             //List<string> disCalss = new List<string>(4); //משתנה ל class
    ////                             //disCalss[0] = "disabled";
    ////    string[] disCalss = new string[5];
    ////    disCalss[0] = "disabled";

    ////    //במידה ולא ניתן לפרסם
    ////    if (canPublish == false)
    ////    {
    ////        if (GameInstructions.Length < 2)
    ////        {
    ////            canPublish = false;
    ////        }
    ////        else
    ////        {
    ////            canPublish = true;
    ////        }

    ////        if (GameName.Length < 2)
    ////        {
    ////            canPublish = false;
    ////        }
    ////        else
    ////        {
    ////            canPublish = true;
    ////        }
    ////        if (items.ChildNodes.Count < 5)
    ////        {
    ////            canPublish = false;
    ////        }
    ////        //else if (questions.ChildNodes.Count >= 20)
    ////        //{
    ////        //    int correctQuestions = questions.SelectNodes("question[@true='true']").Count;
    ////        //    int wrongQuestions = questions.SelectNodes("question[@true='false']").Count;
    ////        //    if (correctQuestions < 1 || wrongQuestions < 1)
    ////        //    {
    ////        //        disCalss[3] = "קטגוריה";
    ////        //        canPublish = false;
    ////        //    }
    ////        //    else
    ////        //    {
    ////        //        disCalss[3] = "";
    ////        //    }


    ////        //}

    ////        //if (disCalss[1] == "" && disCalss[2] == "" && disCalss[3] == "")
    ////        //{
    ////        //    canPublish = true;
    ////        //    disCalss[0] = "enabled";
    ////        //}

    ////        //if (canPublish == false)
    ////        //{
    ////        //    disCalss[0] = "disabled";
    ////        //    myGame.Attributes["published"].InnerText = "false";
    ////        //    XmlDataSource1.Save();
    ////        //}

    ////        //הוספת קלאס של לא מאופשר – שלב 2
    ////    }
    ////    //disCalss[4] = questions.ChildNodes.Count.ToString();
    ////    var result = string.Join(",", disCalss);
    ////    return result;

    ////}

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        // אנו מושכים את המשתנה שעברנו – במקרה שלנו קוד המשחק
        Session["GameCodeSession"] = e.CommandArgument;

        // עלינו לברר איזו פקודה צריכה להתבצע - הפקודה רשומה בכל כפתור             
        switch (e.CommandName)
        {
            //אם נלחץ על כפתור מחיקה יקרא לפונקציה של מחיקה                    
            case "deleteGame":
                string gameId = e.CommandArgument.ToString();
                SureDeletGame(gameId);

                break;

            //אם נלחץ על כפתור עריכה (העפרון) נעבור לדף עריכה                    
            case "editGame":

                Response.Redirect("Edit.aspx");
                break;
        }

    }
    void SureDeletGame(string gameId)
    {
        XmlDocument myDoc = XmlDataSource1.GetXmlDocument();

        myDoc.Load(Server.MapPath("tree/games.xml")); //טעינת העץ

        //הסרת ענף של משחק קיים באמצעות זיהוי הקוד שניתן לו על ידי לחיצה עליו מתוך הטבלה
        //שמירה ועדכון לתוך העץ ולגריד ויו
        XmlNode node = myDoc.SelectSingleNode("/games/game[@GameCode='" + gameId + "']");
        node.ParentNode.RemoveChild(node);

        myDoc.Save(Server.MapPath("tree/games.xml"));

        XmlDataSource1.Save();
        GridView1.DataBind();

    }

}