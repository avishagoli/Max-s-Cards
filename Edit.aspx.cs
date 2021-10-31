using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Drawing;
using System.Web.UI.WebControls;
using System.Xml;
using Image = System.Web.UI.WebControls.Image;

public partial class edit : System.Web.UI.Page
{
    //נתיב לשמירה התמונות
    string imagesLibPath = "uploadedFiles/";
    //נתיב לשמירה תמונות התצוגה מקדימה
    string imagesTempLibPath = "TempImages/";
    int NumberOfImages = 2;
    string GameCodeNum;
    XmlNode Game;
    XmlDocument myDoc;
    //הגדרת שם תמונה
    string imageNewName;


    protected void Page_Init(object sender, EventArgs e)
    {
        myDoc = new XmlDocument();

        myDoc.Load(Server.MapPath("tree/games.xml"));
        GameCodeNum = Session["GameCodeSession"].ToString();//שמירת קוד המשחק

        Game = myDoc.SelectSingleNode("/games/game[@GameCode='" + GameCodeNum + "']"); //שליפת המשחק לפי קוד המשחק הנבחר

        GameNameEdit.Text = Server.UrlDecode(Game.SelectSingleNode("GameName").InnerText); //שליפת השם של המשחק הנבחר לתוך הטקסט בוקס 
        GameInstructionsEdit.Text = Server.UrlDecode(Game.SelectSingleNode("GameInstructions").InnerText); //שליפת הוראות המשחק לתוך הטקסט בוקס 

        GameInstructionLbl.Text = Server.UrlDecode(Game.SelectSingleNode("GameInstructions").InnerText);
        GameNameLbl.Text = Server.UrlDecode(Game.SelectSingleNode("GameName").InnerText);


    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["GameCodeSession"] != null)
        {

            //קבלת המשחק שממנו הגענו לעמוד העריכה
            GameCodeNum = Session["GameCodeSession"].ToString();

            //כאן נרשום את השאילתה החדשה לתוך רכיב ה- XmlDataSource
            //על מנת שהשאלות יהיו מותאמות למשחק שבחרנו
            XmlDataSource1.XPath = "/games/game[@GameCode=" + GameCodeNum + "]/items/item[@feedback='true']";
            XmlDataSource2.XPath = "/games/game[@GameCode=" + GameCodeNum + "]/items/item[@feedback='false']";

            myDoc = XmlDataSource1.GetXmlDocument();
            XmlNode gameNode = myDoc.SelectSingleNode("/games/game[@GameCode='" + GameCodeNum + "']");
            XmlNodeList correct = gameNode.SelectNodes("items/item[@feedback='true']");
            XmlNodeList notCorrect = gameNode.SelectNodes("items/item[@feedback='false']");

            CheckPublishConditions(correct.Count, notCorrect.Count);


            foreach (GridViewRow gvr in GridViewTrue.Rows)
            {

                //הפנייה בשורה הבאה תיעשה לאחד מהפקדים בגריד וויו שיש להם אפשרות לזהות את האיי-די של המשחק שאליו מתייחסת השורה 
                string ItemIDgeneral = ((Label)gvr.FindControl("ItemLbl")).Attributes["ItemLabel"].ToString();

                //שליפת הענף שמכיל את השם (בטקסט או בתמונה) של הפריט
                XmlNode myItem = gameNode.SelectSingleNode("items/item[@id='" + ItemIDgeneral + "']");
                bool isCorrect = Convert.ToBoolean(myItem.SelectSingleNode("@id/..").Attributes["feedback"].Value);
                //בדיקת המאפיין המגדיר את סוג שם הפריט = תמונה או טקסט 
                if (isCorrect)
                {
                    if (myItem.SelectSingleNode("@id/..").Attributes["AnsType"].Value == "image")
                    {
                        //הצגת פקד התמונה
                        ((Image)gvr.FindControl("ItemNameImage")).Visible = true;
                        ((Label)gvr.FindControl("ItemLbl")).Visible = false;
                    }
                    else
                    {
                        //הצגת פקד הלייבל
                        ((Label)gvr.FindControl("ItemLbl")).Visible = true;

                    }
                }
                //את התוכן של הפקדים (טקסט או תמונה) העלינו כבר בעמוד עצמו 
            }

            foreach (GridViewRow gvr in GridViewFalse.Rows)
            {

                //הפנייה בשורה הבאה תיעשה לאחד מהפקדים בגריד וויו שיש להם אפשרות לזהות את האיי-די של המשחק שאליו מתייחסת השורה 
                string ItemIDgeneral = ((Label)gvr.FindControl("ItemLbl")).Attributes["ItemLabel"].ToString();

                //שליפת הענף שמכיל את השם (בטקסט או בתמונה) של הפריט
                XmlNode myItem = gameNode.SelectSingleNode("items/item[@id='" + ItemIDgeneral + "']");
                bool isCorrect = Convert.ToBoolean(myItem.SelectSingleNode("@id/..").Attributes["feedback"].Value);
                //בדיקת המאפיין המגדיר את סוג שם הפריט = תמונה או טקסט 
                if (!isCorrect)
                {
                    if (myItem.SelectSingleNode("@id/..").Attributes["AnsType"].Value == "image")
                    {
                        //הצגת פקד התמונה
                        ((Image)gvr.FindControl("ItemNameImage")).Visible = true;
                        ((Label)gvr.FindControl("ItemLbl")).Visible = false;
                    }
                    else
                    {
                        //הצגת פקד הלייבל
                        ((Label)gvr.FindControl("ItemLbl")).Visible = true;

                    }
                }
                //את התוכן של הפקדים (טקסט או תמונה) העלינו כבר בעמוד עצמו 
            }

            //שליפת הענף שמכיל את השם (בטקסט או בתמונה) של האייטם
        }
        else
        {
            Response.Redirect("Default.aspx");
        }

    }

    protected void CheckPublishConditions(int trueItems, int falseItems)
    {
        string checkMark = "<i class='fas fa-check-circle mx-1'></i>";
        string xMark = "<i class='fas fa-times-circle mx-1'></i>";
        if (trueItems >= 5)
        {
            NumWrongTrue.Text = checkMark + trueItems.ToString() + " פריטים";
        }
        else
        {
            NumWrongTrue.Text = xMark + " לפחות 5 פריטים בקטגוריה";
        }

        if (falseItems >= 5)
        {
            NumWrongFalse.Text = checkMark + falseItems.ToString() + " פריטים";
        }
        else
        {
            NumWrongFalse.Text = xMark + " לפחות 5 פריטים בקטגוריה";
        }
        
    }




    // שמירת שינויים שנעשו בשם המשחק והוראות המשחק
    protected void Button1_Click(object sender, EventArgs e)
    {
        string newGameName = GameNameEdit.Text;
        string newGameInstructions = GameInstructionsEdit.Text;

        //טעינת העץ 
        XmlDocument myDoc = new XmlDocument();
        myDoc.Load(Server.MapPath("tree/games.xml"));
        string GameCodeNum = Session["GameCodeSession"].ToString();//שמירת קוד המשחק

        XmlNode GameName = myDoc.SelectSingleNode("/games/game[@GameCode='" + GameCodeNum + "']/GameName"); //שליפת המשחק לפי קוד המשחק הנבחר
        GameName.InnerText = newGameName;
        XmlNode GameInstructions = myDoc.SelectSingleNode("/games/game[@GameCode='" + GameCodeNum + "']/GameInstructions"); //שליפת המשחק לפי קוד המשחק הנבחר
        GameInstructions.InnerText = newGameInstructions;

        GameInstructionLbl.Text = newGameInstructions;
        GameNameLbl.Text = newGameName;

        myDoc.Save(Server.MapPath("tree/games.xml"));

    }

    protected void addImgTrue(object sender, EventArgs e)
    {
        FileUpload ImageAdd = TrueFileUpload1;
        string imagesLibPath = "uploadedFiles/";
        string fileType = ImageAdd.PostedFile.ContentType;

        if (fileType.Contains("image"))
        {
            // הנתיב המלא של הקובץ עם שמו האמיתי של הקובץ
            string fileName = ImageAdd.PostedFile.FileName;

            // הסיומת של הקובץ
            string endofFilename = fileName.Substring(fileName.LastIndexOf("."));

            //לקיחת הזמן האמיתי למניעת כפילות בתמונות
            string myTime = DateTime.Now.ToString("dd_MM_yy-HH_mm_ss_ffff");

            // חיבור השם החדש עם הסיומת של הקובץ
            string imageNewName = "imageNewName" + myTime + endofFilename;
            ImageAdd.PostedFile.SaveAs(Server.MapPath(imagesLibPath) + imageNewName);
            Session["LastImage"] = imageNewName;

            // Bitmap המרת הקובץ שיתקבל למשתנה מסוג
            System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(ImageAdd.PostedFile.InputStream);

            //קריאה לפונקציה המקטינה את התמונה
            //אנו שולחים לה את התמונה שלנו בגירסאת הביטמאפ ואת האורך והרוחב שאנו רוצים לתמונה החדשה
            System.Drawing.Image objImage = FixedSize(bmpPostedImage);

            //שמירת הקובץ בגודלו החדש בתיקייה
            objImage.Save(Server.MapPath(imagesLibPath) + imageNewName);
            SaveItemToXML("image", "true", imageNewName);
            
        }
        else
        {
            // הקובץ אינו תמונה ולכן לא ניתן להעלות אותו
        }

        Response.Redirect("Edit.aspx");

    }

    protected void addImgFalse(object sender, EventArgs e)
    {
        FileUpload ImageAdd = FalseFileUpload;
        string imagesLibPath = "uploadedFiles/";
        string fileType = ImageAdd.PostedFile.ContentType;

        if (fileType.Contains("image"))
        {
            // הנתיב המלא של הקובץ עם שמו האמיתי של הקובץ
            string fileName = ImageAdd.PostedFile.FileName;

            // הסיומת של הקובץ
            string endofFilename = fileName.Substring(fileName.LastIndexOf("."));

            //לקיחת הזמן האמיתי למניעת כפילות בתמונות
            string myTime = DateTime.Now.ToString("dd_MM_yy-HH_mm_ss_ffff");

            // חיבור השם החדש עם הסיומת של הקובץ
            string imageNewName = "imageNewName" + myTime + endofFilename;
            ImageAdd.PostedFile.SaveAs(Server.MapPath(imagesLibPath) + imageNewName);
            Session["LastImage"] = imageNewName;

            // Bitmap המרת הקובץ שיתקבל למשתנה מסוג
            System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(ImageAdd.PostedFile.InputStream);

            //קריאה לפונקציה המקטינה את התמונה
            //אנו שולחים לה את התמונה שלנו בגירסאת הביטמאפ ואת האורך והרוחב שאנו רוצים לתמונה החדשה
            System.Drawing.Image objImage = FixedSize(bmpPostedImage);

            //שמירת הקובץ בגודלו החדש בתיקייה
            objImage.Save(Server.MapPath(imagesLibPath) + imageNewName);
            SaveItemToXML("image", "false", imageNewName);

        }
        else
        {
            // הקובץ אינו תמונה ולכן לא ניתן להעלות אותו
        }

        
        Response.Redirect("Edit.aspx");
    }

    // פונקציה המקבלת את התמונה שהועלתה , האורך והרוחב שאנו רוצים לתמונה ומחזירה את התמונה המוקטנת
    static System.Drawing.Image FixedSize(System.Drawing.Image imgPhoto)
    {
        int Width = 80;
        int Height = 80;
        int sourceWidth = Convert.ToInt32(imgPhoto.Width);
        int sourceHeight = Convert.ToInt32(imgPhoto.Height);

        int sourceX = 0;
        int sourceY = 0;
        int destX = 0;
        int destY = 0;

        float nPercent = 0;
        float nPercentW = 0;
        float nPercentH = 0;

        nPercentW = ((float)Width / (float)sourceWidth);
        nPercentH = ((float)Height / (float)sourceHeight);
        if (nPercentH < nPercentW)
        {
            nPercent = nPercentH;
            destX = System.Convert.ToInt16((Width -
                          (sourceWidth * nPercent)) / 2);
        }
        else
        {
            nPercent = nPercentW;
            destY = System.Convert.ToInt16((Height -
                          (sourceHeight * nPercent)) / 2);
        }

        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);

        System.Drawing.Bitmap bmPhoto = new System.Drawing.Bitmap(Width, Height,
                          PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(imgPhoto.HorizontalResolution,
                         imgPhoto.VerticalResolution);

        System.Drawing.Graphics grPhoto = System.Drawing.Graphics.FromImage(bmPhoto);
        grPhoto.Clear(System.Drawing.Color.White);
        grPhoto.InterpolationMode =
                InterpolationMode.HighQualityBicubic;

        grPhoto.DrawImage(imgPhoto,
            new System.Drawing.Rectangle(destX, destY, destWidth, destHeight),
            new System.Drawing.Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
            System.Drawing.GraphicsUnit.Pixel);

        grPhoto.Dispose();
        return bmPhoto;
    }

    protected string GetLastItemId()
    {
        myDoc.Load(Server.MapPath("tree/games.xml"));
        XmlNode ifItsOne = myDoc.SelectSingleNode("/games/game[@GameCode='" + GameCodeNum + "']/items").ChildNodes[0];
        int MaxItemId;
        //אם חוזרת תשובה שהשאילתה חסרת ערך אז המשתנה שווה 1
        if (ifItsOne == null)
        {
            MaxItemId = 1;
        }
        else
        {
            // הקפצה של מונה מספר הפריט בתוך קובץ האקס אם אל באחד
            MaxItemId = Convert.ToInt16(myDoc.SelectSingleNode("/games/game[@GameCode='" + GameCodeNum + "']/items/item[not(@id < /games/game[@GameCode='" + GameCodeNum + "']/items/item/@id)]/@id").Value);
            MaxItemId++;
        }
        return MaxItemId.ToString();
    }


    // הוספת פריטים לעץ 
    protected void SaveItemToXML(string type, string catagory, string content, string id = null)
    {
        string itemsPath = "/games/game[@GameCode='" + GameCodeNum + "']/items";
        if (id == null)
        {
            id = GetLastItemId();
        }

        myDoc.Load(Server.MapPath("tree/games.xml"));

        //בדיקה האם הפריט קיים
        //משתנה לבדיקת האם יש לפחות פריט אחת במשחק


        //יצירת מסיח
        XmlElement newItem = myDoc.CreateElement("item");
        //יצירת מאפיינים
        newItem.SetAttribute("AnsType", type);
        newItem.SetAttribute("feedback", catagory);
        newItem.SetAttribute("id", id);
        XmlText newItemValue = myDoc.CreateTextNode(content);

        //הכנסה להיררכיה
        newItem.AppendChild(newItemValue);

        //הכנסה לעץ בהיררכיה
        myDoc.SelectSingleNode("/games/game[@GameCode='" + GameCodeNum + "']/items").AppendChild(newItem);

        //הכנסת האייטם כראשון
        XmlNode FirstItem = myDoc.SelectNodes(itemsPath + "/item").Item(0);
        myDoc.SelectSingleNode(itemsPath).InsertBefore(newItem, FirstItem);

        //שמירה
        myDoc.Save(Server.MapPath("tree/games.xml"));
        GridViewTrue.DataBind();
        GridViewFalse.DataBind();
        // ניקוי תיבת הטקסט
        textItem.Text = "";

        //שמירת ID של האייטם לזיהוי בהמשך
        Session["ItemIDSession"] = id;
        Response.Redirect("Edit.aspx");

    }

    // טבלה עם הפריטים שהוספנו למשחק
    protected void GridViewTrue_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Session["ItemIDSession"] = e.CommandArgument;

        // עלינו לברר איזו פקודה צריכה להתבצע - הפקודה רשומה בכל כפתור             
        switch (e.CommandName)
        {

            case "deletItembtn":
                //להוביל למחיקת פריט + התראה לפני
                string itemIdToDelte = e.CommandArgument.ToString();
                //להוביל למחיקת פריט + התראה לפני
                deleteItem(itemIdToDelte);
                break;
        }
    }
    protected void GridViewFalse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //
        Session["ItemIDSession"] = e.CommandArgument;
        // עלינו לברר איזו פקודה צריכה להתבצע - הפקודה רשומה בכל כפתור             
        switch (e.CommandName)
        {

            case "deletItembtn":
                string itemIdToDelte = e.CommandArgument.ToString();
                //מוביל למחיקת פריט 
                deleteItem(itemIdToDelte);
                break;
        }
    }


    // עריכת פריט
    protected void EditTextItem(string itemIdToEdit)
    {

        //טעינת העץ 
        myDoc.Load(Server.MapPath("tree/games.xml"));

        //מציאת הפריט בעץ לפי הנתיב
        XmlNode foundItem = myDoc.SelectSingleNode("/games/game[@GameCode ='" + GameCodeNum + "'] /items/item[@id='" + itemIdToEdit + "']"); //שליפת המשחק לפי קוד המשחק הנבחר

        bool isCorrect = Convert.ToBoolean(foundItem.SelectSingleNode("@id/..").Attributes["feedback"].Value);
        //בדיקת המאפיין המגדיר את סוג שם הפריט = תמונה או טקסט 

        if (foundItem.SelectSingleNode("@id/..").Attributes["AnsType"].Value == "image")
        {
            //מציאת פקד תמונת התצוגה המקדימה המתאים

            FileUpload fileUpload = editUplaod;
            string imagesLibPath = "uploadedFiles/";
            string fileType = fileUpload.PostedFile.ContentType;

            if (fileType.Contains("image"))
            {
                // הנתיב המלא של הקובץ עם שמו האמיתי של הקובץ
                string fileName = fileUpload.PostedFile.FileName;

                // הסיומת של הקובץ
                string endofFilename = fileName.Substring(fileName.LastIndexOf("."));

                //לקיחת הזמן האמיתי למניעת כפילות בתמונות
                string myTime = DateTime.Now.ToString("dd_MM_yy-HH_mm_ss_ffff");

                // חיבור השם החדש עם הסיומת של הקובץ
                string imageNewName = "imageNewName" + myTime + endofFilename;
                fileUpload.PostedFile.SaveAs(Server.MapPath(imagesLibPath) + imageNewName);
                Session["LastImage"] = imageNewName;

                // Bitmap המרת הקובץ שיתקבל למשתנה מסוג
                System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(fileUpload.PostedFile.InputStream);

                //קריאה לפונקציה המקטינה את התמונה
                //אנו שולחים לה את התמונה שלנו בגירסאת הביטמאפ ואת האורך והרוחב שאנו רוצים לתמונה החדשה
                System.Drawing.Image objImage = FixedSize(bmpPostedImage);

                //שמירת הקובץ בגודלו החדש בתיקייה
                objImage.Save(Server.MapPath(imagesLibPath) + imageNewName);
                foundItem.InnerText = imageNewName;

            }
        }
        else
        {
            //עריכת טקסט 
            foundItem.InnerText = textItem.Text;

        }
        myDoc.Save(Server.MapPath("tree/games.xml"));
        Response.Redirect("Edit.aspx");

    }

    // מחיקת פריט
    protected void deleteItem(string itemIdToDelte)
    {

        XmlDocument myDoc = XmlDataSource1.GetXmlDocument();

        //טעינת העץ
        myDoc.Load(Server.MapPath("tree/games.xml"));
        XmlNode deleteItem = myDoc.SelectSingleNode("/games/game[@GameCode ='" + GameCodeNum + "'] /items/item[@id='" + itemIdToDelte + "']");
        deleteItem.ParentNode.RemoveChild(deleteItem);
        myDoc.Save(Server.MapPath("tree/games.xml"));

        XmlDataSource1.Save();
        GridViewTrue.DataBind();
        Response.Redirect("Edit.aspx");
    }

    protected void addTextTrue(object sender, EventArgs e)
    {
        SaveItemToXML("text", "true", textItem.Text);
        Response.Redirect("Edit.aspx");

    }

    protected void addTextFalse(object sender, EventArgs e)
    {
        SaveItemToXML("text", "false", textItem.Text);
        Response.Redirect("Edit.aspx");

    }


    protected void EditText(object sender, EventArgs e)
    {

        if (sender.GetType().Name == "Button")
        {
            Button myButton = (Button)sender;
            string itemId = myButton.Attributes["Data-Edit"];
            EditTextItem(itemId);
        }

    }

    protected void EditImage(object sender, EventArgs e)
    {
        if (sender.GetType().Name == "Button")
        {
            Button myButton = (Button)sender;
            string itemId = myButton.Attributes["Data-Edit"];
            EditTextItem(itemId);
        }
    }
}



/*
 Image output = (Image)FindControl("output");
                //קבלת שם הקובץ
                var fileName = System.IO.Path.GetFileName(output.ImageUrl);
                //קבלת הנתיב החדש שבו אנו רוצים שהקובץ יהיה
                var destFile = System.IO.Path.Combine(Server.MapPath(imagesLibPath), fileName);
                //פנייה לקובץ עצמו
                var myFile = Server.MapPath(output.ImageUrl);
                //העברה של הקובץ לתיקיית התמונות
                System.IO.File.Move(myFile, destFile);
                //ניקוי התצוגה המקדימה לתמונת ברירת המחדל
                output.ImageUrl = "";

                string myImg = (string)Session["imageName"];
                foundItem.InnerText = myImg;


                //מחיקת כל התמונות שנשארו בתיקייה הזמנית
                string[] files = System.IO.Directory.GetFiles(Server.MapPath(imagesTempLibPath));
                //מעבר על כל התמונות שנמצאות בתיקייה הזמנית
                foreach (string LeftFile in files)
                {
                    //מחיקת התמונה
                    System.IO.File.Delete(LeftFile);
                }
*/