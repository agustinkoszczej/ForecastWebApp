using System.ComponentModel.DataAnnotations;

namespace ForecastWebApp.Models.ForecastWebAppModels
{
    public class SearchWeather
    {
        [Required(ErrorMessage = "Debes ingresar un país!")]
        [StringLength(20, MinimumLength = 2, ErrorMessage = "Ingrese entre 2-20 caracteres!")]
        [Display(Name = "País")]
        public string Country { get; set; } = "Argentina";
        [Required(ErrorMessage = "Debes ingresar una ciudad!")]
        [StringLength(20, MinimumLength = 2, ErrorMessage = "Ingrese entre 2-20 caracteres!")]
        [Display(Name = "Ciudad")]
        public string City { get; set; } = "Buenos Aires";
        public int numberDays { get; set; } = 6;
    }
}
