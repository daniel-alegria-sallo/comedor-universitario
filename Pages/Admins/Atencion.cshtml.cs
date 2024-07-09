using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace ComedorUniversitario.Pages.Admins;

public class AtencionModel : PageModel
{
    private readonly ILogger<AtencionModel> _logger;

    public AtencionModel(ILogger<AtencionModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }
}

