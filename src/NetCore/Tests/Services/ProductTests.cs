using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Text.Json;
using System.Threading.Tasks;
using CertiShop.NetCore.Infraestructure.Common.Entities;
using CertiShop.NetCore.Services.Products;
using CertiShop.NetCore.Services.Products.Controllers;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.TestHost;
using Microsoft.Extensions.Configuration;
using Xunit;

namespace CertiShop.NetCore.Tests.Services
{
    public class ProductTests : IClassFixture<WebApplicationFactory<Startup>>
    {
        private readonly HttpClient _httpClient;
        private const string BASE_URL = "api/products";

        public ProductTests(WebApplicationFactory<Startup> _factory) => _httpClient = _factory.CreateClient();

        [Fact]
        public async Task TestGetAllProducts()
        {
            Assert.Equal(true, (await GetProducts()) != null);
        }

        [Fact]
        public async Task TestGetProduct()
        {
            Assert.Equal(true, (await GetProduct()) != null);
        }

        [Fact]
        public async Task TestAddProductToCart()
        {
            Assert.Equal(true, (await AddProductToCart()) != null);
        }

        private async Task<IEnumerable<Product>> GetProducts()
        {
            return await Get<IEnumerable<Product>>(BASE_URL);
        }
        
        private async Task<Product> GetProduct()
        {
            return await Get<Product>(BASE_URL + "/2");
        }

        private async Task<Product> AddProductToCart()
        {
            return await Get<Product>(BASE_URL + "/addToCart/2");
        }

        private async Task<T> Get<T>(string requestUri)
        {
            var response = await _httpClient.GetAsync(requestUri);
            var products = await response.Content.ReadAsStringAsync();
            if (response.StatusCode != HttpStatusCode.OK)
                return default;

            return JsonSerializer.Deserialize<T>(products, new JsonSerializerOptions
            {
                PropertyNameCaseInsensitive = true
            });
        }
    }
}