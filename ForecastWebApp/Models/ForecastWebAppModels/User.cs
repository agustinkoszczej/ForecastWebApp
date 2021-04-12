using System.ComponentModel.DataAnnotations;

namespace ForecastWebApp.Models.ForecastWebAppModels
{
    public class User
    {
        [Required(ErrorMessage = "Debes ingresar un nombre de usuario!")]
        [StringLength(20, MinimumLength = 2, ErrorMessage = "Ingrese entre 2-20 caracteres!")]
        [Display(Name = "Usuario")]
        public string Username { get; set; }
        [Required(ErrorMessage = "Debes ingresar una contraseña!")]
        [StringLength(20, MinimumLength = 2, ErrorMessage = "Ingrese entre 2-20 caracteres!")]
        [RegularExpression(@"^((?=.*[a-z])(?=.*[A-Z])(?=.*\\d)).+$")]
        [DataType(DataType.Password)]
        [Display(Name = "Contraseña")]
        public string Password { get; set; }
    }
}
