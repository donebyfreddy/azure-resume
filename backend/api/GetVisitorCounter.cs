using System.Net;
using System.Text.Json;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;


// Used for fetching data from CosmosDB

namespace Api.Function;

public class GetVisitorCounter
{
    private readonly ILogger<GetVisitorCounter> _logger;
    private readonly IVisitorCounterService _visitorCounterService;

    public GetVisitorCounter(ILogger<GetVisitorCounter> logger, IVisitorCounterService visitorCounterService)
    {
        _logger = logger;
        _visitorCounterService = visitorCounterService;
    }

    [Function("GetVisitorCounter")]
    public async Task<UpdatedCounter> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req,
    [CosmosDBInput("AzureResume","Counter", Connection = "CosmosDbConnectionString", Id = "1",
            PartitionKey = "1")] Counter counter)
    {


        counter = _visitorCounterService.IncrementCounter(counter);

        var response = req.CreateResponse(HttpStatusCode.OK);
        response.Headers.Add("Content-Type", "application/json; charset=utf-8");
        string jsonString = JsonSerializer.Serialize(counter);
        await response.WriteStringAsync(jsonString);

        return new UpdatedCounter
        {
            NewCounter = counter,
            HttpResponse = response
        };
    }
}