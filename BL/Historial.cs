using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class Historial
    {
        public static ML.Result AddEF(ML.Historial historial)
        {
            ML.Result result = new ML.Result();
            try
            {
                using (DL.ExamenSICOSSEntities context = new DL.ExamenSICOSSEntities())
                {
                    var query = context.AddHistorial(historial.Usuario.IdUsuario, historial.SuperDigito.IdSuperDigito);

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
        public static ML.Result IdUsuarioGetHistorial(int IdUsuario)
        {
            ML.Result result = new ML.Result();
            try
            {
                using (DL.ExamenSICOSSEntities context = new DL.ExamenSICOSSEntities())
                {
                    var query = context.IdUsuarioGetHistorial(IdUsuario).ToList();
                    result.Objects = new List<Object>();
                    if (query != null)
                    {
                        foreach (var item in query)
                        {
                            ML.Historial historial = new ML.Historial();

                            historial.IdHistorial = item.IdHistorial;
                            historial.Usuario = new ML.Usuario();
                            historial.Usuario.IdUsuario = item.IdUsuario;
                            historial.SuperDigito = new ML.SuperDigito();
                            historial.SuperDigito.IdSuperDigito = item.IdSuperDigito;
                            historial.SuperDigito.Numero = (int)item.Numero;
                            historial.SuperDigito.Resultado = (int)item.Resultado;
                            historial.SuperDigito.Fecha = (DateTime)item.Fecha;
                            result.Objects.Add(historial);

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
        public static ML.Result Delete(int IdUsuario)
        {
            ML.Result result = new ML.Result();
            try
            {
                using (DL.ExamenSICOSSEntities context= new DL.ExamenSICOSSEntities())
                {
                    var query = context.DeleteHistorialIdUsuario(IdUsuario);
                    if (query >= 1)
                    {
                        result.Correct = true;
                    }
                    else
                    {
                        result.Correct = false;
                        result.ErrorMessage = "Error al borrar Historial";
                    }
                }
            }
            catch (Exception ex)
            {
                result.Correct = false;
                result.Ex = ex;
            }
            return result;
        }
    }
}
