using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Admins;

public class AbrirCuposModel : PageModel
{
    private readonly ILogger<AbrirCuposModel> _logger;
    public String errorMessage = "";
    public String successMessage= "";
    public List<Cupo> listaCupos = new List<Cupo>();
    public int nroCupos;
    public String Semestre = "2024-I";



    public AbrirCuposModel(ILogger<AbrirCuposModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        try
        {
            var connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["LocalhostServer"];
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                String sql = "SELECT A.Id_Estudiante, A.apellidos, A.nombres, E.semestre, A.Id_Reserva FROM T_Asignados A inner join T_Estudiante E on A.Id_Estudiante = E.Id_Estudiante";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Cupo cupo = new Cupo();
                            cupo.alumnoId = "" + reader.GetString(0);
                            cupo.apellidos = "" + reader.GetString(1);
                            cupo.nombres = "" + reader.GetString(2);
                            cupo.semestre = "" + reader.GetInt32(3);
                            cupo.reserva = "" + reader.GetString(4);
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

    public void OnPost()
    {
        String? cupos = Request.Form["nroCupos"];
        // Semestre = Request.Form["Semestre"];

        if ( cupos.Length == 0 || Semestre.Length == 0) {
            errorMessage = "Post Request: Faltan Datos";
            return;
        }


        if ((cupos is not null) && cupos.Length != 0) {
            nroCupos = Int32.Parse(cupos);
            try
            {
                var connectionString = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetSection("ConnectionStrings")["LocalhostServer"];
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    String sql;

                    // sql = "DELETE FROM T_ThePeriod";
                    // using (SqlCommand command = new SqlCommand(sql, conn)) { command.ExecuteNonQuery(); }
                    // sql = "INSERT INTO T_ThePeriod (Periodo) VALUES (@periodo)";
                    // using (SqlCommand command = new SqlCommand(sql, conn)) {
                    //     command.Parameters.AddWithValue("@periodo", Semestre);
                    //     command.ExecuteNonQuery();
                    // }

                    sql = "DELETE FROM T_Asignados";
                    using (SqlCommand command = new SqlCommand(sql, conn)) { command.ExecuteNonQuery(); }
                    sql = "EXEC InsertarPagadosEnAsignados @TotalCupos, @Periodo";
                    using (SqlCommand command = new SqlCommand(sql, conn))
                    {
                        command.Parameters.AddWithValue("@TotalCupos", nroCupos);
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
        }
        successMessage = "Proceso Exitoso";
        Response.Redirect("/Admins/AbrirCupos");
    }
}

public class Cupo
{
    public String alumnoId;
    public String apellidos;
    public String nombres;
    public String semestre;
    public String reserva;
    public String carrera; // asistio, no asistio

    public String cupos;
}

