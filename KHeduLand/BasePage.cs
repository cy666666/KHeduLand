using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace KHeduLand
{
    public class BasePage : System.Web.UI.Page
    {
        public BasePage() { }
        private void SetActionStamp()
        {
            Session["actionStamp"] = Server.UrlEncode(DateTime.Now.ToString());
        }
        void Page_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetActionStamp();
            }

            ClientScript.RegisterHiddenField("actionStamp", Session["actionStamp"].ToString());
        }
        protected bool IsRefresh
        {
            get
            {
                if (HttpContext.Current.Request["actionStamp"] as string == Session["actionStamp"] as string)
                {
                    SetActionStamp();
                    return false;
                }

                return true;
            }
        }
    }
}