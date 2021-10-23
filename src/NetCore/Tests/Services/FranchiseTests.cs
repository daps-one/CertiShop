using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;
using CertiShop.NetCore.Infraestructure.Common.Entities;
using CertiShop.NetCore.Services.Products;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

namespace CertiShop.NetCore.Tests.Services
{
    public class FranchiseTests : IClassFixture<WebApplicationFactory<Startup>>
    {
        private readonly HttpClient _httpClient;
        private const string BASE_URL = "api/franchises";

        public FranchiseTests(WebApplicationFactory<Startup> _factory) => _httpClient = _factory.CreateClient();

        [Fact]
        public async Task TestGetAllFranchises()
        {
            Assert.Equal(true, (await GetFranchises()) != null);
        }
        private async Task<IEnumerable<Franchise>> GetFranchises()
        {
            return await Get<IEnumerable<Franchise>>(BASE_URL);
        }
        
        private async Task<T> Get<T>(string requestUri)
        {
            var response = await _httpClient.GetAsync(requestUri);
            var Franchises = await response.Content.ReadAsStringAsync();
            if (response.StatusCode != HttpStatusCode.OK)
                return default;

            return JsonSerializer.Deserialize<T>(Franchises, new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });
        }
    }
}