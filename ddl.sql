-- public.accionesdesencadenadas definition

-- Drop table

-- DROP TABLE public.accionesdesencadenadas;

CREATE TABLE public.accionesdesencadenadas (
	accionesdesencadenadasid int2 DEFAULT nextval('accionesdesencadenadasid'::regclass) NOT NULL,
	accionesdesencadenadasaccion varchar(40) NOT NULL,
	accionesdesencadenadasmueveequ int2 NOT NULL,
	CONSTRAINT accionesdesencadenadas_pkey PRIMARY KEY (accionesdesencadenadasid)
);


-- public.actividad definition

-- Drop table

-- DROP TABLE public.actividad;

CREATE TABLE public.actividad (
	actividadid int2 NOT NULL,
	actividadnombre varchar(40) NOT NULL,
	CONSTRAINT actividad_pkey PRIMARY KEY (actividadid)
);


-- public.areas definition

-- Drop table

-- DROP TABLE public.areas;

CREATE TABLE public.areas (
	areasid int2 DEFAULT nextval('areasid'::regclass) NOT NULL,
	areasnombre varchar(50) NOT NULL,
	CONSTRAINT areas_pkey PRIMARY KEY (areasid)
);


-- public.circunscripcion definition

-- Drop table

-- DROP TABLE public.circunscripcion;

CREATE TABLE public.circunscripcion (
	circunscripcioncodigo varchar(20) NOT NULL,
	circunscripcionnombre varchar(40) NOT NULL,
	distritocodigo varchar(20) NOT NULL,
	CONSTRAINT circunscripcion_pkey PRIMARY KEY (circunscripcioncodigo)
);


-- public.circunscripciones definition

-- Drop table

-- DROP TABLE public.circunscripciones;

CREATE TABLE public.circunscripciones (
	circunscripcionesid bpchar(1) NOT NULL,
	circunscripcionesnombre varchar(40) NOT NULL,
	circunscripcionesdt bpchar(1) NOT NULL,
	circunscripcionesdtnombre varchar(40) NOT NULL,
	CONSTRAINT circunscripciones_pkey PRIMARY KEY (circunscripcionesid)
);
CREATE INDEX ucircunscripcionesnombre ON public.circunscripciones USING btree (circunscripcionesdtnombre);


-- public.debuglog definition

-- Drop table

-- DROP TABLE public.debuglog;

CREATE TABLE public.debuglog (
	debuglogid int4 DEFAULT nextval('debuglogid'::regclass) NOT NULL,
	debuglogdetalle text NOT NULL,
	debuglogdate date NULL,
	CONSTRAINT debuglog_pkey PRIMARY KEY (debuglogid)
);


-- public.inccabecera definition

-- Drop table

-- DROP TABLE public.inccabecera;

CREATE TABLE public.inccabecera (
	inccabeceraid int4 DEFAULT nextval('inccabeceraid'::regclass) NOT NULL,
	inccabeceraidpadre int2 NULL,
	inccabecerafechaini timestamp NOT NULL,
	inccabecerafechafin timestamp NULL,
	inccabeceradetalle text NOT NULL,
	inccabeceraorigen int2 NOT NULL,
	inccabeceradatoorigen varchar(100) NULL,
	inccabeceraadjunto bytea NULL,
	inccabecerareferencia varchar(100) NULL,
	inccabeceraestado int2 NOT NULL,
	siorgcodigo bpchar(8) NOT NULL,
	silegnro int4 NULL,
	secuserid int4 NULL,
	problemaid int4 NOT NULL,
	circunscripcionesid bpchar(1) NOT NULL,
	siusuariotecid int4 NULL,
	inccabeceraprioridad int2 NOT NULL,
	tipoproblemaid int2 NOT NULL,
	inccabeceraordencalculado int8 NOT NULL,
	inccabeceraexterno bool DEFAULT false NULL,
	inccabeceraultimo int8 NULL,
	servdistrito varchar(2) NULL,
	servarea int2 NULL,
	servsubarea int2 NULL,
	inccabeceraultimareit timestamp NULL,
	inccabecerareiteraciones int2 NULL,
	inccabecerareiteracionestxt text NULL,
	CONSTRAINT inccabecera_pkey PRIMARY KEY (inccabeceraid)
);
CREATE INDEX iinccabecera1 ON public.inccabecera USING btree (siorgcodigo);
CREATE INDEX iinccabecera2 ON public.inccabecera USING btree (secuserid);
CREATE INDEX iinccabecera3 ON public.inccabecera USING btree (silegnro);
CREATE INDEX iinccabecera4 ON public.inccabecera USING btree (problemaid);
CREATE INDEX iinccabecera5 ON public.inccabecera USING btree (tipoproblemaid);
CREATE INDEX iinccabecera6 ON public.inccabecera USING btree (circunscripcionesid);
CREATE INDEX iinccabecera7 ON public.inccabecera USING btree (siusuariotecid);
CREATE INDEX inccabecera_inccabeceraordencalculado_idx ON public.inccabecera USING btree (inccabeceraordencalculado DESC);
CREATE UNIQUE INDEX uinccabeceradesc ON public.inccabecera USING btree (inccabeceraid DESC);
CREATE UNIQUE INDEX uinccabecerafidesinccabecera ON public.inccabecera USING btree (inccabecerafechaini DESC, inccabeceraid);
CREATE INDEX uinccabecerame10 ON public.inccabecera USING btree (inccabeceradetalle);
CREATE INDEX uinccabecerame11 ON public.inccabecera USING btree (inccabeceradetalle DESC);
CREATE UNIQUE INDEX uinccabecerapredeterminado ON public.inccabecera USING btree (inccabeceraordencalculado DESC, inccabeceraprioridad DESC, inccabeceraid DESC);
CREATE INDEX uinccabeceraultimousuario ON public.inccabecera USING btree (inccabeceraultimo);


-- public.marca definition

-- Drop table

-- DROP TABLE public.marca;

CREATE TABLE public.marca (
	marcaid int4 NOT NULL,
	marcanombre varchar(40) NOT NULL,
	CONSTRAINT marca_pkey PRIMARY KEY (marcaid)
);


-- public.motivorechazo definition

-- Drop table

-- DROP TABLE public.motivorechazo;

CREATE TABLE public.motivorechazo (
	motivorechazoid int2 DEFAULT nextval('motivorechazoid'::regclass) NOT NULL,
	motivorechazomotivo varchar(400) NOT NULL,
	CONSTRAINT motivorechazo_pkey PRIMARY KEY (motivorechazoid)
);


-- public.parametro definition

-- Drop table

-- DROP TABLE public.parametro;

CREATE TABLE public.parametro (
	parametronombre varchar(150) NOT NULL,
	parametrovalor varchar(500) NOT NULL,
	parametroobservacion varchar(500) NULL,
	parametromodiffechahora timestamp NULL,
	parametroblobfile bytea NULL,
	parametroblobfilename varchar(200) NULL,
	parametroblobfiletype varchar(40) NULL,
	CONSTRAINT parametro_pkey PRIMARY KEY (parametronombre)
);


-- public.parte definition

-- Drop table

-- DROP TABLE public.parte;

CREATE TABLE public.parte (
	parteid int4 NULL,
	parteserie varchar(25) NOT NULL,
	parteproveedorcod bpchar(5) NULL,
	partemodeloid int4 NOT NULL,
	partefactura varchar(40) NULL,
	partefechacompra date NULL,
	partegarantia date NULL,
	parteinventario varchar(40) NULL,
	partepropietario varchar(40) NULL,
	partedescripcion varchar(100) NULL,
	parteorganismocodigo bpchar(6) NULL,
	partepersonal bool NULL,
	parterelevado bool NULL,
	partebackup bool NULL,
	parteidentificacion int4 NULL,
	parteip varchar(15) NULL,
	partefechaalta date NULL,
	partefechaupd date NULL,
	parteusuario varchar(40) NULL,
	partecantidad int4 NULL,
	parteultestado int2 NULL,
	parteorganismoanterior bpchar(6) NULL,
	parteobservaciones varchar(256) NULL
);
CREATE INDEX iparte1 ON public.parte USING btree (parteorganismocodigo);
CREATE INDEX iparte2 ON public.parte USING btree (partemodeloid);
CREATE INDEX iparte3 ON public.parte USING btree (parteproveedorcod);


-- public.presupuestobkp definition

-- Drop table

-- DROP TABLE public.presupuestobkp;

CREATE TABLE public.presupuestobkp (
	presupuestoid int8 NOT NULL,
	inccabeceraid int8 NOT NULL,
	presupuestonumero varchar(40) NULL,
	presupuestofecha date NOT NULL,
	presupuestodescripcion varchar(400) NOT NULL,
	presupuestoprecio numeric(13, 2) NULL,
	presupuestovto date NULL,
	presupuestotiempoentrega int2 NULL,
	presupuestogarantia int2 NULL,
	presupuestoestado varchar(40) NOT NULL,
	presupuestorechazogarantia varchar(400) NULL,
	motivorechazoid int2 NULL,
	proveedorcod bpchar(5) NOT NULL,
	presupuestoobservaciones varchar(4000) NOT NULL
);


-- public.proveedor definition

-- Drop table

-- DROP TABLE public.proveedor;

CREATE TABLE public.proveedor (
	proveedorcod bpchar(5) NOT NULL,
	proveedornombre varchar(50) NOT NULL,
	proveedortelefono varchar(20) NULL,
	proveedordomicilio varchar(150) NULL,
	proveedormail varchar(80) NULL,
	proveedorclave int2 NULL,
	proveedorcodigousuario varchar(10) NULL,
	CONSTRAINT proveedor_pkey PRIMARY KEY (proveedorcod)
);


-- public.secobject definition

-- Drop table

-- DROP TABLE public.secobject;

CREATE TABLE public.secobject (
	secobjectname varchar(120) NOT NULL,
	CONSTRAINT secobject_pkey PRIMARY KEY (secobjectname)
);


-- public.secrole definition

-- Drop table

-- DROP TABLE public.secrole;

CREATE TABLE public.secrole (
	secroleid int2 DEFAULT nextval('secroleid'::regclass) NOT NULL,
	secrolename varchar(40) NOT NULL,
	secroledescription varchar(120) NOT NULL,
	secroletipo varchar(20) NULL,
	CONSTRAINT secrole_pkey PRIMARY KEY (secroleid)
);


-- public.secuser1 definition

-- Drop table

-- DROP TABLE public.secuser1;

CREATE TABLE public.secuser1 (
	secusername varchar(100) NOT NULL,
	secuserpassword varchar(100) NOT NULL,
	secuserrol int2 DEFAULT 0 NULL,
	secuserarea bpchar(2) DEFAULT ''::bpchar NULL,
	secuseremail varchar(100) DEFAULT ''::character varying NULL,
	secuserorgcod bpchar(6) DEFAULT ''::bpchar NULL,
	secuserdistrito bpchar(1) DEFAULT ''::bpchar NULL,
	secuserlegajo int4 DEFAULT 0 NULL,
	secusuarionombre varchar(100) NULL,
	orgact varchar(100) NULL
);


-- public.tipoparte definition

-- Drop table

-- DROP TABLE public.tipoparte;

CREATE TABLE public.tipoparte (
	tipoparteid int2 NOT NULL,
	tipopartedescripcion varchar(40) NOT NULL,
	CONSTRAINT tipoparte_pkey PRIMARY KEY (tipoparteid)
);


-- public.tipoproblema definition

-- Drop table

-- DROP TABLE public.tipoproblema;

CREATE TABLE public.tipoproblema (
	tipoproblemaid int2 NOT NULL,
	tipoproblemadescripcion varchar(400) NOT NULL,
	tipoproblemaeditableporusuario bool NULL,
	tipoproblemamensajeusucomun text NULL,
	tipoproblemapermiteguardar bool NULL,
	tipoproblemasemejantereiter bool NULL,
	CONSTRAINT tipoproblema_pkey PRIMARY KEY (tipoproblemaid)
);
CREATE INDEX tipoproblema_tipoproblemadescripcion_idx ON public.tipoproblema USING btree (tipoproblemadescripcion);


-- public.usercustomizations definition

-- Drop table

-- DROP TABLE public.usercustomizations;

CREATE TABLE public.usercustomizations (
	usercustomizationsid int4 NOT NULL,
	usercustomizationskey varchar(200) NOT NULL,
	usercustomizationsvalue text NOT NULL,
	CONSTRAINT usercustomizations_pkey PRIMARY KEY (usercustomizationsid, usercustomizationskey)
);


-- public.modelo definition

-- Drop table

-- DROP TABLE public.modelo;

CREATE TABLE public.modelo (
	modeloid int4 NOT NULL,
	modelomarcaid int4 NOT NULL,
	modelotipoparteid int2 NOT NULL,
	modelodescripcion varchar(40) NULL,
	modelocaracteristica varchar(150) NULL,
	CONSTRAINT modelo_pkey PRIMARY KEY (modeloid),
	CONSTRAINT imodelo1 FOREIGN KEY (modelotipoparteid) REFERENCES public.tipoparte(tipoparteid),
	CONSTRAINT imodelo2 FOREIGN KEY (modelomarcaid) REFERENCES public.marca(marcaid)
);
CREATE INDEX imodelo1 ON public.modelo USING btree (modelotipoparteid);
CREATE INDEX imodelo2 ON public.modelo USING btree (modelomarcaid);


-- public.organismo definition

-- Drop table

-- DROP TABLE public.organismo;

CREATE TABLE public.organismo (
	organismocodigo bpchar(6) NOT NULL,
	organismonombre varchar(100) NOT NULL,
	organismocircunscripcioncod varchar(20) NOT NULL,
	organismodependencia varchar(8) NULL,
	organismodependenciabaja date NULL,
	CONSTRAINT organismo_pkey PRIMARY KEY (organismocodigo),
	CONSTRAINT iorganismo1 FOREIGN KEY (organismocircunscripcioncod) REFERENCES public.circunscripcion(circunscripcioncodigo)
);
CREATE INDEX iorganismo1 ON public.organismo USING btree (organismocircunscripcioncod);


-- public.partehard definition

-- Drop table

-- DROP TABLE public.partehard;

CREATE TABLE public.partehard (
	partehardid int8 DEFAULT nextval('partehardid'::regclass) NOT NULL,
	partehardserie varchar(40) NULL,
	proveedorcod bpchar(5) NULL,
	modeloid int4 NULL,
	partehardfactura varchar(40) NULL,
	partehardfechacompra date NULL,
	partehardgarantia date NULL,
	partehardinventario varchar(40) NULL,
	partehardpropietario varchar(40) NULL,
	parteharddescripcion varchar(40) NULL,
	siorgcodigo bpchar(8) NULL,
	partehardpersonal int2 NULL,
	partehardrelevado int2 NULL,
	partehardbackup int2 NULL,
	partehardidentificacion int2 NULL,
	partehardip varchar(40) NULL,
	partehardfechaalta date NULL,
	partehardfechamodi date NULL,
	parteharduser varchar(40) NULL,
	partehardcantidadcomp int2 NULL,
	partehardultestado int2 NULL,
	organterior bpchar(8) NULL,
	partehardobservaciones varchar(2000) NULL,
	CONSTRAINT partehard_pkey PRIMARY KEY (partehardid),
	CONSTRAINT ipartehard2 FOREIGN KEY (modeloid) REFERENCES public.modelo(modeloid),
	CONSTRAINT ipartehard3 FOREIGN KEY (proveedorcod) REFERENCES public.proveedor(proveedorcod)
);
CREATE INDEX ipartehard1 ON public.partehard USING btree (siorgcodigo);
CREATE INDEX ipartehard2 ON public.partehard USING btree (modeloid);
CREATE INDEX ipartehard3 ON public.partehard USING btree (proveedorcod);


-- public.presupuesto definition

-- Drop table

-- DROP TABLE public.presupuesto;

CREATE TABLE public.presupuesto (
	presupuestoid int8 DEFAULT nextval('presupuestoid'::regclass) NOT NULL,
	inccabeceraid int8 NOT NULL,
	presupuestonumero varchar(40) NULL,
	presupuestofecha date NOT NULL,
	presupuestodescripcion varchar(400) NOT NULL,
	presupuestoprecio numeric(13, 2) NULL,
	presupuestovto date NULL,
	presupuestotiempoentrega int2 NULL,
	presupuestogarantia int2 NULL,
	presupuestoestado varchar(40) NOT NULL,
	presupuestorechazogarantia varchar(400) NULL,
	motivorechazoid int2 NULL,
	proveedorcod bpchar(5) NOT NULL,
	presupuestoobservaciones varchar(4000) NOT NULL,
	CONSTRAINT presupuesto_pkey PRIMARY KEY (presupuestoid),
	CONSTRAINT ipresupuesto1 FOREIGN KEY (motivorechazoid) REFERENCES public.motivorechazo(motivorechazoid),
	CONSTRAINT ipresupuesto2 FOREIGN KEY (inccabeceraid) REFERENCES public.inccabecera(inccabeceraid),
	CONSTRAINT ipresupuesto3 FOREIGN KEY (proveedorcod) REFERENCES public.proveedor(proveedorcod)
);
CREATE INDEX ipresupuesto1 ON public.presupuesto USING btree (motivorechazoid);
CREATE INDEX ipresupuesto2 ON public.presupuesto USING btree (inccabeceraid);
CREATE INDEX ipresupuesto3 ON public.presupuesto USING btree (proveedorcod);


-- public.problema definition

-- Drop table

-- DROP TABLE public.problema;

CREATE TABLE public.problema (
	problemaid int4 NOT NULL,
	problemanombre varchar(400) NOT NULL,
	problematipo int2 NOT NULL,
	problemacargausuario bool NOT NULL,
	problemamensaje text NOT NULL,
	problemausuariograba bool DEFAULT false NOT NULL,
	CONSTRAINT problema_pkey PRIMARY KEY (problemaid),
	CONSTRAINT iproblema1 FOREIGN KEY (problematipo) REFERENCES public.tipoproblema(tipoproblemaid)
);
CREATE INDEX iproblema1 ON public.problema USING btree (problematipo);
CREATE INDEX problema_problemanombre_idx ON public.problema USING btree (problemanombre);


-- public.problemasinfo definition

-- Drop table

-- DROP TABLE public.problemasinfo;

CREATE TABLE public.problemasinfo (
	problemasinfoid int2 DEFAULT nextval('problemasinfoid'::regclass) NOT NULL,
	tipoproblemaid int2 NOT NULL,
	problemasinfodetalle varchar(400) NOT NULL,
	CONSTRAINT problemasinfo_pkey PRIMARY KEY (problemasinfoid),
	CONSTRAINT iproblemasinfo1 FOREIGN KEY (tipoproblemaid) REFERENCES public.tipoproblema(tipoproblemaid)
);
CREATE INDEX iproblemasinfo1 ON public.problemasinfo USING btree (tipoproblemaid);


-- public.secfunctionality definition

-- Drop table

-- DROP TABLE public.secfunctionality;

CREATE TABLE public.secfunctionality (
	secfunctionalityid int8 DEFAULT nextval('secfunctionalityid'::regclass) NOT NULL,
	secfunctionalitykey varchar(100) NOT NULL,
	secfunctionalitydescription varchar(100) NOT NULL,
	secfunctionalitytype int2 NOT NULL,
	secparentfunctionalityid int8 NULL,
	secfunctionalityactive bool NOT NULL,
	CONSTRAINT secfunctionality_pkey PRIMARY KEY (secfunctionalityid),
	CONSTRAINT isecfunctionality1 FOREIGN KEY (secparentfunctionalityid) REFERENCES public.secfunctionality(secfunctionalityid)
);
CREATE INDEX isecfunctionality1 ON public.secfunctionality USING btree (secparentfunctionalityid);
CREATE UNIQUE INDEX usecfunctionality ON public.secfunctionality USING btree (secfunctionalitykey);


-- public.secfunctionalityrole definition

-- Drop table

-- DROP TABLE public.secfunctionalityrole;

CREATE TABLE public.secfunctionalityrole (
	secfunctionalityid int8 NOT NULL,
	secroleid int2 NOT NULL,
	CONSTRAINT secfunctionalityrole_pkey PRIMARY KEY (secfunctionalityid, secroleid),
	CONSTRAINT isecfunctionalityrol1 FOREIGN KEY (secfunctionalityid) REFERENCES public.secfunctionality(secfunctionalityid),
	CONSTRAINT isecfunctionalityrol2 FOREIGN KEY (secroleid) REFERENCES public.secrole(secroleid)
);
CREATE INDEX isecfunctionalityrol2 ON public.secfunctionalityrole USING btree (secroleid);


-- public.secobjectfunctionalities definition

-- Drop table

-- DROP TABLE public.secobjectfunctionalities;

CREATE TABLE public.secobjectfunctionalities (
	secobjectname varchar(120) NOT NULL,
	secfunctionalityid int8 NOT NULL,
	CONSTRAINT secobjectfunctionalities_pkey PRIMARY KEY (secobjectname, secfunctionalityid),
	CONSTRAINT isecobjectfunctionalities1 FOREIGN KEY (secfunctionalityid) REFERENCES public.secfunctionality(secfunctionalityid),
	CONSTRAINT isecobjectfunctionalities2 FOREIGN KEY (secobjectname) REFERENCES public.secobject(secobjectname)
);
CREATE INDEX isecobjectfunctionalities1 ON public.secobjectfunctionalities USING btree (secfunctionalityid);


-- public.serviciosext definition

-- Drop table

-- DROP TABLE public.serviciosext;

CREATE TABLE public.serviciosext (
	serviciosextid int8 DEFAULT nextval('serviciosextid'::regclass) NOT NULL,
	serviciosextremito varchar(40) NULL,
	serviciosextfactura varchar(40) NULL,
	serviciosextfechafac date NULL,
	serviciosextimportefac numeric(13, 2) NULL,
	serviciosextobsfac varchar(400) NULL,
	serviciosextestado int2 NULL,
	serviciosextfechainicio timestamp NULL,
	serviciosextentregaequipo timestamp NULL,
	serviciosextcomprobanteentrega varchar(40) NULL,
	serviciosextdevolucionequipo timestamp NULL,
	serviciosextcomprobantedevoluc varchar(40) NULL,
	inccabeceraid int8 NOT NULL,
	partehardid int8 NULL,
	proveedoresid bpchar(5) NOT NULL,
	CONSTRAINT serviciosext_pkey PRIMARY KEY (serviciosextid),
	CONSTRAINT iserviciosext1 FOREIGN KEY (proveedoresid) REFERENCES public.proveedor(proveedorcod),
	CONSTRAINT iserviciosext3 FOREIGN KEY (inccabeceraid) REFERENCES public.inccabecera(inccabeceraid)
);
CREATE INDEX iserviciosext1 ON public.serviciosext USING btree (proveedoresid);
CREATE INDEX iserviciosext2 ON public.serviciosext USING btree (partehardid);
CREATE INDEX iserviciosext3 ON public.serviciosext USING btree (inccabeceraid);


-- public.subarea definition

-- Drop table

-- DROP TABLE public.subarea;

CREATE TABLE public.subarea (
	subareaid int2 DEFAULT nextval('subareaid'::regclass) NOT NULL,
	areasid int2 NOT NULL,
	subareanombre varchar(50) NOT NULL,
	CONSTRAINT subarea_pkey PRIMARY KEY (subareaid),
	CONSTRAINT isubarea1 FOREIGN KEY (areasid) REFERENCES public.areas(areasid)
);
CREATE INDEX isubarea1 ON public.subarea USING btree (areasid);


-- public.tareas definition

-- Drop table

-- DROP TABLE public.tareas;

CREATE TABLE public.tareas (
	tareasid int2 NOT NULL,
	tareasnombre varchar(150) NOT NULL,
	tareasdescripcion varchar(150) NOT NULL,
	tareastipo varchar(40) NOT NULL,
	tareasundo varchar(40) NOT NULL,
	tareascerrar bool NULL,
	accionesdesencadenadasid int2 NOT NULL,
	CONSTRAINT tareas_pkey PRIMARY KEY (tareasid),
	CONSTRAINT itareas1 FOREIGN KEY (accionesdesencadenadasid) REFERENCES public.accionesdesencadenadas(accionesdesencadenadasid)
);
CREATE INDEX itareas1 ON public.tareas USING btree (accionesdesencadenadasid);


-- public.comportamientost definition

-- Drop table

-- DROP TABLE public.comportamientost;

CREATE TABLE public.comportamientost (
	comportamientostid int2 NOT NULL,
	tareasid int2 NOT NULL,
	comportamientostvalor varchar(40) NOT NULL,
	CONSTRAINT comportamientost_pkey PRIMARY KEY (comportamientostid),
	CONSTRAINT icomportamientost1 FOREIGN KEY (tareasid) REFERENCES public.tareas(tareasid)
);
CREATE INDEX icomportamientost1 ON public.comportamientost USING btree (tareasid);
CREATE INDEX ucomportamientostcomp ON public.comportamientost USING btree (comportamientostvalor);


-- public.incaccion definition

-- Drop table

-- DROP TABLE public.incaccion;

CREATE TABLE public.incaccion (
	incaccionid int4 DEFAULT nextval('incaccionid'::regclass) NOT NULL,
	inccabeceraid int4 NOT NULL,
	incaccioninicio timestamp NOT NULL,
	incaccionfin timestamp NULL,
	incacciondetalle text NULL,
	incaccionadjunto bytea NULL,
	incaccionadjunto_gxi varchar(2048) NULL,
	incaccionidpadre int4 NULL,
	incaccionfecasignado timestamp NOT NULL,
	incaccionresumen text NOT NULL,
	parteid int4 NULL,
	acciontecnicoid int4 NULL,
	incaccionordennum int4 NULL,
	tareasid int4 NULL,
	incaccionestado int2 NULL,
	incaccionexterno bool DEFAULT false NULL,
	partebackupid int8 NULL,
	CONSTRAINT incaccion_pkey PRIMARY KEY (incaccionid),
	CONSTRAINT iincaccion1 FOREIGN KEY (inccabeceraid) REFERENCES public.inccabecera(inccabeceraid) ON UPDATE CASCADE,
	CONSTRAINT iincaccion2 FOREIGN KEY (tareasid) REFERENCES public.tareas(tareasid)
);
CREATE INDEX iincaccion1 ON public.incaccion USING btree (inccabeceraid);
CREATE INDEX iincaccion2 ON public.incaccion USING btree (tareasid);
CREATE INDEX iincaccion4 ON public.incaccion USING btree (acciontecnicoid);
CREATE INDEX iincaccion5 ON public.incaccion USING btree (partebackupid);

-- Table Triggers

create trigger update_inccabecera_trigger after
insert
    on
    public.incaccion for each row execute procedure update_inccabecera_from_secuser();
create trigger update_inccabecera_ordencalculado_trigger after
insert
    or
update
    on
    public.incaccion for each row execute procedure update_inccabecera_ordencalculado_trigger();


-- public.menuitem definition

-- Drop table

-- DROP TABLE public.menuitem;

CREATE TABLE public.menuitem (
	menuitemid int2 DEFAULT nextval('menuitemid'::regclass) NOT NULL,
	menuitemcaption varchar(40) NOT NULL,
	menuitemorder int2 NOT NULL,
	menuitemfatherid int2 NULL,
	menuitemtype int2 NOT NULL,
	menuitemlink varchar(80) NOT NULL,
	menuitemlinkparameters varchar(100) NOT NULL,
	menuitemlinktarget varchar(10) NOT NULL,
	menuitemiconclass varchar(40) NOT NULL,
	menuitemshowdevelopermenuoptio bool NOT NULL,
	menuitemshoweditmenuoptions bool NOT NULL,
	secfunctionalityid int8 NULL,
	CONSTRAINT menuitem_pkey PRIMARY KEY (menuitemid),
	CONSTRAINT imenuitem1 FOREIGN KEY (menuitemfatherid) REFERENCES public.menuitem(menuitemid),
	CONSTRAINT imenuitem2 FOREIGN KEY (secfunctionalityid) REFERENCES public.secfunctionality(secfunctionalityid)
);
CREATE INDEX imenuitem1 ON public.menuitem USING btree (menuitemfatherid);
CREATE INDEX imenuitem2 ON public.menuitem USING btree (secfunctionalityid);


-- public.movimientoequipo definition

-- Drop table

-- DROP TABLE public.movimientoequipo;

CREATE TABLE public.movimientoequipo (
	movimientoequipoid int8 DEFAULT nextval('movimientoequipoid'::regclass) NOT NULL,
	partehardid int8 NOT NULL,
	movimientoequipocodori varchar(40) NOT NULL,
	movimientoequipocoddesti varchar(40) NOT NULL,
	movimientoequipodetalleori varchar(150) NOT NULL,
	movimientoequipodetalledesti varchar(150) NOT NULL,
	movimientoequipotipoori varchar(40) NOT NULL,
	movimientoequipotipodesti varchar(40) NOT NULL,
	movimientoequipofecha timestamp NOT NULL,
	inccabeceraid int8 NOT NULL,
	idaccion int8 NULL,
	movimientoequipoorigen1 varchar(150) NULL,
	CONSTRAINT movimientoequipo_pkey PRIMARY KEY (movimientoequipoid),
	CONSTRAINT imovimientoequipo1 FOREIGN KEY (inccabeceraid) REFERENCES public.inccabecera(inccabeceraid),
	CONSTRAINT imovimientoequipo2 FOREIGN KEY (partehardid) REFERENCES public.partehard(partehardid)
);
CREATE INDEX imovimientoequipo1 ON public.movimientoequipo USING btree (inccabeceraid);
CREATE INDEX imovimientoequipo2 ON public.movimientoequipo USING btree (partehardid);


-- public.personaltec definition

-- Drop table

-- DROP TABLE public.personaltec;

CREATE TABLE public.personaltec (
	personaltecid int8 NOT NULL,
	subareaid int2 NOT NULL,
	personaltecnombre varchar(150) NOT NULL,
	personaltecie varchar DEFAULT 'I'::character varying NULL,
	personaltecemail varchar NULL,
	personaltecdireccion varchar NULL,
	personaltecobservaciones varchar NULL,
	personaltecestado varchar DEFAULT 'A'::character varying NULL,
	personaltecrecibetarea bool DEFAULT true NULL,
	personaltecssd bool NULL,
	personaltecssa bool NULL,
	CONSTRAINT personaltec_pkey PRIMARY KEY (personaltecid),
	CONSTRAINT ipersonaltec1 FOREIGN KEY (subareaid) REFERENCES public.subarea(subareaid)
);
CREATE INDEX ipersonaltec1 ON public.personaltec USING btree (subareaid);
CREATE INDEX upersonaltec ON public.personaltec USING btree (personaltecnombre);


-- public.secuser definition

-- Drop table

-- DROP TABLE public.secuser;

CREATE TABLE public.secuser (
	secuserid int4 DEFAULT nextval('secuserid'::regclass) NOT NULL,
	secusername varchar(100) NOT NULL,
	secuserpassword varchar(100) NOT NULL,
	secuserrol int2 DEFAULT 0 NULL,
	secuserarea bpchar(2) DEFAULT ''::bpchar NULL,
	secuseremail varchar(100) DEFAULT ''::character varying NULL,
	secuserorgcod bpchar(6) DEFAULT ''::bpchar NULL,
	secuserlegajo int4 DEFAULT 0 NULL,
	secuserlegorgcod bpchar(10) NULL,
	secuserdistrito varchar(20) NULL,
	secusernombre varchar(100) NULL,
	secuserestado bpchar(1) NOT NULL,
	subareaid int2 NOT NULL,
	CONSTRAINT secuser_pkey PRIMARY KEY (secuserid),
	CONSTRAINT isecuser1 FOREIGN KEY (subareaid) REFERENCES public.subarea(subareaid) ON UPDATE CASCADE
);
CREATE INDEX isecuser1 ON public.secuser USING btree (subareaid);


-- public.secuserorganismo definition

-- Drop table

-- DROP TABLE public.secuserorganismo;

CREATE TABLE public.secuserorganismo (
	secuserid int4 NOT NULL,
	organismocodigo bpchar(6) NOT NULL,
	secuserorganismoalta date NOT NULL,
	secuserorganismobaja date NOT NULL,
	CONSTRAINT secuserorganismo_pkey PRIMARY KEY (secuserid, organismocodigo),
	CONSTRAINT isecuserorganismo1 FOREIGN KEY (organismocodigo) REFERENCES public.organismo(organismocodigo),
	CONSTRAINT isecuserorganismo2 FOREIGN KEY (secuserid) REFERENCES public.secuser(secuserid)
);
CREATE INDEX isecuserorganismo1 ON public.secuserorganismo USING btree (organismocodigo);


-- public.secuserrole definition

-- Drop table

-- DROP TABLE public.secuserrole;

CREATE TABLE public.secuserrole (
	secuserid int4 NOT NULL,
	secroleid int2 NOT NULL,
	CONSTRAINT secuserrole_pkey PRIMARY KEY (secuserid, secroleid),
	CONSTRAINT isecuserrole1 FOREIGN KEY (secroleid) REFERENCES public.secrole(secroleid),
	CONSTRAINT isecuserrole2 FOREIGN KEY (secuserid) REFERENCES public.secuser(secuserid)
);
CREATE INDEX isecuserrole1 ON public.secuserrole USING btree (secroleid);


-- public.casos definition

-- Drop table

-- DROP TABLE public.casos;

CREATE TABLE public.casos (
	casonro int4 DEFAULT nextval('casonro'::regclass) NOT NULL,
	casofechainicio date NULL,
	casofechaatencion date NULL,
	casofechafin date NULL,
	casoestado bpchar(20) NULL,
	casoprioridad int2 NULL,
	casodescripcion varchar(255) NULL,
	casoubicacion varchar(100) NULL,
	casoorganismocodigo bpchar(6) NULL,
	casocircunscripcioncodigo varchar(20) NULL,
	casousuarioid int4 NULL,
	casoresponsableid int4 NULL,
	casoactividadid int2 NULL,
	casoorigen bpchar(10) NULL,
	casotelefono bpchar(20) NULL,
	casoadjunto bytea NULL,
	CONSTRAINT casos_pkey PRIMARY KEY (casonro),
	CONSTRAINT icasos1 FOREIGN KEY (casousuarioid) REFERENCES public.secuser(secuserid),
	CONSTRAINT icasos2 FOREIGN KEY (casocircunscripcioncodigo) REFERENCES public.circunscripcion(circunscripcioncodigo),
	CONSTRAINT icasos3 FOREIGN KEY (casoorganismocodigo) REFERENCES public.organismo(organismocodigo),
	CONSTRAINT icasos4 FOREIGN KEY (casoresponsableid) REFERENCES public.secuser(secuserid),
	CONSTRAINT icasos5 FOREIGN KEY (casoactividadid) REFERENCES public.actividad(actividadid)
);
CREATE INDEX icasos1 ON public.casos USING btree (casousuarioid);
CREATE INDEX icasos2 ON public.casos USING btree (casocircunscripcioncodigo);
CREATE INDEX icasos3 ON public.casos USING btree (casoorganismocodigo);
CREATE INDEX icasos4 ON public.casos USING btree (casoresponsableid);
CREATE INDEX icasos5 ON public.casos USING btree (casoactividadid);


-- public.equipobackup definition

-- Drop table

-- DROP TABLE public.equipobackup;

CREATE TABLE public.equipobackup (
	equipobackupid int8 DEFAULT nextval('equipobackupid'::regclass) NOT NULL,
	incaccionid int8 NOT NULL,
	equipobackupfechadesde timestamp NULL,
	equipobackupfechahasta timestamp NULL,
	CONSTRAINT equipobackup_pkey PRIMARY KEY (equipobackupid),
	CONSTRAINT iequipobackup1 FOREIGN KEY (incaccionid) REFERENCES public.incaccion(incaccionid)
);
CREATE INDEX iequipobackup1 ON public.equipobackup USING btree (incaccionid);


-- public.incidente definition

-- Drop table

-- DROP TABLE public.incidente;

CREATE TABLE public.incidente (
	incidentenro int8 DEFAULT nextval('incidentenro'::regclass) NOT NULL,
	incidentefecini timestamp NOT NULL,
	incidentefecfin timestamp NOT NULL,
	incidenteestado int2 NOT NULL,
	incidenteprioridad int2 NOT NULL,
	incidentedescrip varchar(5000) NOT NULL,
	incidenteubicacion varchar(100) NOT NULL,
	incidenteorgcod bpchar(8) NOT NULL,
	incidentecircunscod varchar(20) NOT NULL,
	incidenteusuarioid int4 NOT NULL,
	incidenterespid int4 NOT NULL,
	incidenteactid int2 NOT NULL,
	incidentetelefono int4 NOT NULL,
	incidenteorigen bpchar(3) NOT NULL,
	incidenteadjunto bytea NOT NULL,
	CONSTRAINT incidente_pkey PRIMARY KEY (incidentenro),
	CONSTRAINT iincidente2 FOREIGN KEY (incidentecircunscod) REFERENCES public.circunscripcion(circunscripcioncodigo),
	CONSTRAINT iincidente3 FOREIGN KEY (incidenterespid) REFERENCES public.secuser(secuserid),
	CONSTRAINT iincidente4 FOREIGN KEY (incidenteactid) REFERENCES public.actividad(actividadid)
);
CREATE INDEX iincidente1 ON public.incidente USING btree (incidenteorgcod);
CREATE INDEX iincidente2 ON public.incidente USING btree (incidentecircunscod);
CREATE INDEX iincidente3 ON public.incidente USING btree (incidenterespid);
CREATE INDEX iincidente4 ON public.incidente USING btree (incidenteactid);
CREATE INDEX iincidente5 ON public.incidente USING btree (incidenteusuarioid);


-- public.incidentetarea definition

-- Drop table

-- DROP TABLE public.incidentetarea;

CREATE TABLE public.incidentetarea (
	incidentenro int8 NOT NULL,
	inctareafecini timestamp NOT NULL,
	inctareafecfin timestamp NOT NULL,
	inctareadesc text NOT NULL,
	inctareaparteid int4 NOT NULL,
	inctareatecnicoid int4 NOT NULL,
	inctareaadjunto bytea NOT NULL,
	inctareaproblemaid int8 NOT NULL,
	CONSTRAINT incidentetarea_pkey PRIMARY KEY (incidentenro, inctareafecini),
	CONSTRAINT iincidenteincidentetarea1 FOREIGN KEY (incidentenro) REFERENCES public.incidente(incidentenro),
	CONSTRAINT iincidenteincidentetarea3 FOREIGN KEY (inctareatecnicoid) REFERENCES public.secuser(secuserid),
	CONSTRAINT iincidenteincidentetarea4 FOREIGN KEY (inctareaproblemaid) REFERENCES public.problema(problemaid)
);
CREATE INDEX iincidenteincidentetarea2 ON public.incidentetarea USING btree (inctareaparteid);
CREATE INDEX iincidenteincidentetarea3 ON public.incidentetarea USING btree (inctareatecnicoid);
CREATE INDEX iincidentetarea ON public.incidentetarea USING btree (inctareaproblemaid);


-- public.tarea definition

-- Drop table

-- DROP TABLE public.tarea;

CREATE TABLE public.tarea (
	tareaid int8 DEFAULT nextval('tareaid'::regclass) NOT NULL,
	tareafechaini date NOT NULL,
	tareahoraini timestamp NULL,
	tareafechafin date NULL,
	tareahorafin timestamp NULL,
	tareadescripcion varchar(500) NULL,
	tareaestado bpchar(20) NULL,
	tareacasonro int4 NOT NULL,
	tareatecnicoid int4 NULL,
	tareaproblemaid int4 NULL,
	tareaparteid int4 NULL,
	tareaadjunto bytea NULL,
	CONSTRAINT tarea_pkey PRIMARY KEY (tareaid),
	CONSTRAINT itarea1 FOREIGN KEY (tareacasonro) REFERENCES public.casos(casonro),
	CONSTRAINT itarea2 FOREIGN KEY (tareatecnicoid) REFERENCES public.secuser(secuserid),
	CONSTRAINT itarea4 FOREIGN KEY (tareaproblemaid) REFERENCES public.problema(problemaid)
);
CREATE INDEX itarea1 ON public.tarea USING btree (tareacasonro);
CREATE INDEX itarea2 ON public.tarea USING btree (tareatecnicoid);
CREATE INDEX itarea3 ON public.tarea USING btree (tareaparteid);
CREATE INDEX itarea4 ON public.tarea USING btree (tareaproblemaid);