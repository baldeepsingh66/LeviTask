using PropertyManagementDemo.Domain.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PropertyManagementDemo.Services.IService
{
    public interface IPropertyServices
    {
        Task<List<PropertyDetail>> GetAllProperty();
        Task<List<PropertyDetail>> GetOccupiedProperty();
        Task<PropertyDetail> GetLowestProperty();
        Task<bool> UpdatePropertyStatus(int id);
        Task<bool> UpdatePropertyManager(int id, string manager);
        Task<bool> UpdatePropertyCurrentValue(int id, int currentValue);
    }
}
