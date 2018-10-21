console.log("%cImportante! %cEsta ventana es para desarrollo avanzado, Necesitas conocimientos en JavaScript, Bootstrap, jQuery, VUE y PeerJS.\n Si no sabes que estas haciendo te recomendamos cerrarla ya que pueden estan en riesgo tus datos.", "color: red; font-size:25px;", "color: blue; font-size:12px;");

const instance = axios.create({
  baseURL: location.pathname + 'api/api.php',
  timeout: 20000,
  headers: {'X-Custom-Header': 'foobar'}
});

function descriptionsErrors(e){
    switch(e){
        case "pageNull":
            return "pagina no detectada."
        default:
            return "Error no detectado."
            break;
    }
};

function validateErrors(e){
    var error = {
        error: true,
        type: e,
        description: descriptionsErrors(e),
    };
    return error;
}

function validateData(data){
    if (!data.includes) { data.includes = ''; }
    if (data.page != null) {
        return data;
    } else {
        throw "pageNull";
    }
};

var InventoryIT = {};
InventoryIT.connectStatus = 0;
InventoryIT.api = function(data, callback){
    data = validateData(data); // La función puede arrojar una excepción
  
    instance.get('/' + data.page, 
    {
        params: {
          transform: 'true',
          includes: data.includes
        }
    }
    )
    .then(function (response) {
        var r = {};
        if(response.status == 200){ r.error = false; }
        else{ r.error = true; }
        r.data = response.data;
        return callback(r);
    })
    .catch(function (error) {
        console.log(error);
    });
};



InventoryIT.BETA = function(data, callback){
    try { // instrucciones a probar
        data = validateData(data); // La función puede arrojar una excepción
      
        instance.get('/' + data.page, 
        {
            params: {
              transform: 'true',
              includes: data.includes
            }
        }
        )
        .then(function (response) {
            return callback(response);
        })
        .catch(function (error) {
            console.log(error);
        });
    }
    catch (e) {
      data = "unknown";
      return callback(validateErrors(e));
    }
};

/*
InventoryIT.api({
    
}, function(r){
    if(r.error == false){
        console.log(r)
    }else{
        console.log('Ocurrio un problema');
        console.log(r)
    }
    
});

/----- Reporte Basico ------/
InventoryIT.api({
    page: 'categories',
    includes: 'posts'
}, function(r){
    if(r.error == false){
        console.log(r)
    }else{
        console.log('Ocurrio un problema');
        console.log(r)
    }
    
});
*/