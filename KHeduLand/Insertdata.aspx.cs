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
                  
                    sqlStr = "INSERT INTO tb_LAND (region_id,land_name,location_street,authority,area,land_ownership,land_value,neighbor_east,neighbor_south,neighbor_west,neighbor_north,getway,use_period,situation,review,maintain,other) VALUES(@region_id,@land_name,@location_street,@authority,@area,@land_ownership,@land_value,@neighbor_east,@neighbor_south,@neighbor_west,@neighbor_north,@getway,@use_period,@situation,@review,@maintain,@other); ";
                    cmd = new SqlCommand(sqlStr, conn);
                    cmd.Parameters.Add("@region_id", SqlDbType.Int).Value=ddl_regionid.SelectedValue;
                    cmd.Parameters.Add("@land_name", SqlDbType.NVarChar).Value=tbx_landname.Text;
                    cmd.Parameters.Add("@location_street", SqlDbType.NVarChar).Value=tbx_locationstreet.Text;
                    cmd.Parameters.Add("authority", SqlDbType.NVarChar).Value=tbx_authority.Text;
                    cmd.Parameters.Add("@area", SqlDbType.Float).Value=tbx_area.Text;
                    cmd.Parameters.Add("@land_ownership", SqlDbType.NVarChar).Value=tbx_landownership.Text;
                    cmd.Parameters.AddWithValue("@land_value", tbx_landvalue.Text);
                    cmd.Parameters.AddWithValue("@neighbor_east", tbx_neighbor_east.Text);
                    cmd.Parameters.AddWithValue("@neighbor_south", tbx_neighbor_south.Text);
                    cmd.Parameters.AddWithValue("@neighbor_west", tbx_neighbor_west.Text);
                    cmd.Parameters.AddWithValue("@neighbor_north", tbx_neighbor_north.Text);
                    cmd.Parameters.AddWithValue("@getway", tbx_getway.Text);
                    cmd.Parameters.AddWithValue("@use_period", tbx_useperoid.Text);
                    cmd.Parameters.AddWithValue("@situation", tbx_situation.Text);
                    cmd.Parameters.AddWithValue("@review", tbx_review.Text);
                    cmd.Parameters.AddWithValue("@maintain", tbx_maintain.Text);
                    cmd.Parameters.AddWithValue("@other", tbx_other.Text);
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
