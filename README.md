# Documentación de app_cultura_db

## Descripción General de la Base de Datos
`cultura_db` es una base de datos diseñada para gestionar lugares culturales, interacciones de usuarios y contenido relacionado. La base de datos soporta funcionalidades como calificaciones de usuarios, favoritos, comentarios y gestión de fotos para ubicaciones culturales.

## Estructura de Tablas

### Lugar
Almacena información sobre lugares/ubicaciones culturales.
```sql
CREATE TABLE lugar (
    id_lugar INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,      -- Nombre del lugar
    descripcion VARCHAR(100) NOT NULL,  -- Descripción del lugar
    ubicacion VARCHAR(100) NOT NULL,    -- Ubicación
    visible BOOLEAN NOT NULL,           -- Estado de visibilidad
    PRIMARY KEY (id_lugar)
);
```

### Categoria
Gestiona las categorías para clasificar lugares.
```sql
CREATE TABLE categoria (
    id_categoria INT NOT NULL AUTO_INCREMENT,
    nombre_categoria VARCHAR(100) NOT NULL, -- Nombre de la categoría
    descripcion VARCHAR(100) NOT NULL,      -- Descripción de la categoría
    PRIMARY KEY (id_categoria)
);
```

### Lugar_Categoria
Tabla de unión que conecta lugares con sus categorías.
```sql
CREATE TABLE lugar_categoria (
    id_lugar_categoria INT NOT NULL AUTO_INCREMENT,
    id_lugar INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_lugar_categoria),
    FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);
```

### Usuario
Almacena información de usuarios.
```sql
CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre_completo VARCHAR(100) NOT NULL, -- Nombre completo
    email VARCHAR(100) UNIQUE NOT NULL,    -- Correo electrónico único
    contrasena VARCHAR(100) NOT NULL,      -- Contraseña
    fecha_registro TIMESTAMP,              -- Fecha de registro
    PRIMARY KEY(id_usuario)
);
```

### Calificacion
Gestiona las calificaciones de usuarios para los lugares.
```sql
CREATE TABLE calificacion (
    id_calificacion INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_lugar INT NOT NULL,
    puntacion INT,                    -- Valor de calificación (1-5)
    fecha_calificacion TIMESTAMP,     -- Fecha de calificación
    PRIMARY KEY (id_calificacion),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar)
);
```

### Favorito
Registra los lugares favoritos de los usuarios.
```sql
CREATE TABLE favorito (
    id_favorito INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_lugar INT NOT NULL,
    fecha_guardado TIMESTAMP,         -- Fecha de guardado como favorito
    PRIMARY KEY (id_favorito),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar)
);
```

### Rol
Define los roles de usuario en el sistema.
```sql
CREATE TABLE rol (
    id_rol INT NOT NULL AUTO_INCREMENT,
    nombre_rol VARCHAR(100) NOT NULL,  -- Nombre del rol
    descripcion VARCHAR(100) NOT NULL, -- Descripción del rol
    PRIMARY KEY (id_rol)
);
```

### Usuario_Rol
Tabla de unión que conecta usuarios con sus roles.
```sql
CREATE TABLE usuario_rol (
    id_usuario_rol INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_rol INT NOT NULL,
    PRIMARY KEY (id_usuario_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);
```

### Comentario
Almacena comentarios de usuarios sobre lugares.
```sql
CREATE TABLE comentario (
    id_comentario INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_lugar INT NOT NULL,
    text_comentario VARCHAR(100) NOT NULL, -- Texto del comentario
    fecha_comentarion TIMESTAMP,           -- Fecha del comentario
    PRIMARY KEY (id_comentario),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar)
);
```

### Foto
Gestiona fotos asociadas a lugares.
```sql
CREATE TABLE foto (
    id_foto INT NOT NULL AUTO_INCREMENT,
    id_lugar INT NOT NULL,
    ruta_foto VARCHAR(300) NOT NULL,    -- Ruta de la foto
    descripcion VARCHAR(100) NOT NULL,   -- Descripción de la foto
    PRIMARY KEY (id_foto),
    FOREIGN KEY (id_lugar) REFERENCES lugar(id_lugar)
);
```

## Relaciones

1. Un lugar puede tener:
   - Múltiples categorías
   - Múltiples calificaciones
   - Ser marcado como favorito por múltiples usuarios
   - Múltiples comentarios
   - Múltiples fotos

2. Un usuario puede:
   - Tener múltiples roles
   - Dar múltiples calificaciones
   - Tener múltiples favoritos
   - Hacer múltiples comentarios

3. Una categoría puede:
   - Estar asociada a múltiples lugares

4. Un rol puede:
   - Ser asignado a múltiples usuarios

## Notas Técnicas
- Todas las tablas usan `INT` AUTO_INCREMENT para las claves primarias
- Se utilizan timestamps para rastrear fechas de creación
- Los correos electrónicos deben ser únicos
- El sistema de calificación acepta valores del 1 al 5
- Las rutas de fotos pueden almacenar hasta 300 caracteres
