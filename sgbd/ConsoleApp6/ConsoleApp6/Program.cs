using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;


namespace ConsoleApp6
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        //connectionString
        string connnectionString = "Data Source=DESKTOP-NICOLEM\\SQLEXPRESS03;Initial Cataog=Geschaft;" + "Integrated Security=true";

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlDataAdapter adapter;


            string GeschaftQuery = "select * from Geschaft";
            string Kategorien = "select * from Angestellte";

            DataSet dataSet1 = new DataSet();

            try
            {
                //open connection and create DataAdapter
                connection.Open();
                adapter = new SqlDataAdapter(GeschaftQuery, connection);
                adapter.Fill(dataSet1, "Geschaft");
                adapter = new SqlDataAdapter(Kategorien, connection);
                adapter.Fill(dataSet1, "Angestellte");

                dataSet1.Relations.Add("Geschaft", dataSet1.Tables["Geschaft"].Columns["GeschaftId"],
                                        dataSet1.Tables["Angestellte"].Columns["GeschaftId"]);
                connection.Close();

                dataGridView1.DataSource = DataSet1.Tables["GeschaftId"];
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.ToString());
                connection.Close();
            }
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex != -1)
            {
                string geschaftID;
                object value = dataGridView1.Rows[e.RowIndex].Cells[0].Value;
                if (value is DBNull) { return; }

                geschaftID = value.ToString();
                RetrieveCopiesGeschaftID(geschaftID);
            }
        }

        private void RetrieveCopiesGeschaftID(string geschaftID)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Angestellte WHERE GeschaftId=@GeschaftId", connection);
                da.SelectCommand.Parameters.AddWithValue("@GeschaftId", geschaftID);

                DataTable dtbl2 = new DataTable();
                da.Fill(dtbl2);
                dataGridView2.DataSource = dtbl2;
                connection.Close();
            }
        }
    }
}
