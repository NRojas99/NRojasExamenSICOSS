using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ML
{
    public class Historial
    {
        public int IdHistorial { get; set; }
        public ML.Usuario Usuario { get; set; }
        public ML.SuperDigito SuperDigito { get; set; }
        public List<object> Historiales { get; set; }
    }
}
