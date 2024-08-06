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
    public Reporte reporte = new Reporte();


    public ReportesModel(ILogger<ReportesModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        listaReportes.Clear();
        try
        {
            String connectionString = "Server=(local);Database=EstudiantesDB;User Id=sa;Password=Ce/danielonsql;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "select Id_Estudiante, Fecha, Periodo  from fnAsistencia()";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Reporte reporte = new Reporte();
                            reporte.alumnoId = "" + reader.GetString(0);
                            reporte.fecha = "" + reader.GetDateTime(1);
                            // reporte.estado = "" + reader.GetString(2);
                            reporte.periodo = "" + reader.GetString(2);
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
        listaReportes.Clear();

        reporte.alumnoId = Request.Form["alumno"];
        reporte.periodo = Request.Form["periodo"];
        reporte.fechaInicial = Request.Form["fechaInicial"];
        reporte.fechaFinal = Request.Form["fechaFinal"];

        // if (
        //         reporte.alumnoId.Length == 0 &&
        //         reporte.periodo.Length == 0 &&
        //         reporte.fechaInicial.Length == 0 &&
        //         reporte.fechaFinal.Length == 0
        // )
        // {
        //     errorMessage = "Datos faltan, no se filtraron los resultados ";
        //     return;
        // }

        try
        {
            String connectionString = "Server=(local);Database=EstudiantesDB;User Id=sa;Password=Ce/danielonsql;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = setup_options_query();
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    setup_options_parameters(command);
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Reporte reporte = new Reporte();
                            reporte.alumnoId = "" + reader.GetString(0);
                            reporte.fecha = "" + reader.GetDateTime(1);
                            // reporte.estado = "" + reader.GetString(2);
                            reporte.periodo = "" + reader.GetString(2);
                            listaReportes.Add(reporte);
                        }
                    }

                }
            }
        }
        catch (Exception ex)
        {
            errorMessage = ex.Message;
            return;
        }

        //
        reporte.alumnoId = "";
        successMessage = "Proceso Exitoso";
        reporte.alumnoId = "";

        // Response.Redirect("/Alumnos/Reportes");
    }

    public string setup_options_query() {
        String sql = "SELECT Id_Estudiante, Fecha, Periodo FROM ";
        if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length == 0)
        {
            sql += "fnAsistencia()";
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length == 0)
        {
            sql += "fnAsistenciaPorEstudiante(@Id_Estudiante)";
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length == 0)
        {
            sql += "fnAsistenciaPorEstudianteyPeriodo(@Id_Estudiante, @Periodo)";
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length == 0)
        {
            sql += "fnAsistenciaPorEstudianteyPeriodoyFecha(@Id_Estudiante, @Periodo, @FechaInicial)";
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length != 0)
        {
            sql += "fnAsistenciaPorEstudianteyPeriodoyRangoFechas(@Id_Estudiante, @Periodo, @FechaInicial, @FechaFinal)";
        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length != 0)
        {
            sql += "fnAsistenciaPorPeriodoyRangoFechas(@Periodo, @FechaInicial, @FechaFinal)";
        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length != 0)
        {
            sql += "fnAsistenciaPorRangoFechas(@FechaInicial, @FechaFinal)";
        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length != 0)
        {
            sql += "fnAsistenciaPorFecha(@FechaFinal)";
        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length == 0)
        {
            sql += "fnAsistenciaPorFecha(@FechaInicial)";
        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length == 0)
        {
            sql += "fnAsistenciaPorPeriodo(@Periodo)";
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length == 0)
        {
            sql += "fnAsistenciaPorEstudianteYFecha(@Periodo, @FechaInicial)";
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length != 0)
        {
            sql += "fnAsistenciaPorEstudianteYFecha(@Periodo, @FechaFinal)";
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length != 0)
        {
            sql += "fnAsistenciaPorEstudianteYRangoFechas(@Periodo, @FechaInicial, @FechaFinal)";
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length != 0)
        {
            sql += "fnAsistenciaPorEstudianteyPeriodoyFecha(@Id_Estudiante, @Periodo, @FechaFinal)";

        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length == 0)
        {
            sql += "fnAsistenciaPorPeriodoyFecha(@Periodo, @FechaInicial)";

        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length != 0)
        {
            sql += "fnAsistenciaPorPeriodoyFecha(@Periodo, @FechaFinal)";

        }

        return sql;
    }

    public void setup_options_parameters(SqlCommand command) {
        String sql = "SELECT Id_Estudiante, Fecha, Periodo FROM ";
        if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length == 0)
        {
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length == 0)
        {
            command.Parameters.AddWithValue("@Id_Estudiante", reporte.alumnoId);
        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length == 0)
        {
            command.Parameters.AddWithValue("@Id_Estudiante", reporte.alumnoId);
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);

        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length == 0)
        {
            command.Parameters.AddWithValue("@Id_Estudiante", reporte.alumnoId);
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);
            command.Parameters.AddWithValue("@FechaInicial", reporte.fechaInicial);

        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length != 0)
        {
            command.Parameters.AddWithValue("@Id_Estudiante", reporte.alumnoId);
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);
            command.Parameters.AddWithValue("@FechaInicial", reporte.fechaInicial);
            command.Parameters.AddWithValue("@FechaFinal", reporte.fechaFinal);

        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length != 0)
        {
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);
            command.Parameters.AddWithValue("@FechaInicial", reporte.fechaInicial);
            command.Parameters.AddWithValue("@FechaFinal", reporte.fechaFinal);

        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length != 0)
        {
            command.Parameters.AddWithValue("@FechaInicial", reporte.fechaInicial);
            command.Parameters.AddWithValue("@FechaFinal", reporte.fechaFinal);

        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length != 0)
        {
            command.Parameters.AddWithValue("@FechaFinal", reporte.fechaFinal);

        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length == 0)
        {
            command.Parameters.AddWithValue("@FechaInicial", reporte.fechaInicial);

        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length == 0)
        {
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);

        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length == 0)
        {
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);
            command.Parameters.AddWithValue("@FechaInicial", reporte.fechaInicial);

        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length != 0)
        {
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);
            command.Parameters.AddWithValue("@FechaFinal", reporte.fechaFinal);

        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length == 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length != 0)
        {
            command.Parameters.AddWithValue("@Id_Estudiante", reporte.alumnoId);
            command.Parameters.AddWithValue("@FechaInicial", reporte.fechaInicial);
            command.Parameters.AddWithValue("@FechaFinal", reporte.fechaFinal);

        }
        else if ( reporte.alumnoId.Length != 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length != 0)
        {
            command.Parameters.AddWithValue("@Id_Estudiante", reporte.alumnoId);
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);
            command.Parameters.AddWithValue("@FechaFinal", reporte.fechaFinal);
        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length != 0 && reporte.fechaFinal.Length == 0)
        {
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);
            command.Parameters.AddWithValue("@FechaInicial", reporte.fechaInicial);
        }
        else if ( reporte.alumnoId.Length == 0 && reporte.periodo.Length != 0 && reporte.fechaInicial.Length == 0 && reporte.fechaFinal.Length != 0)
        {
            command.Parameters.AddWithValue("@Periodo", reporte.periodo);
            command.Parameters.AddWithValue("@FechaFinal", reporte.fechaFinal);
        }

    }
}

public class Reporte
{
    public String alumnoId;
    public String periodo;
    public String fechaInicial;
    public String fechaFinal;

    public String fecha;
    public String estado; // asistio, no asistio

    public bool nada_lleno() {
        return (this.alumnoId.Length == 0 &&
                this.periodo.Length == 0 &&
                this.fechaInicial.Length == 0 &&
                this.fechaFinal.Length == 0);
    }
}

