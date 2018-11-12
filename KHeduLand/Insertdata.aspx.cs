using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KHeduLand
{
    public partial class Insertdata : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
               
            }
        }
        
        protected void btn_insertland_Click(object sender, EventArgs e)
        {
            Label1.Visible = false;
            string strConn= WebConfigurationManager.ConnectionStrings["SQLDB"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection())
                {
                    conn.ConnectionString = WebConfigurationManager.ConnectionStrings["SQLDB"].ConnectionString;
                    conn.Open();
                    string sqlStr = "";
                    sqlStr = "SELECT * FROM tb_LAND WHERE land_name=@land_name AND region_id=@region_id";
                    SqlCommand cmd = new SqlCommand(sqlStr, conn);                        
                    cmd.Parameters.AddWithValue("@land_name", tbx_landname.Text);
                    cmd.Parameters.AddWithValue("@region_id", ddl_regionid.SelectedValue);                     
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        Label1.Text = "已有重複土地資料";
                        Label1.Visible=true;
                        dr.Close();
                        return;
                    }
                    dr.Close();
                  
                    sqlStr = "INSERT INTO tb_LAND (land_name,region_id,area) VALUES(@land_name, @region_id, @area); ";
                    cmd = new SqlCommand(sqlStr, conn);
                    cmd.Parameters.AddWithValue("@land_name", tbx_landname.Text);
                    cmd.Parameters.AddWithValue("@region_id", ddl_regionid.SelectedValue);
                    cmd.Parameters.AddWithValue("@area", tbx_area.Text);
                    cmd.ExecuteNonQuery();
                    
                    //Response.Write("<Script language='JavaScript'>alert('新增1筆資料:" + ddl_regionid.SelectedItem + " " + tbx_landname.Text + "');</Script>");
                    // Response.Redirect("Default.aspx",false);
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "新增成功", "<script>alert('新增1筆資料:" + ddl_regionid.SelectedItem + ", " + tbx_landname.Text +", 面積:"+ tbx_area.Text +"公頃"+"');location.href='Default.aspx';</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }                    
        }
        
    }
}
