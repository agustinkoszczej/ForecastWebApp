using ForecastWebApp.Models.ForecastWebAppModels;
using ForecastWebApp.OpenWeatherMapModels;
using System.Threading.Tasks;

namespace ForecastWebApp.Services
{
    public interface IWeatherService
    {
        Task<WeatherResponse> GetWeatherData(SearchWeather searchParameters);
    }
}
