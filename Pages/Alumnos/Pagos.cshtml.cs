using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Alumnos;

public class PagosModel : PageModel
{
    private readonly ILogger<PagosModel> _logger;
    public String errorMessage = "";
    public String successMessage= "";
    public Pago pago = new Pago("2024-I");

    public PagosModel(ILogger<PagosModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }

    public void OnPost()
    {
        pago.alumnoId = Request.Query["id"];
        pago.nro_tarjeta = Request.Form["nro_tarjeta"];
        pago.cod_servicio = Request.Form["cod_servicio"];
        pago.cvc = Request.Form["cvc"];
        pago.fv = Request.Form["fv"];
        // pago.codMatricula = Request.Form["codMatricula"];

        if ( pago.alumnoId.Length == 0) {
            errorMessage = "Post Request: No se cuenta con el codigo del alumno";
            Response.Redirect("/Alumnos/Asignacion");
            return;
        }
        if (
                pago.nro_tarjeta.Length == 0
                || pago.nro_tarjeta.Length == 0
                || pago.cod_servicio.Length == 0
                || pago.cvc.Length == 0
                || pago.fv.Length == 0
           )
        {
            errorMessage = "Faltan ingresar datos";
            return;
        }

        //
        try
        {
            var connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["LocalhostServer"];
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "INSERT INTO T_Pagos (Id_Pago, Id_Estudiante, Periodo) VALUES (@idPago, @codAlumno, @periodo)";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    command.Parameters.AddWithValue("@idPago", pago.alumnoId+pago.periodo);
                    command.Parameters.AddWithValue("@codAlumno", pago.alumnoId);
                    command.Parameters.AddWithValue("@periodo", pago.periodo);
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
    public String nro_tarjeta;
    public String cod_servicio;
    public String cvc;
    public String fv;

    public String codMatricula;
    public String periodo;

    public Pago (String periodo) {
        this.periodo = periodo;
    }

    public void clear()
    {
        nro_tarjeta = "";
        codMatricula = "";
    }

}
