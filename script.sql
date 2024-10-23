#create dabase
create database cultura_db;

#change database
use cultura_db;

#create tables in cultura_db

#LUGAR
create table lugar
(
    id_lugar int not null auto_increment,
    nombre varchar(100) not null,
    descripcion varchar(100) not null,
    ubicacion varchar(100) not null,
    visible boolean not null,
    primary key (id_lugar)
);

#CATEGORIA
create table categoria
(
    id_categoria int not null auto_increment,
    nombre_categoria varchar(100) not null,
    descripcion varchar(100) not null,
    primary key (id_categoria)
);

#LUGAR_CATEGORIA
create table lugar_categoria
(
    id_lugar_categoria int not null auto_increment,
    id_lugar int not null,
    id_categoria int not null,
    primary key (id_lugar_categoria),
    foreign key (id_lugar) references lugar(id_lugar),
    foreign key (id_categoria) references categoria(id_categoria)
);

#USUARIO
create table usuario
(
    id_usuario int not null auto_increment,
    nombre_completo varchar(100) not null,
    email varchar(100) unique not null,
    contrasena varchar(100) not null,
    fecha_registro timestamp,
    primary key(id_usuario)
);

#CALIFICACION
create table calificacion
(
    id_calificacion int not null auto_increment,
    id_usuario int not null,
    id_lugar int not null,
    puntacion int, # acepta valor de 1 a 5
    fecha_calificacion timestamp,
    primary key (id_calificacion),
    foreign key (id_usuario) references usuario(id_usuario),
    foreign key (id_lugar) references lugar(id_lugar)
);

#FAVORITO
create table favorito
(
    id_favorito int not null auto_increment,
    id_usuario int not null,
    id_lugar int not null,
    fecha_guardado timestamp,
    primary key (id_favorito),
    foreign key (id_usuario) references usuario(id_usuario),
    foreign key (id_lugar) references lugar(id_lugar)
);

#ROL
create table rol
(
    id_rol int not null auto_increment,
    nombre_rol varchar(100) not null,
    descripcion varchar(100) not null,
    primary key (id_rol)
);

#ROL_USER
create table usuario_rol
(
    id_usuario_rol int not null auto_increment,
    id_usuario int not null,
    id_rol int not null,
    primary key (id_usuario_rol),
    foreign key (id_usuario) references usuario(id_usuario),
    foreign key (id_rol) references rol(id_rol)
);

#COMENTARIO
create table comentario
(
    id_comentario int not null auto_increment,
    id_usuario int not null,
    id_lugar int not null,
    text_comentario varchar(100) not null,
    fecha_comentarion timestamp,
    primary key (id_comentario),
    foreign key (id_usuario) references usuario(id_usuario),
    foreign key (id_lugar) references lugar(id_lugar)
);

#FOTO
create table foto
(
    id_foto int not null auto_increment,
    id_lugar int not null,
    ruta_foto varchar(300) not null,
    descripcion varchar(100) not null,
    primary key (id_foto),
    foreign key (id_lugar) references lugar(id_lugar)
);

