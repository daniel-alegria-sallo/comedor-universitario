using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ComedorUniversitario.Pages.Alumnos;

public class InscripcionModel : PageModel
{
    private readonly ILogger<InscripcionModel> _logger;

    public InscripcionModel(ILogger<InscripcionModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}

