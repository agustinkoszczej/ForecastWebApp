using ForecastWebApp.Models;
using ForecastWebApp.Models.ForecastWebAppModels;
using ForecastWebApp.OpenWeatherMapModels;
using ForecastWebApp.Services;
using ForecastWebApp.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;

namespace ForecastWebApp.Controllers
{
    public class ForecastWebAppController : Controller
    {
        private readonly ILogger<ForecastWebAppController> _logger;
        private readonly IWeatherService _weatherService;

        public ForecastWebAppController(IWeatherService weatherService, ILogger<ForecastWebAppController> logger)
        {
            _weatherService = weatherService;
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login()
        {
            return RedirectToAction("Dashboard", "ForecastWebApp", new SearchWeather());
        }
        public IActionResult Dashboard(SearchWeather search)
        {
            WeatherResponse weatherResponse = _weatherService.GetWeatherData(search).Result;
            DashboardViewModel viewModel = new DashboardViewModel();
            viewModel.Search = search;
            viewModel.Weather = weatherResponse;
            return View(viewModel);
        }
    }
}