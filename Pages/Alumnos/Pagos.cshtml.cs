using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Alumnos;

public class PagosModel : PageModel
{
    private readonly ILogger<PagosModel> _logger;
    public String errorMessage = "";
    public String successMessage= "";
    public Pago pago = new Pago();

    public PagosModel(ILogger<PagosModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }

    public void OnPost()
    {
        pago.alumnoId = Request.Form["alumno"];
        // pago.codMatricula = Request.Form["codMatricula"];

        if (
                pago.alumnoId.Length == 0
                || pago.codMatricula.Length == 0
           )
        {
            errorMessage = "Faltan ingresar datos";
            return;
        }

        //
        try
        {
            String connectionString = "Server=(local);Database=EstudiantesDB;User Id=sa;Password=Ce/danielonsql;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "exec spPagar @codAlumno";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.AddWithValue("@codAlumno", pago.alumnoId);
                    // command.Parameters.AddWithValue("@codMatricula", pago.codMatricula);
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
        pago.clear();
        successMessage = "Proceso Exitoso";

        // Response.Redirect("/Alumnos/Reportes");
    }
}

public class Pago
{
    public String alumnoId;
    public String codMatricula;
    public void clear()
    {
        alumnoId = "";
        codMatricula = "";
    }
}
