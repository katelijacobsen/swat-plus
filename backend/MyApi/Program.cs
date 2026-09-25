using ArangoDBNetStandard;
using ArangoDBNetStandard.Transport.Http;
using MyApi.Repositories;
// importerer namespaces for ikke skrive fulde navn
// using svarer til import i JavaScript / TypeScript

var builder = WebApplication.CreateBuilder(args);
// indlæser vores appsettings.json & laver en tom DI-container. 
// Det kommer til at fylde i de næste linjer 

var arango = builder.Configuration.GetSection("ArangoDB");
//Læses ArangoDB sektionen fra vores appsettings.json
// læser url værdien

builder.Services.AddSingleton(_ => new ArangoDBClient (
    HttpApiTransport.UsingBasicAuth(
        new Uri(arango["Url"]!),
        arango["Database"]!,
        arango["Username"]!,
        arango["Password"]!
    )));

// Vores container der opretter forbindelsen

builder.Services.AddScoped<IUserRepository, UserRepository>();
// efterspørgsel. AddScroped laver ny instans pr. HTTP request

builder.Services.AddControllers();
// MVC controllers er slået til .NET & finder selv alle klasser der arver fra ControllerBase

var app = builder.Build();

app.MapControllers();

app.Run();