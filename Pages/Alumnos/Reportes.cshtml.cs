using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Alumnos;

public class ReportesModel : PageModel
{
    private readonly ILogger<ReportesModel> _logger;
    public List<Reporte> listaReportes = new List<Reporte>();
    public String errorMessage = "";
    public String successMessage = "";
    public String alumnoId = "";


    public ReportesModel(ILogger<ReportesModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        try
        {
            String connectionString = "Server=(local);Database=testdb;User Id=sa;Password=Ce/danielonsql;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "SELECT * FROM sp_ReporteGeneral()";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Reporte reporte = new Reporte();
                            reporte.id = "" + reader.GetString(0);
                            reporte.fecha = "" + reader.GetString(1);
                            reporte.estado = "" + reader.GetString(2);
                            listaReportes.Add(reporte);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Exception: " + ex.ToString());
        }
    }

    public void OnPost()
    {
        alumnoId = Request.Form["alumno"];
        if (alumnoId.Length == 0)
        {
            errorMessage = "Falta ingresar el codigo";
            return;
        }

        try
        {
            String connectionString = "Server=(local);Database=testdb;User Id=sa;Password=Ce/danielonsql;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "exec proc_reportes(@codAlumno)";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.AddWithValue("@codAlumno", alumnoId);
                    command.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            errorMessage = ex.Message;
            return;
        }

        //
        alumnoId = "";
        successMessage = "Proceso Exitoso";

        // Response.Redirect("/Alumnos/Reportes");


    }
}

public class Reporte
{
    public String id;
    public String fecha;
    public String estado; // asistio, no asistio
}

