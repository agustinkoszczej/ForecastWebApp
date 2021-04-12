using ForecastWebApp.Models.ForecastWebAppModels;
using ForecastWebApp.OpenWeatherMapModels;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Net.Http;
using System.Threading.Tasks;

namespace ForecastWebApp.Services
{
    public class OpenWeatherMapService : IWeatherService
    {
        HttpClient _client;
        IConfiguration _configuration;

        public OpenWeatherMapService(IConfiguration configuration)
        {
            this._client = new HttpClient();
            this._configuration = configuration;
        }
        public async Task<WeatherResponse> GetWeatherData(SearchWeather search)
        {
            WeatherResponse weatherData = null;
            string openweatherApiKey = _configuration.GetSection("OpenWeatherAPIKey").Value;
            try
            {     
                var response = await _client.GetAsync($"http://api.openweathermap.org/data/2.5/forecast?q={search.City},{search.Country}&cnt={search.numberDays}&units=metric&APPID={openweatherApiKey}");
                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    weatherData = JsonConvert.DeserializeObject<WeatherResponse>(content);
                }
            }
            catch(Exception ex)
            {
                throw (ex);
            }

            return weatherData;
        }
    }
}
