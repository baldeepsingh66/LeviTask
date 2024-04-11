using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PropertyManagementDemo.Repositories
{
    public class Repository<T> : IRepository<T> where T : class
    {
        private readonly DbContext _dbContext;
        public Repository(DbContext dbContext) 
        {
            _dbContext= dbContext;
        }
        public async Task<bool> OperationOnData(string procedureName, DynamicParameters parameters)
        {
            using (var connection = _dbContext.CreateConnection())
            {
                await connection.ExecuteAsync(procedureName, parameters, commandType: CommandType.StoredProcedure);
                return true;
            }
        }

        public async Task<IEnumerable<T>> ReadAllData(string procedureName, DynamicParameters parameters)
        {
            using (var connection = _dbContext.CreateConnection())
            {
                return await connection.QueryAsync<T>(procedureName, parameters, commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<T> ReadData(string procedureName, DynamicParameters parameters)
        {
            using (var connection = _dbContext.CreateConnection())
            {
                return await connection.QueryFirstOrDefaultAsync<T>(procedureName, parameters, commandType: CommandType.StoredProcedure);
            }
        }

    }
}
