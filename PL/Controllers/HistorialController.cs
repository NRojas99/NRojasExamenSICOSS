using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PL.Controllers
{
    public class HistorialController : Controller
    {
        [HttpGet]
        public ActionResult His(int? id, int? idS)
        {
            ML.Historial historial = new ML.Historial();

            ML.Result result = BL.Historial.IdUsuarioGetHistorial(id.Value);

            if (result.Correct)
            {

                historial.Historiales = result.Objects;
                historial.Usuario = new ML.Usuario();
                historial.Usuario.IdUsuario = id.Value;

                historial.SuperDigito = new ML.SuperDigito();
                ML.SuperDigito superDigito = new ML.SuperDigito();
                if (idS != 0)
                {
                    ML.Result result2 = BL.SuperDigito.IdUsuarioGetResultado(idS.Value);
                    superDigito = ((ML.SuperDigito)result2.Object);
                    historial.SuperDigito.Numero = superDigito.Numero;
                    historial.SuperDigito.Resultado = superDigito.Resultado;

                }
                return View(historial);
            }
            else
            {
                ViewBag.Message = "Ocurrio un error al obtener la informacion" + result.ErrorMessage;
                return PartialView("ValidationModal");
            }

        }

        [HttpPost]
        public ActionResult His(ML.Historial historial)
        {
            historial.SuperDigito.Numero2 = historial.SuperDigito.Numero;
            do
            {
                if (historial.SuperDigito.Numero2 < 10 && historial.SuperDigito.Numero2 > 0)
                {
                    ML.Result resultN2 = BL.Usuario.IdUsuarioGetNumero(historial);
                    if (resultN2.Correct)
                    {
                        ML.Historial his = new ML.Historial();
                        his.SuperDigito= new ML.SuperDigito();
                        historial= ((ML.Historial)resultN2.Object);

                        his.SuperDigito.Numero =historial.SuperDigito.Numero;
                        his.SuperDigito.IdSuperDigito =historial.SuperDigito.IdSuperDigito;  

                        ML.Result resultF = BL.SuperDigito.UpdateFecha(his);
                        if (resultF.Correct)
                        {
                            return RedirectToAction("His", "Historial", new { id = historial.Usuario.IdUsuario, idS = historial.SuperDigito.IdSuperDigito });
                        }
                    }
                    else
                    {
                        historial.SuperDigito.Resultado = historial.SuperDigito.Numero2;
                        ML.Result result = BL.SuperDigito.AddEF(historial.SuperDigito);
                        if (result.Correct)
                        {
                            historial.SuperDigito.IdSuperDigito = ((int)result.Object);

                            ML.Result result2 = BL.Historial.AddEF(historial);

                            //return View(historial);*/
                            return RedirectToAction("His", "Historial", new { id = historial.Usuario.IdUsuario, idS = historial.SuperDigito.IdSuperDigito });
                        }
                    }
                }
                else
                {
                    string dig = Convert.ToString(historial.SuperDigito.Numero2);

                    char[] array = dig.ToCharArray();
                    int contador = 0;


                    for (int i = 0; i < array.Length; i++)
                    {

                        char valor1 = (char)array[i];
                        string valor2 = Convert.ToString(valor1);
                        int valor = Convert.ToInt32(valor2);
                        contador = contador + valor;
                        historial.SuperDigito.Numero2 = contador;
                        historial.SuperDigito.Resultado = historial.SuperDigito.Numero2;
                    }
                }
            } while (historial.SuperDigito.Resultado >= 10);

            ML.Result resultN1 = BL.Usuario.IdUsuarioGetNumero(historial);
            if (resultN1.Correct)
            {
                ML.Historial his = new ML.Historial();
                his.SuperDigito = new ML.SuperDigito();
                historial = ((ML.Historial)resultN1.Object);

                his.SuperDigito.Numero = historial.SuperDigito.Numero;
                his.SuperDigito.IdSuperDigito = historial.SuperDigito.IdSuperDigito;

                ML.Result resultF = BL.SuperDigito.UpdateFecha(his);
                if (resultF.Correct)
                {
                    return RedirectToAction("His", "Historial", new { id = historial.Usuario.IdUsuario, idS = historial.SuperDigito.IdSuperDigito });
                }
            }
            else
            {
                historial.SuperDigito.Resultado = historial.SuperDigito.Numero2;
                ML.Result result = BL.SuperDigito.AddEF(historial.SuperDigito);
                if (result.Correct)
                {
                    historial.SuperDigito.IdSuperDigito = ((int)result.Object);

                    ML.Result result2 = BL.Historial.AddEF(historial);

                    //return View(historial);*/
                    return RedirectToAction("His", "Historial", new { id = historial.Usuario.IdUsuario, idS = historial.SuperDigito.IdSuperDigito });
                }
            }
            return RedirectToAction("His", "Historial", new { id = historial.Usuario.IdUsuario, idS = historial.SuperDigito.IdSuperDigito });
        }

        public ActionResult Delete(int IdUsuario)
        {
            ML.Result result = BL.Historial.Delete(IdUsuario);
            if (result.Correct)
            {
                return RedirectToAction("His", "Historial", new { id = IdUsuario, idS = 0 });
            }
            return RedirectToAction("His", "Historial", new { id = IdUsuario, idS = 0 });
        }
    }
}
