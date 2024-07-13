using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ComedorUniversitario.Pages.Admins;

public class AbrirCuposModel : PageModel
{
    private readonly ILogger<AbrirCuposModel> _logger;

    public AbrirCuposModel(ILogger<AbrirCuposModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}

