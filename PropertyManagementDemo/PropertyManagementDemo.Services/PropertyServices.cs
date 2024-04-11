using Dapper;
using PropertyManagementDemo.Domain.Model;
using PropertyManagementDemo.Repositories;
using PropertyManagementDemo.Services.IService;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PropertyManagementDemo.Services
{
    public class PropertyServices : IPropertyServices
    {
        private readonly IRepository<PropertyDetail> _repository;
        public PropertyServices(IRepository<PropertyDetail> repository)
        {
            _repository = repository;
        }

        public async Task<List<PropertyDetail>> GetAllProperty()
        {
            var storeProcedureName = "SP_GetPropertyDetails";
            var parameters = new DynamicParameters();
            parameters.Add("type", "all", DbType.String);
            return _repository.ReadAllData(storeProcedureName, parameters).Result.ToList();
        }

        public async Task<List<PropertyDetail>> GetOccupiedProperty()
        {
            var storeProcedureName = "SP_GetPropertyDetails";
            var parameters = new DynamicParameters();
            parameters.Add("type", "occupied", DbType.String);
            return _repository.ReadAllData(storeProcedureName, parameters).Result.ToList();
        }

        public async Task<PropertyDetail> GetLowestProperty()
        {
            var storeProcedureName = "SP_GetPropertyDetails";
            var parameters = new DynamicParameters();
            parameters.Add("type", "lowest", DbType.String);
            return await _repository.ReadData(storeProcedureName, parameters);
        }

        public async Task<bool> UpdatePropertyStatus(int id)
        {
            var storeProcedureName = "SP_UpdatePropertyOccupied";
            var parameters = new DynamicParameters();
            parameters.Add("id", id, DbType.Int32);
            await _repository.OperationOnData(storeProcedureName, parameters);
            return true;
        }

        public async Task<bool> UpdatePropertyManager(int id, string manager)
        {
            var storeProcedureName = "SP_UpdatePropertyManager";
            var parameters = new DynamicParameters();
            parameters.Add("id", id, DbType.Int32);
            parameters.Add("propertymanager", manager, DbType.String);
            await _repository.OperationOnData(storeProcedureName, parameters);
            return true;
        }

        public async Task<bool> UpdatePropertyCurrentValue(int id, int currentValue)
        {
            var storeProcedureName = "SP_UpdatePropertyCurrentvalue";
            var parameters = new DynamicParameters();
            parameters.Add("id", id, DbType.Int32);
            parameters.Add("currentvalue", currentValue, DbType.Int32);
            await _repository.OperationOnData(storeProcedureName, parameters);
            return true;
        }

    }
}
