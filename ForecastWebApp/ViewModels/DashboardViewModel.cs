using ForecastWebApp.Models.ForecastWebAppModels;
using ForecastWebApp.OpenWeatherMapModels;

namespace ForecastWebApp.ViewModels
{
    public class DashboardViewModel
    {
        public SearchWeather Search { get; set; }
        public WeatherResponse Weather { get; set; }
        
    }
}
