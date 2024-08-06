using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Admins;

public class AtencionModel : PageModel
{
    private readonly ILogger<AtencionModel> _logger;
    public String errorMessage = "";
    public String successMessage = "";
    public Alumno alumno = new Alumno();
    public String Semestre = "2024-I";


    public AtencionModel(ILogger<AtencionModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }

    public void OnPost()
    {
        alumno.alumnoId = Request.Form["alumno"];

        if (
                alumno.alumnoId.Length == 0
           )
        {
            errorMessage = "Ingrese el codigo";
            return;
        }

        //
        try
        {
            var connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["LocalhostServer"];
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "exec spRegistrarAsistencia @IdEstudiante, @Periodo";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.AddWithValue("@IdEstudiante", alumno.alumnoId);
                    command.Parameters.AddWithValue("@Periodo", Semestre);
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
        alumno.clear();
        successMessage = "Atencion Exitosa";

        // Response.Redirect("/Alumnos/Reportes");
    }

}

public class Alumno
{
    public String alumnoId;
    public void clear()
    {
        alumnoId = "";
    }
}

