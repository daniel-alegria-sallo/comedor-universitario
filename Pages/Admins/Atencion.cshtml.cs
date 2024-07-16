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
            String connectionString = "Server=localhost;Database=DatabaseName;User Id=UserId;Password=1pass;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "exec proc_atender(@codAlumno)";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.AddWithValue("@codAlumno", alumno.alumnoId);
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
        successMessage = "Proceso Exitoso";

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

