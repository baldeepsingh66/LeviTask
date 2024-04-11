using Dapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PropertyManagementDemo.Repositories
{
    public interface IRepository<T> where T : class
    {
        public Task<bool> OperationOnData(string procedureName, DynamicParameters parameters);
        Task<IEnumerable<T>> ReadAllData(string procedureName, DynamicParameters parameters);
        public Task<T> ReadData(string procedureName, DynamicParameters parameters);
    }
}
