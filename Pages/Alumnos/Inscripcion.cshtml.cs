using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Alumnos;

public class InscripcionModel : PageModel
{
    private readonly ILogger<InscripcionModel> _logger;
    public String errorMessage = "";
    public String successMessage= "";
    public Inscripcion inscripcion = new Inscripcion();

    public InscripcionModel(ILogger<InscripcionModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }

    public void OnPost()
    {
        inscripcion.alumnoId = Request.Form["alumno"];
        inscripcion.codMatricula = Request.Form["codMatricula"];

        if (
                inscripcion.alumnoId.Length == 0
                || inscripcion.codMatricula.Length == 0
           )
        {
            errorMessage = "Faltan ingresar datos";
            return;
        }

        //
        try
        {
            String connectionString = "Server=localhost;Database=testdb;User Id=sa;Password=Ce/danielonsql;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "exec proc_inscribir @codAlumno, @codMatricula";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.AddWithValue("@codAlumno", inscripcion.alumnoId);
                    command.Parameters.AddWithValue("@codMatricula", inscripcion.codMatricula);
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
        inscripcion.clear();
        successMessage = "Proceso Exitoso";

        // Response.Redirect("/Alumnos/Reportes");
    }
}

public class Inscripcion
{
    public String alumnoId;
    public String codMatricula;
    public void clear()
    {
        alumnoId = "";
        codMatricula = "";
    }
}
