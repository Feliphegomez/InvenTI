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
	
	$('.mask-datesql').mask('0000-00-00');
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
  baseURL: '//192.168.1.20/InvenTI/api/api.php/records'
});

var Forma2 = axios.create({
  baseURL: location.pathname + '../forma2/api/v1.0/'
});

var posts = null;

function findpost(postId) {
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
				content: '', 
				category_id: 0,
				area_id: 0,
				location_id: 0,
				user_id: 0,
			}
		}
	},
	methods: {
		templateInfoPerson: function(){
			var post = this.post;
			post.content = 'Cedula: \n'+
						'Nombre: \n'+
						'User: \n'+
						'Cargo: \n'+
						'Piloto: Monteverde/Nobotia/MultiGYM \n'+
						'Estado: Activo/Inactivo/Licencia NR/Licencia Pat/Vacaciones \n'+
						'Supervisor: Cedula/Nombre \n'+
						'Rol: Conductor/Jardinero/Recepcionista \n'+
						'Ejecutivo_de_experiencia: Jefe del Jefe \n'+
						'Genero: MAS/FEM \n'+
						'Cuadrilla: Numero de la cuadrilla (Si aplica) \n';
		},
		createpost: function() {
			var post = this.post;
			api.post('/articles', post).then(function (response) {
				console.log(response)
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
        self.selectedPeople = self.post.user_id.id;
		
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
			router.push('/articles');
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
    
    api.get('/articles?join=categories&join=areas&join=locations&join=comments&join=serials&join=users', {
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

var peopleList = Vue.extend({
  template: '#people-list',
  data: function () {
    return {
        people: null,
        searchKey: this.$parent.searchText
    };
  },
  mounted: function () {
    var self = this;
    
    api.get('/users', {
        params: {
            join: 'articles'
        }
    }).then(function (response) {
        self.people = response.data.records;
        console.log(self.people);
    }).catch(function (error) {
        console.log(error);
    });
  },
  computed: {
    filteredposts: function () {
        return this.people.filter(function (person) {
            return this.searchKey=='' || person.nombre.indexOf(this.searchKey) !== -1;
        },this);
    }
  }
});

var peopleAdd = Vue.extend({
	template: '#people-add',
	data: function () {
		return {
			person: {
				cedula: '',
				nombre: '',
				nick: '',
				hash: '',
				cargo_id: 0,
				pilot_id: 0,
				estado_id: 0,
				fecha_nacimiento: '',
				fecha_ingreso: '',
				rol_id: 0,
				location_id: 0,
				more: ''
			}
		}
	},
	methods: {
		createperson: function() {
			var self = this;
			
			api.post('/users', self.person).then(function (response) {
				console.log(response)
				router.push('/people');
			}).catch(function (error) {
				console.log(error);
			});
		}
	},
    created(){
        var self = this;
        
    }
});

var peopleEdit = Vue.extend({
	template: '#people-edit',
	data: function () {
		return {
			person: {
				id: this.$route.params.article_id,
				cedula: '',
				nombre: '',
				nick: '',
				hash: '',
				cargo_id: 0,
				pilot_id: 0,
				estado_id: 0,
				fecha_nacimiento: '',
				fecha_ingreso: '',
				rol_id: 0,
				location_id: 0,
				more: ''
			}
		}
	},
	methods: {
		updateperson: function() {
			var self = this;
			
			var item = self.person;
			
			api.put('/users/' + item.id, item).then(function (response) {
				console.log(response);
				router.push({ name: 'peopleList' });
			}).catch(function (error) {
				console.log(error);
			});
			
		}
	},
    created(){
        var self = this;
        
		api.get('/users/' + self.$route.params.person_id).then(function (response) {
			self.person = response.data;
			
			console.log(self.person);
		}).catch(function (error) {
			console.log(error);
		});
    }
});

var peopleView = Vue.extend({
	template: '#people-view',
	data: function () {
		return {
			person: {
				id: this.$route.params.person_id,
				cedula: '',
				nombre: '',
				nick: '',
				hash: '',
				cargo_id: 0,
				pilot_id: 0,
				estado_id: 0,
				fecha_nacimiento: '',
				fecha_ingreso: '',
				rol_id: 0,
				location_id: 0,
				more: ''
			}
		};
	},
    created(){
        var self = this;
		api.get('/users/' + self.$route.params.person_id).then(function (response) {
			self.person = response.data;
		}).catch(function (error) {
			console.log(error);
		});
    },
    mounted(){
        var self = this;
    }
});

var peopleDelete = Vue.extend({
  template: '#people-delete',
  data: function () {
    return {
		person: {
			id: this.$route.params.person_id,
			nombre: ''
		}
	};
  },
  methods: {
    deleteperson: function () {
		var person = this.person;
		api.delete('/users/'+person.id).then(function (response) {
			console.log(response.data);
			router.push('/people');
		}).catch(function (error) {
			console.log(error);
		});  
    }
  }
});

var router = new VueRouter({routes:[
  { path: '/', component: Dashboard },
  { path: '/LogIn', component: LogIn },
  { path: '/people', component: peopleList, name: 'peopleList' },
  { path: '/people/add', component: peopleAdd, name: 'peopleAdd' },
  { path: '/people/:person_id/edit', component: peopleEdit, name: 'peopleEdit' },
  { path: '/people/:person_id', component: peopleView, name: 'peopleView' },
  { path: '/people/:person_id/delete', component: peopleDelete, name: 'peopleDelete' },
  { path: '/articles', component: articlesList, name: 'articlesList' },
  { path: '/articles/add', component: articlesAdd, name: 'articlesAdd' },
  { path: '/articles/:article_id', component: articlesView, name: 'articlesView' },
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
        cargos: null,
        estados: null,
        pilots: null,
        rols: null,
        permissions: null,
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
		appointmentListLoad: function(){
			var self = this;
			
			api.get('/cargos').then(function (response) {
				self.cargos = response.data.records;
				console.log('Cargos Cargadas');
			}).catch(function (error) {
				console.log(error);
			});
		},
		appointmentCreate: function(){
			var self = this;
			var createInsert = {};
			
			bootbox.prompt("Nombre del cargo.", function(result){
				console.log(result);
				if(result!=''){
					createInsert.name = result;
					api.post('/cargos', createInsert).then(function (response) {
						console.log(response)
						createInsert.id = response.data;
						console.log(createInsert);
						self.cargos.push(createInsert)
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		appointmentDelete: function(elementId){
			var self = this;
			
			bootbox.confirm({
				message: "¡Cuidado estas a punto de eliminar contenido permanentemente. ¿Estas seguro?",
				buttons: {
					confirm: {
						label: 'Si',
						className: 'btn-success'
					},
					cancel: {
						label: 'No',
						className: 'btn-danger'
					}
				},
				callback: function (result) {
					console.log(result);
					if(result == true){
						api.delete('/cargos/' + elementId).then(function (response) {
							console.log(response.data);
							self.appointmentListLoad();
						}).catch(function (error) {
							console.log(error);
						});
					}
				}
			});
		},
		appointmentUpdate: function(elementId){
			var self = this;
			var updateInsert = {};
			updateInsert.id = elementId;
			
			bootbox.prompt("Nombre del cargo.", function(result){
				console.log(result);
				if(result!=''){
					updateInsert.name = result;
					api.put('/cargos/' + elementId, updateInsert).then(function (response) {
						console.log(response)
						self.appointmentListLoad();
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		appointmentPermissionListLoad: function(){
			var self = this;
			api.get('/permissions').then(function (response) {
				self.permissions = response.data.records;
				console.log('permissions Cargadas');
			}).catch(function (error) {
				console.log(error);
			});
		},
		appointmentPermissionZoom: function(permissionId, cargoId){
			var self = this;
			var $html = '';
			$html += '<table>';
				$html += '<tr>';
					$html += '<td>';
					$html += '</td>';
				$html += '</tr>';
			$html += '</table>';
			
			api.get('/permissions/' + permissionId, {
				params: {
					
				}
			}).then(function (response) {
				dataInfo = response.data;
				
				console.log(dataInfo);
				
			
				var dialog = bootbox.dialog({
					title: 'Visor de permisos',
					message: "<p>Estos son los permisos que tiene este cargo. <b>" + dataInfo.name + "</b></p>",
					buttons: {
						cancel: {
							label: "Cerrar",
							className: 'btn-default',
							callback: function(){
								console.log('Custom cancel clicked');
							}
						},
						ok: {
							label: "Modificar Permisos",
							className: 'btn-info',
							callback: function(){
								self.appointmentPermissionUpdate(cargoId);
							}
						}
					}
				});
				
			}).catch(function (error) {
				console.log(error);
			});
			
		},
		appointmentPermissionUpdate(cargoId){
			var self = this;
			
			var arrayOptions = [];
			target = self.permissions;
			
			for (i=0;i<target.length;i++) {
				if (!target[i]) break;
				var obj = target[i];
				arrayOptions.push({
					text: obj.name,
					value: obj.id
				});
			}
			
			console.log(arrayOptions)
			
			bootbox.prompt({
				title: "Seleccione los nuevos permisos.",
				inputType: 'select',
				inputOptions: arrayOptions,
				callback: function (result) {
					console.log(result);
					if(result!=null){
						api.put('/cargos/' + cargoId, {
							permission_id: result
						}).then(function (response) {
							console.log(response)
							self.appointmentListLoad();
						}).catch(function (error) {
							console.log(error);
						});
					}
				}
			});
		},
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
			
			api.get('/locations').then(function (response) {
				self.locations = response.data.records;
				console.log('Sedes Cargadas');
			}).catch(function (error) {
				console.log(error);
			});
			
			self.appointmentListLoad();
			self.areaListLoad();
			self.categoryInventaryListLoad();
			self.statusPeopleListLoad();
			self.locationListLoad();
			self.pilotListLoad();
			self.rolListLoad();
			self.appointmentPermissionListLoad();
		},
		areaListLoad: function(){
			var self = this;
			api.get('/areas').then(function (response) {
				self.areas = response.data.records;
				console.log('Areas Cargadas');
			}).catch(function (error) {
				console.log(error);
			});
		},
		areaCreate: function(){
			var self = this;
			var createInsert = {};
			
			bootbox.prompt("Nombre del área.", function(result){
				console.log(result);
				if(result!=''){
					createInsert.name = result;
					api.post('/areas', createInsert).then(function (response) {
						console.log(response)
						createInsert.id = response.data;
						console.log(createInsert);
						self.areas.push(createInsert)
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		areaDelete: function(elementId){
			var self = this;
			
			bootbox.confirm({
				message: "¡Cuidado estas a punto de eliminar contenido permanentemente. ¿Estas seguro?",
				buttons: {
					confirm: {
						label: 'Si',
						className: 'btn-success'
					},
					cancel: {
						label: 'No',
						className: 'btn-danger'
					}
				},
				callback: function (result) {
					console.log(result);
					if(result == true){
						api.delete('/areas/' + elementId).then(function (response) {
							console.log(response.data);
							self.areaListLoad();
						}).catch(function (error) {
							console.log(error);
						});
					}
				}
			});
		},
		areaUpdate: function(elementId){
			var self = this;
			var updateInsert = {};
			updateInsert.id = elementId;
			
			bootbox.prompt("Nombre del área.", function(result){
				console.log(result);
				if(result!=''){
					updateInsert.name = result;
					api.put('/areas/' + elementId, updateInsert).then(function (response) {
						console.log(response)
						self.areaListLoad();
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		categoryInventaryListLoad: function(){
			var self = this;
			api.get('/categories').then(function (response) {
				self.categories = response.data.records;
				console.log('Categorias Cargadas');
			}).catch(function (error) {
				console.log(error);
			});
		},
		categoryInventaryCreate: function(){
			var self = this;
			var createInsert = {};
			
			bootbox.prompt("Nombre de la categoria del inventario.", function(result){
				console.log(result);
				if(result!=''){
					createInsert.name = result;
					api.post('/categories', createInsert).then(function (response) {
						console.log(response)
						createInsert.id = response.data;
						console.log(createInsert);
						self.categories.push(createInsert)
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		categoryInventaryDelete: function(elementId){
			var self = this;
			
			bootbox.confirm({
				message: "¡Cuidado estas a punto de eliminar contenido permanentemente. ¿Estas seguro?",
				buttons: {
					confirm: {
						label: 'Si',
						className: 'btn-success'
					},
					cancel: {
						label: 'No',
						className: 'btn-danger'
					}
				},
				callback: function (result) {
					console.log(result);
					if(result == true){
						api.delete('/categories/' + elementId).then(function (response) {
							console.log(response.data);
							self.categoryInventaryListLoad();
						}).catch(function (error) {
							console.log(error);
						});
					}
				}
			});
		},
		categoryInventaryUpdate: function(elementId){
			var self = this;
			var updateInsert = {};
			updateInsert.id = elementId;
			
			bootbox.prompt("Nombre del área.", function(result){
				console.log(result);
				if(result!=''){
					updateInsert.name = result;
					api.put('/categories/' + elementId, updateInsert).then(function (response) {
						console.log(response)
						self.categoryInventaryListLoad();
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		statusPeopleListLoad: function(){
			var self = this;
			api.get('/estados').then(function (response) {
				self.estados = response.data.records;
				console.log('estados cargados');
			}).catch(function (error) {
				console.log(error);
			});
		},
		statusPeopleCreate: function(){
			var self = this;
			var createInsert = {};
			
			bootbox.prompt("Nombre del estado.", function(result){
				console.log(result);
				if(result!=''){
					createInsert.name = result;
					api.post('/estados', createInsert).then(function (response) {
						console.log(response)
						createInsert.id = response.data;
						console.log(createInsert);
						self.estados.push(createInsert)
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		statusPeopleDelete: function(elementId){
			var self = this;
			
			bootbox.confirm({
				message: "¡Cuidado estas a punto de eliminar contenido permanentemente. ¿Estas seguro?",
				buttons: {
					confirm: {
						label: 'Si',
						className: 'btn-success'
					},
					cancel: {
						label: 'No',
						className: 'btn-danger'
					}
				},
				callback: function (result) {
					console.log(result);
					if(result == true){
						api.delete('/estados/' + elementId).then(function (response) {
							console.log(response.data);
							self.statusPeopleListLoad();
						}).catch(function (error) {
							console.log(error);
						});
					}
				}
			});
		},
		statusPeopleUpdate: function(elementId){
			var self = this;
			var updateInsert = {};
			updateInsert.id = elementId;
			
			bootbox.prompt("Nombre del Estado.", function(result){
				console.log(result);
				if(result!=''){
					updateInsert.name = result;
					api.put('/estados/' + elementId, updateInsert).then(function (response) {
						console.log(response)
						self.statusPeopleListLoad();
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		locationListLoad: function(){
			var self = this;
			api.get('/locations').then(function (response) {
				self.locations = response.data.records;
				console.log('locations cargados');
			}).catch(function (error) {
				console.log(error);
			});
		},
		locationCreate: function(){
			var self = this;
			var createInsert = {};
			
			bootbox.prompt("Nombre del estado.", function(result){
				console.log(result);
				if(result!=''){
					createInsert.name = result;
					api.post('/locations', createInsert).then(function (response) {
						console.log(response)
						createInsert.id = response.data;
						console.log(createInsert);
						self.locations.push(createInsert)
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		locationDelete: function(elementId){
			var self = this;
			
			bootbox.confirm({
				message: "¡Cuidado estas a punto de eliminar contenido permanentemente. ¿Estas seguro?",
				buttons: {
					confirm: {
						label: 'Si',
						className: 'btn-success'
					},
					cancel: {
						label: 'No',
						className: 'btn-danger'
					}
				},
				callback: function (result) {
					console.log(result);
					if(result == true){
						api.delete('/locations/' + elementId).then(function (response) {
							console.log(response.data);
							self.locationListLoad();
						}).catch(function (error) {
							console.log(error);
						});
					}
				}
			});
		},
		locationUpdate: function(elementId){
			var self = this;
			var updateInsert = {};
			updateInsert.id = elementId;
			
			bootbox.prompt("Nombre del Estado.", function(result){
				console.log(result);
				if(result!=''){
					updateInsert.name = result;
					api.put('/locations/' + elementId, updateInsert).then(function (response) {
						console.log(response)
						self.locationListLoad();
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		pilotListLoad: function(){
			var self = this;
			api.get('/pilots').then(function (response) {
				self.pilots = response.data.records;
				console.log('pilots cargados');
			}).catch(function (error) {
				console.log(error);
			});
		},
		pilotCreate: function(){
			var self = this;
			var createInsert = {};
			
			bootbox.prompt("Nombre del piloto.", function(result){
				console.log(result);
				if(result!=''){
					createInsert.name = result;
					api.post('/pilots', createInsert).then(function (response) {
						console.log(response)
						createInsert.id = response.data;
						console.log(createInsert);
						self.pilots.push(createInsert)
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		pilotDelete: function(elementId){
			var self = this;
			
			bootbox.confirm({
				message: "¡Cuidado estas a punto de eliminar contenido permanentemente. ¿Estas seguro?",
				buttons: {
					confirm: {
						label: 'Si',
						className: 'btn-success'
					},
					cancel: {
						label: 'No',
						className: 'btn-danger'
					}
				},
				callback: function (result) {
					console.log(result);
					if(result == true){
						api.delete('/pilots/' + elementId).then(function (response) {
							console.log(response.data);
							self.pilotListLoad();
						}).catch(function (error) {
							console.log(error);
						});
					}
				}
			});
		},
		pilotUpdate: function(elementId){
			var self = this;
			var updateInsert = {};
			updateInsert.id = elementId;
			
			bootbox.prompt("Nombre del Piloto.", function(result){
				console.log(result);
				if(result!=''){
					updateInsert.name = result;
					api.put('/pilots/' + elementId, updateInsert).then(function (response) {
						console.log(response)
						self.pilotListLoad();
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		rolListLoad: function(){
			var self = this;
			api.get('/rols').then(function (response) {
				self.rols = response.data.records;
				console.log('roles cargados');
			}).catch(function (error) {
				console.log(error);
			});
		},
		rolCreate: function(){
			var self = this;
			var createInsert = {};
			
			bootbox.prompt("Nombre del Rol.", function(result){
				console.log(result);
				if(result!=''){
					createInsert.name = result;
					api.post('/rols', createInsert).then(function (response) {
						console.log(response)
						createInsert.id = response.data;
						console.log(createInsert);
						self.rols.push(createInsert)
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
		rolDelete: function(elementId){
			var self = this;
			
			bootbox.confirm({
				message: "¡Cuidado estas a punto de eliminar contenido permanentemente. ¿Estas seguro?",
				buttons: {
					confirm: {
						label: 'Si',
						className: 'btn-success'
					},
					cancel: {
						label: 'No',
						className: 'btn-danger'
					}
				},
				callback: function (result) {
					console.log(result);
					if(result == true){
						api.delete('/rols/' + elementId).then(function (response) {
							console.log(response.data);
							self.rolListLoad();
						}).catch(function (error) {
							console.log(error);
						});
					}
				}
			});
		},
		rolUpdate: function(elementId){
			var self = this;
			var updateInsert = {};
			updateInsert.id = elementId;
			
			bootbox.prompt("Nombre del Piloto.", function(result){
				console.log(result);
				if(result!=''){
					updateInsert.name = result;
					api.put('/rols/' + elementId, updateInsert).then(function (response) {
						console.log(response)
						self.rolListLoad();
					}).catch(function (error) {
						console.log(error);
					});
				}
			});
		},
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
