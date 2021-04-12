using System.Collections.Generic;

namespace ForecastWebApp.OpenWeatherMapModels
{
    public class WeatherResponse
    {

        public City City { get; set; }
        public List<WeatherItem> List { get; set; }
    }
    public class City
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Country { get; set; }
        public Coord Coord { get; set; }
    }
    public class Coord
    {
        public float Lon { get; set; }
        public float Lat { get; set; }
    }
    public class WeatherItem
    {
        public Main Main { get; set; }
        public List<Weather> Weather { get; set; }
        public Wind Wind { get; set; }
    }

    public class Main
    {
        public float Temp { get; set; }
        public float Temp_Min { get; set; }
        public float Temp_Max { get; set; }
        public int Humidity { get; set; }
    }

    public class Weather
    {
        public string Main { get; set; }
        public string Description { get; set; }
        public string Icon { get; set; }
    }
    public class Wind
    {
        public float Speed { get; set; }
        public float Deg { get; set; }
    }
}
