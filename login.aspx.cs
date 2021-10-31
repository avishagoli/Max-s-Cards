using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = "";
    }

    protected void Entrance(object sender, EventArgs e)
    {
        // אם שם המשתמש והסיסמה נכונים
        if (userName.Text == "admin" && Password.Text == "telem")
        {
            Response.Redirect("Default.aspx");
        }


        else
        {
            //אם גם הסיסמה וגם המשתמש שגויים
            if (userName.Text != "admin" && Password.Text != "telem")
            {
                Label1.Visible = true;
                Label1.Text = "שם משתמש וסיסמה שגויים";
            }

            //אם שתי התיבות ריקות מתוכן
            if (userName.Text == "" && Password.Text == "")
            {
                Label1.Visible = true;
                Label1.Text = "לא הוכנסו פרטים למערכת";
            }

          //אם שם המשתמש שגוי אך הסיסמה נכונה
           if (userName.Text != "admin" && Password.Text == "telem")
            {
                Label1.Visible = true;
                Label1.Text = "שם משתמש שגוי";
            }
           //אם השם משתמש נכון אך הסיסמה שגויה
            if(userName.Text == "admin" && Password.Text != "telem")
            {
                Label1.Visible = true;
                Label1.Text = "סיסמה שגויה";
            }
        }

    }
}