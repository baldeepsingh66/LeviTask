using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using PropertyManagementDemo.Services.IService;

namespace PropertyManagementDemo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PropertyController : ControllerBase
    {
        private readonly IPropertyServices _propertyServices;
        public PropertyController(IPropertyServices propertyServices)
        {
            _propertyServices = propertyServices;
        }

        [HttpGet("GetAllProperty")]
        public async Task<IActionResult> GetGetAllProperty()
        {
            return Ok(await _propertyServices.GetAllProperty());
        }

        [HttpGet("GetLowestProperty")]
        public async Task<IActionResult> GetLowestProperty()
        {
            return Ok(await _propertyServices.GetLowestProperty());
        }

        [HttpGet("GetOccupiedProperty")]
        public async Task<IActionResult> GetOccupiedProperty()
        {
            return Ok(await _propertyServices.GetOccupiedProperty());
        }

        [HttpPost("UpdatePropertyStatus/{id}")]
        public async Task<IActionResult> UpdatePropertyStatus(int id)
        {
            return Ok(await _propertyServices.UpdatePropertyStatus(id));
        }

        [HttpPost("UpdatePropertyManager/{id}/{manager}")]
        public async Task<IActionResult> UpdatePropertyManager(int id, string manager)
        {
            return Ok(await _propertyServices.UpdatePropertyManager(id, manager));
        }

        [HttpPost("UpdatePropertyCurrentValue/{id}/{currentValue}")]
        public async Task<IActionResult> UpdatePropertyCurrentValue(int id, int currentValue)
        {
            return Ok(await _propertyServices.UpdatePropertyCurrentValue(id, currentValue));
        }
    }
}
