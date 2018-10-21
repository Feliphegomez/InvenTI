const reportBasic = Vue.component('reportBasic', {
    methods: {
        loadLastReportBasic(){
            var self = this;
            InventoryIT.api({
                page: 'categories',
                includes: 'posts'
            }, function(r){
                if(r.error == false){
                    console.log(r);
                    
                    var target = r.data.categories;
                    for (var k in target){
                        if (typeof target[k] !== 'function') {
                            console.log(target[k]);
                            self.$parent.lastReportBasic.push(target[k]);
                        }
                    }
                }else{
                    console.log('Ocurrio un problema');
                    console.log(r)
                    console.log(validateErrors(r))
                }
            });
        }
    },
    created(){
		var self = this;
    },
    mounted(){
		var self = this;
        self.loadLastReportBasic();
    },
	template: `
        <div>
            <div class="col-sm-12">
                <h2>Reporte Básico</h2>
                <div class="col-sm-6" v-for="category in $parent.lastReportBasic">
                    <h2>{{ category.name }}</h2>
                    <table>
                        <tr v-for="post in category.posts">
                            <td>{{ post.id }}</td>
                            <td>{{ post.content }}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
	`
});

const homePage = Vue.component('homePage', {
    methods: {
    },
    mounted(){
		var self = this;
    },
	template: `
        <div>
            <div class="col-sm-12">
                Bienvenido
            </div>
        </div>
	`
});

const routes = [
	{ path: '/', name: 'Home', component: homePage },
	{ path: '/reportBasic', name: 'reportBasic', component: reportBasic },
];

const router = new VueRouter({
  routes
})


var Principal = new Vue({
	el: '#app',
	router: router,
	components: {
        'homePage': homePage
	},
	data: {
		connect: false,
		lastReportBasic: [],
	},
	created() {
		var self = this;
	},
	mounted() {
		var self = this;
	},
	methods: {
	},
	beforeCreate:function(){
		var self = this;
	},
	template: `<div>
		<header>
			<nav class="navbar navbar-expand-md navbar-dark sticky-top bg-secondary">
                <router-link tag="a" class="navbar-brand" to="/">deMedallo</router-link>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
				<div class="collapse navbar-collapse" id="navbarCollapse">
					<form class="navbar-nav mr-auto form-inline" method="search" action="javascript:false; " submit="nodeSearch">
						<input class="form-control mr-sm-2" type="text" placeholder="Agregar nodo" aria-label="" value=""  name="q" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}" />
						<!--<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Agregar</button> -->
					</form>  
					<ul class="navbar-nav mt-2 mt-md-0">
                        <router-link tag="li" class="nav-item" to="/"><a class="nav-link"><i class="fa fa-home"></i> Inicio</a></router-link>
                        <router-link tag="li" class="nav-item" to="/reportBasic"><a class="nav-link"><i class="fa fa-home"></i> Reporte Básico</a></router-link>
                              
						<li class="nav-item"><a class="nav-link" v-if="connect == true">Conectado</a></li>
                        
						<li class="nav-item" v-if="connect == true"><a class="nav-link"><div class="led-green"></div></a></li>
						<li class="nav-item" v-if="connect == false"><a class="nav-link"><div class="led-gray"></div></a></li>
                        
                        
                        <li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fa fa-ellipsis-v"></i>
                            </a>
							<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" click="clearLogs"><i class="fa fa-eraser"></i> Limpiar Logs</a>                                
							</div>
						</li>
                        <li class="nav-item dropdown" v-if="connect == false">
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Ingresar
                            </a>
							<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" click="clearLogs"><i class="fa fa-user"></i> Usuario</a>                                
                                <a class="dropdown-item" click="clearLogs"><i class="fa fa-eraser"></i> Contraseña</a>                                
							</div>
						</li>
					</ul>
				</div>
			</nav>
		</header>

		<main role="main">
            <div class="content">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-12">
                            <transition>
                                <keep-alive>
                                    <router-view></router-view>
                                </keep-alive>
                            </transition>
                        </div>
                    </div>
                </div>
            </div>
		</main>
	</div>`
});