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

### Registro normal (`/api/register`)
```json
{
  "name": "Juan Pérez",
  "email": "juan@example.com",
  "password": "secret123",
  "password_confirmation": "secret123"
}
```

### Registro por admin (`/api/admin/register`)
```json
{
  "name": "Ana Admin",
  "email": "ana@example.com",
  "password": "admin123",
  "password_confirmation": "admin123",
  "role": "admin"
}
```

> Este endpoint requiere autenticación con un token de un usuario con rol `admin`.

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

| Método | Endpoint               | Descripción                        |
|--------|------------------------|------------------------------------|
| GET    | /api/products          | Lista todos los productos          |
| GET    | /api/products/{id}     | Muestra un producto específico     |
| POST   | /api/products          | Crea un nuevo producto             |
| PUT    | /api/products/{id}     | Actualiza un producto              |
| DELETE | /api/products/{id}     | Elimina un producto                |

## 🧾 Detalles del Registro

### Crear producto (`/api/products`)

```json
{
  "name": "Laptop Dell XPS 13",
  "description": "Ultrabook de 13 pulgadas con procesador Intel i7",
  "price": 1299.99,
  "stock": 20
}
```

### Actualizar producto (`/api/products/{id}`)

```json
{
  "name": "Laptop Dell XPS 13 - Edición 2024",
  "description": "Actualización con procesador Intel i9 y pantalla OLED",
  "price": 1599.99,
  "stock": 15
}
```

###  Consultar un producto (`/api/products/1`)

```json
{
  "id": 1,
  "name": "Laptop Dell XPS 13",
  "description": "Ultrabook de 13 pulgadas con procesador Intel i7",
  "price": 1299.99,
  "stock": 20,
  "created_at": "2025-06-06T12:34:56.000000Z",
  "updated_at": "2025-06-06T12:34:56.000000Z"
}
```

> Todos los endpoints de creación, edición y eliminación requieren autenticación con un usuario de rol `admin`.

---

## 📄 Licencia

Este proyecto está bajo la licencia [MIT](https://opensource.org/licenses/MIT).

---

## 🙌 Autor

Desarrollado por **Javier Rojas**  
¡Gracias por revisar este proyecto! 💻
