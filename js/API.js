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

function validateResultInstance(response){
    var ret = {
        error:true,
        data:null
    };
    if (!response.status) {
        throw "responseInvalid";
    }
    else {
        if(response.status == 200) {
            ret.error = false;
            ret.data = response.data;
        }
    };
    return ret;
};

var InventoryIT = {};
InventoryIT.connectStatus = 0;
InventoryIT.api = function(data, callback){
    data = validateData(data); // La función puede arrojar una excepción
  
    instance.get('/' + data.page, 
    {
        params: {
          transform: 'true',
          include: data.includes
        }
    }
    )
    .then(function (response) {
        var r = validateResultInstance(response);
        return callback(r);
    })
    .catch(function (error) {
        console.log(error);
    });
};
/*
InventoryIT.api({
    
}, function(r){
    if(r.error == false){
        console.log(r)
    }else{
        console.log('Ocurrio un problema');
        console.log(r)
        console.log(validateErrors(r))
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
        console.log(validateErrors(r))
    }
    
});
*/