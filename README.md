<p align="center">
  <img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo">
</p>

<p align="center">
  <a href="#"><img src="https://img.shields.io/badge/build-passing-brightgreen" alt="Build Status"></a>
  <a href="#"><img src="https://img.shields.io/badge/version-1.0.0-blue" alt="Version"></a>
  <a href="#"><img src="https://img.shields.io/badge/license-MIT-lightgrey" alt="License"></a>
</p>

# Laravel API - Autenticación de Usuarios

Este proyecto es una API RESTful desarrollada en Laravel que gestiona autenticación de usuarios con soporte para registro, login, logout y registro de usuarios por administradores. Utiliza Laravel Sanctum para manejar tokens de autenticación.

---

## 🔧 Requisitos

- PHP >= 8.1
- Composer
- Laravel 10+
- MySQL o base de datos compatible
- Postman o Insomnia para probar endpoints

---

## 🚀 Instalación

```bash
git clone https://github.com/JavierRojas0495/Inventory-API.git
cd Inventory-API
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
```

---

## 🔐 Autenticación

El sistema utiliza **Laravel Sanctum** para generar tokens personales. Los usuarios deben autenticarse con su correo y contraseña para obtener un token que permita acceder a endpoints protegidos.

---

## 📦 API Endpoints - Autenticación de Usuarios

| Método | Endpoint                | Descripción                                          | Autenticación |
|--------|-------------------------|------------------------------------------------------|---------------|
| POST   | /api/register           | Registro de usuario (rol por defecto: `user`)        | ❌ No         |
| POST   | /api/admin/register     | Registro de usuario por un admin                     | ✅ Sí (admin) |
| POST   | /api/login              | Inicio de sesión y generación de token               | ❌ No         |
| POST   | /api/logout             | Cierre de sesión (revoca todos los tokens del usuario) | ✅ Sí         |

---

## 🧾 Detalles del Registro

### 🧍 Registro de usuario (`/api/register`)

**📬 Método:** `POST`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/register`  
**🔓 Autenticación requerida:** ❌ No

#### 📥 Encabezados requeridos

| Clave         | Valor             |
|---------------|-------------------|
| Content-Type  | application/json  |

#### 🧾 Ejemplo de cuerpo (Body)

```json
{
  "name": "Juan Pérez",
  "email": "juan@example.com",
  "password": "secret123",
  "password_confirmation": "secret123"
}
```

### Resultado de la peticion

```json
{
    "message": "Usuario registrado exitosamente.",
    "user": {
        "name": "Juan Pérez",
        "email": "juan@example.com",
        "role": "user",
        "updated_at": "2025-06-07T16:33:45.000000Z",
        "created_at": "2025-06-07T16:33:45.000000Z",
        "id": 1
    }
}
```

### 👩‍💼 Registro por admin (`/api/admin/register`)

**📬 Método:** `POST`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/admin/register`  
**🔓 Autenticación requerida:** ✅ Sí (token Bearer de un usuario con rol `admin`)

#### 📥 Encabezados requeridos

| Clave         | Valor               |
|---------------|---------------------|
| Content-Type  | application/json    |
| Authorization | Bearer {token}      |
| Accept | application/json    |

#### 🧾 Ejemplo de cuerpo (Body)

```json
{
  "name": "Ana Admin",
  "email": "ana@example.com",
  "password": "admin123",
  "password_confirmation": "admin123",
  "role": "admin"
}
```

### Resultado de la peticion

```json
{
    "message": "Usuario registrado exitosamente por el admin.",
    "user": {
        "name": "Ana Admin",
        "email": "ana@example.com",
        "role": "admin",
        "updated_at": "2025-06-07T17:22:26.000000Z",
        "created_at": "2025-06-07T17:22:26.000000Z",
        "id": 2
    }
}
```

> Este endpoint requiere autenticación con un token de un usuario con rol `admin`.

### 🧍 Login (`/api/login`)

**📬 Método:** `POST`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/login`  
**🔓 Autenticación requerida:** ❌ No

#### 🧾 Ejemplo de cuerpo (Body)

```json
{
  "email": "admin@example.com",
  "password": "123456"
}
```

### Resultado de la peticion

```json
{
    "access_token": "2|qIZlHqzGvrB0h7KZVZJDNueZx49DwwWn9BkBDydM32d37aec",
    "token_type": "Bearer"
}
```

### 🧍 Logout (`/api/logout`)

**📬 Método:** `POST`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/logout`  
**🔓 Autenticación requerida:** ✅ Sí (token Bearer de un usuario con rol)

#### 📥 Encabezados requeridos

| Clave         | Valor               |
|---------------|---------------------|
| Authorization | Bearer {token}      |
| Accept | application/json    |

### Resultado de la peticion

```json
{
    "message": "Logged out successfully"
}
```

---

## 🛡️ Seguridad

- Autenticación mediante **Bearer Token** generado por Laravel Sanctum.
- Validaciones robustas en todos los formularios de registro.
- Solo usuarios con el rol `admin` pueden registrar a otros usuarios como `admin`.

---

## 🔐 Autenticación

Este proyecto utiliza autenticación basada en roles. Solo los usuarios con el rol `admin` pueden crear, editar o eliminar productos o usuarios.

---

### 📦 Products

| Método | Endpoint           | Descripción                    | Autenticación |
| ------ | ------------------ | ------------------------------ | ------------- |
| GET    | /api/products      | Lista todos los productos      | ✅ Sí          |
| GET    | /api/products/{id} | Muestra un producto específico | ✅ Sí          |
| POST   | /api/products      | Crea un nuevo producto         | ✅ Sí (admin)  |
| PUT    | /api/products/{id} | Actualiza un producto          | ✅ Sí (admin)  |
| DELETE | /api/products/{id} | Elimina un producto            | ✅ Sí (admin)  |

## 🧾 Detalles del Registro

### Listar producto (`/api/products`)

**📬 Método:** `POST`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/products`  
**🔓 Autenticación requerida:** ✅ Sí (token Bearer de un usuario con rol)

#### 📥 Encabezados requeridos

| Clave         | Valor               |
|---------------|---------------------|
| Authorization | Bearer {token}      |
| Accept        | application/json    |

### Resultado de la peticion

```json
{
    "message": "Lista de productos",
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 1,
                "category_id": 6,
                "name": "Camiseta Adidas",
                "description": "Camiseta tipo Polo Negra",
                "price": "29.99",
                "stock": 100,
                "created_at": "2025-06-07T16:40:55.000000Z",
                "updated_at": "2025-06-07T16:43:57.000000Z",
                "category": {
                    "id": 6,
                    "name": "Moda",
                    "description": "Ropa, calzado y accesorios",
                    "created_at": "2025-06-07T16:40:41.000000Z",
                    "updated_at": "2025-06-07T16:40:41.000000Z"
                }
            }
        ],
        "first_page_url": "http://inventory-api-1u4p.onrender.com/api/products?page=1",
        "from": 1,
        "last_page": 1,
        "last_page_url": "http://inventory-api-1u4p.onrender.com/api/products?page=1",
        "links": [
            {
                "url": null,
                "label": "&laquo; Previous",
                "active": false
            },
            {
                "url": "http://inventory-api-1u4p.onrender.com/api/products?page=1",
                "label": "1",
                "active": true
            },
            {
                "url": null,
                "label": "Next &raquo;",
                "active": false
            }
        ],
        "next_page_url": null,
        "path": "http://inventory-api-1u4p.onrender.com/api/products",
        "per_page": 10,
        "prev_page_url": null,
        "to": 1,
        "total": 1
    }
}
```

### Crear producto (`/api/products`)

**📬 Método:** `POST`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/products`  
🔓 Autenticación requerida: ✅ Sí (admin)

| Clave         | Valor            |
| ------------- | ---------------- |
| Authorization | Bearer {token}   |
| Accept        | application/json |
| Content-Type  | application/json |

🧾 Ejemplo de cuerpo (Body)
```json
{
  "category_id": 1,
  "name": "Laptop Dell XPS 13",
  "description": "Ultrabook de 13 pulgadas con procesador Intel i7",
  "price": 1299.99,
  "stock": 20
}
```

Resultado de la petición

```json
{
    "message": "Product created successfully",
    "product": {
        "category_id": 1,
        "name": "Laptop Dell XPS 13",
        "description": "Ultrabook de 13 pulgadas con procesador Intel i7",
        "price": 1299.99,
        "stock": 20,
        "updated_at": "2025-06-08T16:32:47.000000Z",
        "created_at": "2025-06-08T16:32:47.000000Z",
        "id": 3
    }
}
```

### Actualizar producto (`/api/products/1`)

**📬 Método:** `PUT`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/products/3`  
🔓 Autenticación requerida: ✅ Sí (admin)

🧾 Ejemplo de cuerpo (Body)
```json
{
 "category_id": 1,
 "name": "Laptop Dell XPS 16",
 "description": "Ultrabook de 15 pulgadas con procesador Intel i7",
 "price": 1600,
 "stock": 10
}
```

Resultado de la petición

```json
{
    "message": "Producto actualizado",
    "product": {
        "id": 3,
        "category_id": 1,
        "name": "Laptop Dell XPS 16",
        "description": "Ultrabook de 15 pulgadas con procesador Intel i7",
        "price": 1600,
        "stock": 10,
        "created_at": "2025-06-08T16:32:47.000000Z",
        "updated_at": "2025-06-08T16:34:10.000000Z"
    }
}
```

### Consultar un producto (`/api/products/1`)

**📬 Método:** `GET`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/products/1`  
🔓 Autenticación requerida: ✅ Sí

Resultado de la petición

```json
{
    "id": 3,
    "category_id": 1,
    "name": "Laptop Dell XPS 16",
    "description": "Ultrabook de 15 pulgadas con procesador Intel i7",
    "price": "1600.00",
    "stock": 10,
    "created_at": "2025-06-08T16:32:47.000000Z",
    "updated_at": "2025-06-08T16:34:10.000000Z",
    "category": {
        "id": 1,
        "name": "Tecnología",
        "description": "Productos relacionados con computadoras, gadgets y software",
        "created_at": "2025-06-07T16:40:41.000000Z",
        "updated_at": "2025-06-07T16:40:41.000000Z"
    }
}
```

### ❌ Eliminar producto (`/api/products/{id}`)

**📬 Método:** `DELETE`  
**📍 URL:** `https://inventory-api-1u4p.onrender.com/api/products/1`  
🔓 Autenticación requerida: ✅ Sí (admin)

> Todos los endpoints de creación, edición y eliminación requieren autenticación con un usuario de rol `admin`.

---

## 📄 Licencia

Este proyecto está bajo la licencia [MIT](https://opensource.org/licenses/MIT).

---

## 📂 Repositorio

🔗 [GitHub - Inventory API](https://github.com/JavierRojas0495/Inventory-API)  
🌐 Producción: [https://laravel-inventory.onrender.com](https://laravel-inventory.onrender.com)

---

## 📬 Colección de Postman

En la raíz del proyecto encontrarás el archivo **Inventario API.postman_collection.json**, que contiene la colección de Postman con todas las rutas disponibles de la API.

Puedes importar esta colección en Postman y utilizarla directamente con el entorno en producción desplegado en Render:

🔗 **Base URL**: `https://laravel-inventory.onrender.com`

> Asegúrate de configurar una variable de entorno en Postman con el nombre:
> 
> ```
> base_url = https://laravel-inventory.onrender.com
> ```

---

## 📬 Contacto

Desarrollado por **Javier Rojas**  
✉️ Email: [javier.andres.rojas.erazo@gmail.com](mailto:javier.andres.rojas.erazo@gmail.com)
