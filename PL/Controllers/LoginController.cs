using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace PL.Controllers
{
    public class LoginController : Controller
    {
       [HttpGet]
        public ActionResult Login()
        {
            ML.Usuario usuario = new ML.Usuario();
            return View(usuario);
        }
       [HttpPost]
        public ActionResult Login(ML.Usuario usuario)
        {
     
            ML.Result result = BL.Usuario.GetUserName(usuario.Username);
            if (result.Correct)
            {
                ML.Historial historial1 = new ML.Historial();   
                historial1 = (ML.Historial)result.Object;//Unboxing de mi ML.Usuario

                if (usuario.Password == historial1.Usuario.Password)
                {
                    return RedirectToAction("His", "Historial", new {id= historial1.Usuario.IdUsuario,idS=0});
                }
                else
                {
                    return RedirectToAction("Login", "Login");
                }
            }
            else
            {
                return RedirectToAction("Login", "Login");
            }
        }
    }
}
