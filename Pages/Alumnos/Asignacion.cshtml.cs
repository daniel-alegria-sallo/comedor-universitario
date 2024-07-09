using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ComedorUniversitario.Pages.Alumnos;

public class AsignacionModel : PageModel
{
    private readonly ILogger<AsignacionModel> _logger;

    public AsignacionModel(ILogger<AsignacionModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}

