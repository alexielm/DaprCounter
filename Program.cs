using System;
using System.Threading.Tasks;
using Dapr.Client;

namespace DaprCounter
{
    class Program
    {
        static async Task Main(string[] args)
        {
            const string storeName = "redis-state";
            const string key = "counter";

            var daprClient = new DaprClientBuilder().Build();
            var counter = await daprClient.GetStateAsync<int>(storeName, key);

            while (true)
            {
                Console.WriteLine($"Counter = {counter++}");

                await daprClient.SaveStateAsync(storeName, key, counter);
                await Task.Delay(1000);
            }
        }
    }
}