using Microsoft.EntityFrameworkCore;

namespace ComedorUniversitario.Models;

public class MyDbContext : DbContext
{
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
    }
}
