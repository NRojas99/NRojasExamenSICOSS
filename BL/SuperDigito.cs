using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL
{
    public class SuperDigito
    {
        public static ML.Result AddEF(ML.SuperDigito superDigito)
        {
            ML.Result result = new ML.Result();
            try
            {
               using (DL.ExamenSICOSSEntities context = new DL.ExamenSICOSSEntities())
                {
                    ObjectParameter IdSuperDigito = new ObjectParameter("IdsuperDigito", typeof(int));
                    var query = context.AddSuperDigito(IdSuperDigito, superDigito.Numero, superDigito.Resultado);

                    if (query != null)
                    {
                        result.Correct = true;
                        result.Object = Convert.ToInt32(IdSuperDigito.Value);

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
        public static ML.Result IdUsuarioGetResultado(int IdSuperDigito)
        {
            ML.Result result = new ML.Result();
            try
            {
                using (DL.ExamenSICOSSEntities context = new DL.ExamenSICOSSEntities())
                {
                    var query = context.IdSuperDigitoGetResultado(IdSuperDigito).ToList();
                    result.Objects = new List<Object>();
                    if (query != null)
                    {
                        foreach (var item in query)
                        {
                            ML.SuperDigito superDigito= new ML.SuperDigito();
                            superDigito.IdSuperDigito = item.IdSuperDigito;
                            superDigito.Numero = (int)item.Numero;
                            superDigito.Resultado = (int)item.Resultado;
                            result.Object=(superDigito);

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
        public static ML.Result UpdateFecha(ML.Historial historial)
        {
            ML.Result result = new ML.Result();
            try
            {
                using (DL.ExamenSICOSSEntities context = new DL.ExamenSICOSSEntities())
                {
                    var query = context.UpdateFecha(historial.SuperDigito.Numero ,historial.SuperDigito.IdSuperDigito);
                    if (query > 0)
                    {
                        result.Correct = true;
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
                result.ErrorMessage = ex.Message;
                result.Ex = ex;
            }
            return result;
        }
    }
}
