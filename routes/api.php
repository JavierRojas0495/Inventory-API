<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\ProductController;

// Login y logout
Route::post('/login', [AuthController::class, 'login']);
// Registro público (usuarios normales)
Route::post('/register', [AuthController::class, 'register']);

Route::middleware('auth:sanctum')->post('/logout', [AuthController::class, 'logout']);
// Registro privado (admins autenticados crean usuarios con rol)
Route::middleware('auth:sanctum')->post('/admin/register', [AuthController::class, 'adminRegister']);

Route::middleware('auth:sanctum')->group(function () {
    // Productos
    Route::get('/products', [ProductController::class, 'index']);
    Route::get('/products/{id}', [ProductController::class, 'show']);
    Route::post('/products', [ProductController::class, 'store']);
    Route::put('/products/{id}', [ProductController::class, 'update']);
    Route::delete('/products/{id}', [ProductController::class, 'destroy']);
});

// Test route
Route::get('/test', function () {
    return response()->json(['message' => 'API is working']);
});
