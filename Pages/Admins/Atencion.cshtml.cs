using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using ComedorUniversitario.Models;

namespace ComedorUniversitario.Pages.Admins;

public class AtencionModel : PageModel
{
    private readonly ILogger<AtencionModel> _logger;
    private readonly MyDbContext _context;

    // [BindProperty]
    // public <Type> <Name> {get; set;}

    public AtencionModel(ILogger<AtencionModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
    }

    public IActionResult OnPost()
    {
        // _context.<DbName>.Add(Name)
        // _context.SaveChanges();
        return RedirectToPage();
    }
}

