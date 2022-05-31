using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PL.Controllers
{
    public class UsuarioController : Controller
    {
        [HttpGet]
        public ActionResult Form()
        {
            ML.Usuario usuario = new ML.Usuario();
            return View(usuario);
        }

        [HttpPost]
        public ActionResult Form(ML.Usuario usuario)
        {
            ML.Result result = new ML.Result();

            result = BL.Usuario.AddEF(usuario);
            if (result.Correct)
            {
                return RedirectToAction("Login", "Login");
            }
            else
            {
                return RedirectToAction("Form","Usuario");
            }
        }

    }
}
