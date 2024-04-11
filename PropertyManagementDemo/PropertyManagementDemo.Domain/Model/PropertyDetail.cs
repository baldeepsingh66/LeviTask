using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PropertyManagementDemo.Domain.Model
{
    public class PropertyDetail
    {
        public int Id { get; set; }
        public int PropertyManagerId { get; set; }
        public string PropertyName { get; set; }
        public string PropertyArea { get; set; }
        public int PropertyRentalPrice {  get; set; }
        public int PropertyCurrentValue {  get; set; }
        public bool PropertyOccupied { get; set; }
    }
}
