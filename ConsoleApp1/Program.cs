using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            ML.Historial historial = new ML.Historial();
            historial.SuperDigito = new ML.SuperDigito();
            historial.SuperDigito.Numero = 555;

            do
            {
                if (historial.SuperDigito.Numero < 10 && historial.SuperDigito.Numero > 0)
                {
                    historial.SuperDigito.Resultado = historial.SuperDigito.Numero;
                    ML.Result result = BL.SuperDigito.AddEF(historial.SuperDigito);
                    if (result.Correct)
                    {
                        ML.Result result2 = BL.Historial.AddEF(historial);

                        //return View(historial);*/
                    }
                }
                else
                {
                    string dig = Convert.ToString(historial.SuperDigito.Numero);

                    char[] array = dig.ToCharArray();
                    int contador = 0;


                    for (int i = 0; i < array.Length; i++)
                    {
                        
                        char valor1 = (char)array[i];
                        string valor2 = Convert.ToString(valor1);   
                        int valor = Convert.ToInt32(valor2);
                        contador = contador + valor;

                        historial.SuperDigito.Numero = contador;
                    }
                }
            } while (historial.SuperDigito.Numero >= 10);

            Console.WriteLine(historial.SuperDigito.Numero);
            Console.ReadLine();
            //return View(historial);
        }
    }
}
