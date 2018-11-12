using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KHeduLand
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                
                GridView1.DataBind();
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {            
            string command = SqlDataSource3.SelectCommand; // added just for debug purpose
            if (DropDownList1.SelectedValue == "all")
            {
                command = "SELECT land_id,region_name,land_name,area FROM tb_LAND,tb_REGION WHERE tb_LAND.region_id = tb_REGION.region_id";
            }
            else
            {
                command = "SELECT land_id,region_name,land_name,area FROM tb_LAND,tb_REGION WHERE tb_LAND.region_id = tb_REGION.region_id AND tb_LAND.region_id='" + DropDownList1.SelectedItem.Value + "'";
            }
            SqlDataSource3.SelectCommand = command;
            SqlDataSource3.DataBind();
            
        }
        protected override object SaveViewState()
        {
            object baseState = base.SaveViewState();
            object[] myState = new object[2];
            myState[0] = baseState;
            myState[1] = SqlDataSource3.SelectCommand;
            return myState;
        }

        protected override void LoadViewState(object savedState)
        {
            if (savedState != null)
            {
                // Load State from the array of objects that was saved at ;
                // SavedViewState.
                object[] myState = (object[])savedState;
                if (myState[0] != null)
                    base.LoadViewState(myState[0]);
                if (myState[1] != null)
                    SqlDataSource3.SelectCommand = (string)myState[1];
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }
        
    }
}