using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace ComedorUniversitario.Pages.Alumnos;

public class AsignacionModel : PageModel
{
    private readonly ILogger<AsignacionModel> _logger;
    public List<Alumno> listaAsignados = new List<Alumno>();
    public List<Alumno> listaInscritos = new List<Alumno>();
    public List<Alumno> listaInscritosPagaron = new List<Alumno>();

    public AsignacionModel(ILogger<AsignacionModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        try
        {
            String connectionString = "Server=(local);Database=EstudiantesDB;User Id=sa;Password=Ce/danielonsql;";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                String sql;
                sql = "SELECT Id_Estudiante FROM T_Asignados";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Alumno alumno = new Alumno();
                            alumno.alumnoId = "" + reader.GetString(0);
                            listaAsignados.Add(alumno);
                        }
                    }
                }

                sql = "SELECT Id_Estudiante FROM T_Inscrito WHERE [Pago] != N'0'";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Alumno alumno = new Alumno();
                            alumno.alumnoId = "" + reader.GetString(0);
                            listaInscritosPagaron.Add(alumno);
                        }
                    }
                }

                sql = "SELECT Id_Estudiante FROM T_Inscrito WHERE [Pago] = N'0'";
                using (SqlCommand command = new SqlCommand(sql, conn))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Alumno alumno = new Alumno();
                            alumno.alumnoId = "" + reader.GetString(0);
                            listaInscritos.Add(alumno);
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

public class Alumno
{
    public String alumnoId;
    public String estado; // aceptado, rechazado
}

