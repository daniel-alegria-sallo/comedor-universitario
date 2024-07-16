using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Admins;

public class AbrirCuposModel : PageModel
{
    private readonly ILogger<AbrirCuposModel> _logger;
    public List<Cupo> listaCupos = new List<Cupo>();


    public AbrirCuposModel(ILogger<AbrirCuposModel> logger)
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
                String sql = "SELECT * FROM sp_Cupo(@codAlumno, @codMatricula)";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Cupo cupo = new Cupo();
                            cupo.alumnoId = "" + reader.GetString(0);
                            cupo.semestre = "" + reader.GetString(1);
                            cupo.carrera = "" + reader.GetString(2);
                            listaCupos.Add(cupo);
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

public class Cupo
{
    public String alumnoId;
    public String semestre;
    public String carrera; // asistio, no asistio
}

