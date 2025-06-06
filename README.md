
<p align="center">
  <img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo">
</p>

<p align="center">
  <a href="#"><img src="https://img.shields.io/badge/build-passing-brightgreen" alt="Build Status"></a>
  <a href="#"><img src="https://img.shields.io/badge/version-1.0.0-blue" alt="Version"></a>
  <a href="#"><img src="https://img.shields.io/badge/license-MIT-lightgrey" alt="License"></a>
</p>

# Laravel API - Users & Products Module

Este proyecto proporciona una API RESTful desarrollada en Laravel para la gestión de usuarios y productos. Está diseñado para facilitar la administración de datos mediante endpoints organizados y protegidos con autenticación de usuario.

---

## 🔧 Requisitos

- PHP >= 8.1
- Composer
- Laravel 10+
- MySQL o cualquier base de datos compatible
- Postman o herramienta similar para testear la API

---

## 🚀 Instalación

```bash
git clone https://github.com/tu-usuario/tu-repo.git
cd tu-repo
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
```

---

## 🔐 Autenticación

Este proyecto utiliza autenticación basada en roles. Solo los usuarios con el rol `admin` pueden crear, editar o eliminar productos o usuarios.

---

## 📦 API Endpoints

### 🧑‍💼 Users

| Método | Endpoint             | Descripción                        |
|--------|----------------------|------------------------------------|
| GET    | /api/users           | Lista todos los usuarios           |
| GET    | /api/users/{id}      | Muestra un usuario específico      |
| POST   | /api/users           | Crea un nuevo usuario              |
| PUT    | /api/users/{id}      | Actualiza un usuario               |
| DELETE | /api/users/{id}      | Elimina un usuario                 |

### 📦 Products

| Método | Endpoint               | Descripción                        |
|--------|------------------------|------------------------------------|
| GET    | /api/products          | Lista todos los productos          |
| GET    | /api/products/{id}     | Muestra un producto específico     |
| POST   | /api/products          | Crea un nuevo producto             |
| PUT    | /api/products/{id}     | Actualiza un producto              |
| DELETE | /api/products/{id}     | Elimina un producto                |

> Todos los endpoints de creación, edición y eliminación requieren autenticación con un usuario de rol `admin`.

---

## 📄 Licencia

Este proyecto está bajo la licencia [MIT](https://opensource.org/licenses/MIT).

---

## 🙌 Autor

Desarrollado por [Tu Nombre] – ¡Gracias por revisar este proyecto!

