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
    public String Semestre = "2024-I";

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
        int rows_modified;
        try
        {
            String connectionString = "Server=(local);Database=EstudiantesDB;User Id=sa;Password=Ce/danielonsql;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "exec spInscribirEstudiante @codAlumno, @codMatricula, @Periodo, @Pago";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.AddWithValue("@codAlumno", inscripcion.alumnoId);
                    command.Parameters.AddWithValue("@codMatricula", inscripcion.codMatricula);
                    command.Parameters.AddWithValue("@Periodo", Semestre);
                    command.Parameters.AddWithValue("@Pago", "0");
                    rows_modified = command.ExecuteNonQuery();
                }
            }

            //
            inscripcion.clear();
            if (rows_modified > 0) {
                successMessage = "Proceso Exitoso";
            } else {
                successMessage = "Codigo incorrecto o ya esta inscrito";
            }

        }
        catch (Exception ex)
        {
            errorMessage = ex.Message;
            return;
        }

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
