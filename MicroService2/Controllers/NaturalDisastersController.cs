using System.Xml.Linq;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace MyWebApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class NaturalDisastersController : ControllerBase
    {
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            // Create an HttpClient instance
            using var client = new HttpClient();

            // Fetch the XML data from the URL
            var xmlString = await client.GetStringAsync("https://www.gdacs.org/xml/rss_24h.xml");

            // Convert the XML to JSON
            var xml = XDocument.Parse(xmlString);
            var json = JsonConvert.SerializeXNode(xml);

            // Return the JSON response
            //Console.WriteLine(json);
            return Content(json, "application/json");

        }
    }
}
