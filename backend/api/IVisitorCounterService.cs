namespace Api.Function;

// C# File for incrementing counter in CosmosDB

public interface IVisitorCounterService
{
    Counter IncrementCounter(Counter counter);
}

public class VisitorCounterService : IVisitorCounterService
{
    public Counter IncrementCounter(Counter counter)
    {
        // Increment and return the counter
        counter.Count += 1;
        return counter;
    }
}