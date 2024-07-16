using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Alumnos;

public class ReportesModel : PageModel
{
    private readonly ILogger<ReportesModel> _logger;
    public List<Reporte> listaReportes = new List<Reporte>();

    public ReportesModel(ILogger<ReportesModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        try
        {
            String connectionString = "Server=localhost;Database=DatabaseName;User Id=UserId;Password=1pass;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "SELECT * FROM sp_Reporte(@codAlumno, @codMatricula)";
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
}

public class Reporte
{
    public String id;
    public String fecha;
    public String estado; // asistio, no asistio
}

