using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ComedorUniversitario.Pages.Alumnos;

public class ReportesModel : PageModel
{
    private readonly ILogger<ReportesModel> _logger;

    public ReportesModel(ILogger<ReportesModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}

