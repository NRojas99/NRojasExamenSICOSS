using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;

namespace BL
{
    public class Usuario
    {
        public static ML.Result AddEF(ML.Usuario usuario)
        {
            ML.Result result = new ML.Result();
            try
            {
                using (DL.ExamenSICOSSEntities context = new DL.ExamenSICOSSEntities()) 
                {
                    var query = context.AddUsuario(usuario.Username, usuario.Password);

                    if (query != null)
                    {
                        result.Correct = true;
                        //result.Object = Convert.ToInt32(IdUsuario.Value);
                    }
                    else
                    {
                        result.Correct = false;
                    }
                }
                result.Correct = true;
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.Ex = ex;
            }
            return result;
        }

        public static ML.Result GetUserName(string UserName)
        {
            ML.Result result = new ML.Result();
            try
            {
                using(DL.ExamenSICOSSEntities context= new DL.ExamenSICOSSEntities()) 
                {
                    var query = context.GetUsername(UserName).ToList();
                    result.Objects = new List<Object>();
                    if (query != null)
                    {
                        foreach (var item in query)
                        {
                            ML.Historial historial = new ML.Historial();
                            historial.Usuario = new ML.Usuario();

                            historial.Usuario.IdUsuario = item.IdUsuario;
                            historial.Usuario.Username = item.UserName;
                            historial.Usuario.Password = item.Password;

                            result.Object = historial;

                        }
                        result.Correct = true;
                    }
                    else
                    {
                        result.Correct = false;
                        result.ErrorMessage = "No se encontro Registros";
                    }
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.ErrorMessage = ex.Message;
                result.Ex = ex;
            }
            return result;
        }
        public static ML.Result IdUsuarioGetNumero(ML.Historial historial)
        {
            ML.Result result = new ML.Result();
            try
            {
                using (DL.ExamenSICOSSEntities context = new DL.ExamenSICOSSEntities())
                {
                    var query = context.IdUsuarioGetNumero(historial.Usuario.IdUsuario).ToList();
                    result.Objects = new List<Object>();
                    if (query != null)
                    {
                        foreach (var item in query)
                        {
                            ML.Historial historial2 = new ML.Historial();
                            historial2.Usuario = new ML.Usuario();

                            historial2.Usuario.IdUsuario = item.IdUsuario;
                            historial2.SuperDigito = new ML.SuperDigito();
                            historial2.SuperDigito.Numero = (int)item.Numero;
                            historial2.SuperDigito.IdSuperDigito = item.IdSuperDigito;  

                            if (historial.SuperDigito.Numero == historial2.SuperDigito.Numero)
                            {
                                result.Object =(historial2);
                                result.Correct = true;
                            }

                        }
                    }
                    else
                    {
                        result.Correct = false;
                        result.ErrorMessage = "No se encontro Registros";
                    }
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.ErrorMessage = ex.Message;
                result.Ex = ex;
            }
            return result;
        }

    }
}
