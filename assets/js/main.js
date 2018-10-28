$(function () {
    $('.navbar-toggle-sidebar').click(function () {
        $('.navbar-nav').toggleClass('slide-in');
        $('.side-body').toggleClass('body-slide-in');
        $('#search').removeClass('in').addClass('collapse').slideUp(200);
    });

    $('#search-trigger').click(function () {
        $('.navbar-nav').removeClass('slide-in');
        $('.side-body').removeClass('body-slide-in');
        $('.search-input').focus();
    });
});
/* --------------------------------------------------------------------- */
var sessionPanel = {};

sessionPanel.checked = function(){
    var session = {
        active: false,
        isAdmin: false,
        nick: 'guest',
        hash: 'guest',
        nombre: 'Invitado'
    };

    if(!localStorage._sessionPanel){
    }else{
        var recu = JSON.parse(localStorage._sessionPanel);
        session.active = true;
        session.nick = recu.nick;
        session.hash = recu.hash;
        session.nombre = recu.nombre;
    }
    return session;
};

sessionPanel.clearSession = function(){
    delete localStorage._sessionPanel;
};


var api = axios.create({
  baseURL: '/apps/inventi/api/api.php/records'
});

var Forma2 = axios.create({
  baseURL: location.pathname + '../forma2/api/v1.0/'
});






var posts = null;

function findpost (postId) {
	if(posts==null){ return { id: 0, category_id: 0, location_id: 0, area_id: 0, content: '', user_id: 0 }; }
	return posts[findpostKey(postId)];
};

function findpostKey (postId) {
	if(posts==null){ return 0; }
		
	for (var key = 0; key < posts.length; key++) {
		if (posts[key].id == postId) {
			return key;
		}
	}
};



var articlesAdd = Vue.extend({
	template: '#articles-add',
	data: function () {
		return {
			optionsLocations: this.$parent.locations,
			optionsAreas: this.$parent.areas,
			optionsCategories: this.$parent.categories,
			optionsPeople: [],
			post: {
				content: 'Cedula: \n'+
						'Nombre: \n'+
						'User: \n'+
						'Cargo: \n'+
						'Piloto: Monteverde/Nobotia/MultiGYM \n'+
						'Estado: Activo/Inactivo/Licencia NR/Licencia Pat/Vacaciones \n'+
						'Supervisor: Cedula/Nombre \n'+
						'Rol: Conductor/Jardinero/Recepcionista \n'+
						'Ejecutivo_de_experiencia: Jefe del Jefe \n'+
						'Genero: MAS/FEM \n'+
						'Cuadrilla: Numero de la cuadrilla (Si aplica) \n', 
				category_id: 0,
				area_id: 0,
				location_id: 0,
				user_id: 0,
			}
		}
	},
	methods: {
		createpost: function() {
			var post = this.post;
			api.post('/articles',post).then(function (response) {
				post.id = response.data;
				console.log(post.id);
				router.push('/')
			}).catch(function (error) {
				console.log(error);
			});
		}
	},
    created(){
        var self = this;
        
        if(self.$parent.locations == null || self.$parent.areas == null || self.$parent.categories == null){ 
			router.push('/');
		}else{
			self.optionsLocations = self.$parent.locations;
			self.optionsAreas = self.$parent.areas;
			self.optionsCategories = self.$parent.categories;
			
			api.get('/users').then(function (response) {
				if(!response.data.records){
				}
				else{
					self.optionsPeople = response.data.records;
					console.log(self.optionsPeople);
				}
			}).catch(function (error) {
				console.log(error);
			});
		}
    }
});

var articlesDelete = Vue.extend({
  template: '#articles-delete',
  data: function () {
    return {post: findpost(this.$route.params.article_id)};
  },
  methods: {
    deletepost: function () {
		var post = this.post;
		api.delete('/articles/'+post.id).then(function (response) {
			console.log(response.data);
			router.push('/articles');
		}).catch(function (error) {
			console.log(error);
		});  
    }
  }
});

var articlesEdit = Vue.extend({
	template: '#articles-edit',
	data: function () {
		return {
			post: findpost(this.$route.params.article_id),
			selectedLocation: '',
			selectedArea: '',
			selectedCategory: '',
			selectedPeople: '',
			optionsLocations: this.$parent.locations,
			optionsAreas: this.$parent.areas,
			optionsCategories: this.$parent.categories,
			optionsPeople: [],
            serialNew: {
                name: '',
                total: 0,
                serial: '',
                notes: ''
            },
            serialEdit: {
                id: 0,
                name: '',
                total: 0,
                serial: '',
                notes: ''
            },
            commentNew: {
                article_id: 0,
                message: ''
            }
		};
	},
    created(){
        var self = this;
        self.selectedCategory = self.post.category_id.id;
        self.selectedLocation = self.post.location_id.id;
        self.selectedArea = self.post.area_id.id;
        self.selectedPeople = self.post.user_id;
		
		if(self.post.id == 0){
			router.push('/articles');
		}
		
		api.get('/users').then(function (response) {
            
			if(!response.data.records){
			}
			else{
				self.optionsPeople = response.data.records;
				console.log(self.optionsPeople);
			}
		}).catch(function (error) {
			console.log(error);
		});
		
    },
	methods: {
        editSerial: function(idSerial){
            var self = this;
            
            api.get('/serials/' + idSerial).then(function (response) {
                self.showSerialEdit();
                self.serialEdit = response.data
            }).catch(function (error) {
                console.log(error);
            });
        },
        changeSerial: function(){
            var self = this;
			
			api.put('/serials/' + self.serialEdit.id, self.serialEdit).then(function (response) {
				console.log(response.data);
                router.push('/post/' + self.post.id);
                router.push('/articles');
                self.hideSerialEdit();
			}).catch(function (error) {
				console.log(error);
			});
        },
        removeSerial: function(idSerial){
            var self = this;
            
            api.delete('/serials/' + idSerial).then(function (response) {
                router.push('/articles');
            }).catch(function (error) {
                console.log(error);
            });
        },
        clearSerials: function(){
			var self = this;
            self.serialNew = {
                name: '',
                total: 0,
                serial: '',
                notes: ''
            };
        },
		createSerial: function() {
			var self = this;
            
            var serial = {
                article_id: self.post.id,
                name: self.serialNew.name,
                total: self.serialNew.total,
                serial: self.serialNew.serial,
                notes: self.serialNew.notes
            };
            
			api.post('/serials',serial).then(function (response) {
				serialId = response.data;
				console.log(response.data);
                
                console.log(serialId);
                
                api.get('/serials/' + serialId).then(function (response) {
                    //self.post.serials.push(response.data);
                    self.post.serials.push(response.data);
                    console.log('serials Cargadas');
                    self.clearSerials();
                    self.hideSerial();
                }).catch(function (error) {
                    console.log(error);
                });
			}).catch(function (error) {
				console.log(error);
			});
		},
		updatepost: function () {
			var item = {
				id: this.post.id,
				category_id: this.selectedCategory,
				location_id: this.selectedLocation,
				area_id: this.selectedArea,
				user_id: this.selectedPeople,
				content: this.post.content,
			};
			
			api.put('/articles/'+item.id, item).then(function (response) {
				console.log(response);
			}).catch(function (error) {
				console.log(error);
			});
			//router.push('/articles');
		},
        createComment: function(){
			var self = this;
            self.commentNew.article_id = self.post.id;
			api.post('/comments', self.commentNew).then(function (response) {
            
                api.get('/comments/' + response.data).then(function (response) {
                    self.post.comments.push(response.data);
                    self.hideComment();
                }).catch(function (error) {
                    console.log(error);
                });
            
			}).catch(function (error) {
				console.log(error);
			});
        },
        hideSerial(){
            jQuery("#serialNew-pop").css('display', 'none');
        },
        showSerial(){
            jQuery("#serialNew-pop").css('display', 'block');
        },
        hideSerialEdit(){
            jQuery("#serialEdit-pop").css('display', 'none');
        },
        showSerialEdit(){
            jQuery("#serialEdit-pop").css('display', 'block');
        },
        hideComment(){
            jQuery("#commentNew-pop").css('display', 'none');
        },
        showComment(){
            jQuery("#commentNew-pop").css('display', 'block');
        }
	}
});

var articlesView = Vue.extend({
	template: '#articles-view',
	data: function () {
		return {
			post: findpost(this.$route.params.article_id)
		};
	},
    created(){
        var self = this;
		post = findpost(this.$route.params.article_id);
		
		if(post.id == undefined){
			self.$parent.loadBasicList();
		}
		if(post.id == 0){
			router.push('/articles');
		}
		else{
			Forma2.get('/people.php?action=option_list_revert&idPeople=' + post.user_id).then(function (response) {
			console.log(response.data)
				if(!response.data.data){
				
				}
				else{
					self.post.user_id = response.data.data;
				}
			}).catch(function (error) {
				console.log(error);
			});
		}
    },
    mounted(){
        var self = this;
    }
});

var articlesList = Vue.extend({
  template: '#articles-list',
  data: function () {
    return {
        posts: null,
        searchKey: this.$parent.searchText
    };
  },
  mounted: function () {
    var self = this;
    
    api.get('/articles?join=categories&join=areas&join=locations&join=comments&join=serials', {
        params: {
            
        }
    }).then(function (response) {
        posts = self.posts = response.data.records;
        console.log(self.posts);
    }).catch(function (error) {
        console.log(error);
    });
  },
  computed: {
    filteredposts: function () {
        return this.posts.filter(function (post) {
            return this.searchKey=='' || post.content.indexOf(this.searchKey) !== -1;
        },this);
    }
  }
});

var LogIn = Vue.extend({
  template: '#login',
  data: function () {
    return {
        nick: '',
        password: '',
        message: ''
    };
  },
  mounted: function () {
    var self = this;
    
    if(sessionPanel.checked().active == true){
        self.$router.push('/')
    }
  },
  computed: {
  },
  methods: {
    submitLogin: function(){
        var self = this;
        
        api.get('/users', {
            params: {
                filter: [
                    'nick,eq,' + self.nick,
                    'hash,eq,' + self.password
                ]
            }
        }).then(function (response) {
            var datos = response.data.records;
            if(!datos[0]){
                self.message = 'Verifique los datos';
            }
            else{
                User = datos[0];
                localStorage._sessionPanel = JSON.stringify(datos[0]);
                self.userSession = sessionPanel.checked();
                router.push('/');
                //location.reload();
            }
        }).catch(function (error) {
            console.log(error);
        });
    },
  }
});

var Dashboard = Vue.extend({
  template: '#dashboard',
  data: function () {
    return {
        dato: null
    };
  },
  mounted: function () {
    var self = this;
    
  },
  computed: {
  }
});

var router = new VueRouter({routes:[
  { path: '/', component: Dashboard },
  { path: '/LogIn', component: LogIn },
  { path: '/articles', component: articlesList },
  { path: '/articles/:article_id', component: articlesView, name: 'articlesView' },
  { path: '/articles/add', component: articlesAdd, name: 'articlesAdd' },
  { path: '/articles/:article_id/edit', component: articlesEdit, name: 'articlesEdit' },
  { path: '/articles/:article_id/delete', component: articlesDelete, name: 'articlesDelete' }
]});

app = new Vue({
    el: "#app",
    data: {
        connect: false,
        userSession: sessionPanel.checked(),
        searchText: '',
        categories: null,
        locations: null,
        areas: null,
    },
	components: {
        'Dashboard': Dashboard,
        'LogIn': LogIn,
        'articlesList': articlesList,
        'articlesView': articlesView,
        'articlesAdd': articlesAdd,
        'articlesEdit': articlesEdit,
        'articlesDelete': articlesDelete,
	},
    router:router,
    methods: {
        searchGlobal: function(){
        },
        logOut: function () {
            var self = this;
            sessionPanel.clearSession();
            self.userSession = sessionPanel.checked();
            router.push('/LogIn');
            //location.reload();
        },
        loadBasicList: function(){
			var self = this;
			api.get('/categories').then(function (response) {
				self.categories = response.data.records;
				console.log('Categorias Cargadas');
			}).catch(function (error) {
				console.log(error);
			});
			
			api.get('/locations').then(function (response) {
				self.locations = response.data.records;
				console.log('Sedes Cargadas');
			}).catch(function (error) {
				console.log(error);
			});
			api.get('/areas').then(function (response) {
				self.areas = response.data.records;
				console.log('Areas Cargadas');
			}).catch(function (error) {
				console.log(error);
			});
		}
    },
    created() {
        var self = this;
		self.loadBasicList();
    },
    mounted() {
        var self = this;
    },
    beforeCreate: function () {
        var self = this;
        
        var IntervalSession = setInterval(function(){
            app.userSession = sessionPanel.checked();
            if(sessionPanel.checked().active == false){
                app.$router.push('/LogIn');
            }
        }, 5000);
    }
});
