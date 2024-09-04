using System.Text.Json;
using System.Text.RegularExpressions;
using DotNetEnv;

var builder = WebApplication.CreateBuilder(args);

Env.Load(); 

builder.Configuration.AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
builder.Services.AddHttpClient();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.MapPost("/generateQuiz", static async (QuizRequest request, HttpClient httpClient, IConfiguration config) =>
{
    try
    {
        string apiKey = Env.GetString("GEMINI_API_KEY")
            ?? throw new InvalidOperationException("Google API key is missing from configuration.");

        string apiUrl = $"https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key={apiKey}";
        int questions = 20;

        var requestContent = new
        {
            contents = new[]
            {
                new
                {
                    parts = new[]
                    {
                        new { text = "Generate " + questions + " quiz questions from this paragraph: " + request.Paragraph +
                        " After the question, add the answer" +
                        " In this format: \"1. Who painted the Mona Lisa? Leonardo Da Vinci\"" +
                        " Not true or false, just questions, don't add unnecessary introductions"}
                    }
                }
            }
        };

        var httpRequest = new HttpRequestMessage(HttpMethod.Post, apiUrl)
        {
            Content = new StringContent(JsonSerializer.Serialize(requestContent), System.Text.Encoding.UTF8, "application/json")
        };

        var response = await httpClient.SendAsync(httpRequest);
        response.EnsureSuccessStatusCode();

        var responseContent = await response.Content.ReadAsStringAsync();

        var responseJson = JsonDocument.Parse(responseContent);

        var text = responseJson.RootElement.GetProperty("candidates")[0]
            .GetProperty("content")
            .GetProperty("parts")[0]
            .GetProperty("text")
            .GetString();

        var result = new Dictionary<string, string>();
        var pattern = @"(\d+\.\s.*?\?)\s*\*\*(.*?)\*\*";
        var regex = new Regex(pattern, RegexOptions.Singleline);

        if (text != null)
        {
            foreach (Match match in regex.Matches(text))
            {
                if (match.Groups.Count >= 3)
                {
                    string question = match.Groups[1].Value.Trim();
                    string answer = match.Groups[2].Value.Trim();
                    result[question] = answer;
                }
            }
        }

        return Results.Ok(new { q_and_a = result });
    }
    catch (HttpRequestException httpEx)
    {
        return Results.Problem($"Request error: {httpEx.Message}");
    }
    catch (JsonException jsonEx)
    {
        return Results.Problem($"JSON parsing error: {jsonEx.Message}");
    }
    catch (Exception ex)
    {
        return Results.Problem($"An error occurred: {ex.Message}");
    }
})
.WithName("GenerateQuiz")
.WithOpenApi();

app.Run();

record QuizRequest(string Paragraph);
