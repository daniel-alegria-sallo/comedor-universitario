using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Alumnos;

public class AsignacionModel : PageModel
{
    private readonly ILogger<AsignacionModel> _logger;
    public List<Asignacion> listaAsignaciones = new List<Asignacion>();

    public AsignacionModel(ILogger<AsignacionModel> logger)
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
                            Asignacion asignacion = new Asignacion();
                            asignacion.alumnoId = "" + reader.GetString(0);
                            asignacion.estado = "" + reader.GetString(1);
                            listaAsignaciones.Add(asignacion);
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

public class Asignacion
{
    public String alumnoId;
    public String estado; // aceptado, rechazado
}

