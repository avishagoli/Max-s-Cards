<%@ WebHandler Language="C#" Class="Handler" %>
using System;
using System.Web;
using System.Xml;
using Newtonsoft.Json;

public class Handler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        string gameCode = context.Request["GameCode"]; //קוד המשחק שנשלח מאנימייט

        XmlDocument myDoc = new XmlDocument();
        myDoc.Load(context.Server.MapPath("tree/games.xml")); //טעינת העץ שלכם

        XmlNode gameNode = myDoc.SelectSingleNode("//game[@GameCode='" + gameCode + "']"); //שליפת הענף של המשחק המתאים

        if (gameNode != null) //אם קיים משחק שתואם לקוד
        {
            string published = gameNode.Attributes["isPublish"].Value.ToString();
            if (published == "true")
            {
                //כאן תתבצע הבדיקה לפרסום
                //ההמרה לג'ייסון תתבצע רק אם המשחק קיים ומפורסם
                string jsonText = JsonConvert.SerializeXmlNode(gameNode); //המרת הענף מהעץ לטקסט במבנה של ג'ייסון
                context.Response.Write(jsonText); //שליחת המחרוזת אל אנימייט
            }
            else //אם המשחק לא קיים
            {
                context.Response.Write("0"); //שליחת תשובה שלא נמצא משחק
            }
        }
        else
        {
            context.Response.Write("1");
        }
    }

    public bool IsReusable
    {
        get
        {
            return true;
        }
    }
}
















