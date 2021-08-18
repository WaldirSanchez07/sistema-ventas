<?php

use App\Http\Controllers\AuthController;
use App\Http\Livewire\AdmProductos;
use App\Http\Livewire\Categorias;
use App\Http\Livewire\Clientes;
use App\Http\Livewire\NuevaVenta;
use App\Http\Livewire\Productos;
use App\Http\Livewire\Proveedores;
use App\Http\Livewire\SubCategorias;
use App\Http\Livewire\Cajas;
use App\Http\Livewire\VentasRealizadas;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Route;


Route::get('/clear-cache', function() {
    Artisan::call('cache:clear');
    return "Cache is cleared";
});

Route::post('/signin', [AuthController::class, 'login'])->name('signin');
Route::get('logout', [AuthController::class, 'logout'])->name('logout');

Route::get('/', function () {
    return view('auth/login');
});

Route::middleware(['auth:sanctum', 'verified'])->get('/dashboard', function () {
    return view('dashboard');
})->name('dashboard');

Route::middleware(['auth:sanctum', 'verified'])->get('/clientes', Clientes::class )->name('clientes');
Route::middleware(['auth:sanctum', 'verified'])->get('/categorias', Categorias::class )->name('categorias');
Route::middleware(['auth:sanctum', 'verified'])->get('/sub-categorias', SubCategorias::class )->name('sub-categorias');
Route::middleware(['auth:sanctum', 'verified'])->get('/adm-productos', AdmProductos::class )->name('adm-productos');
Route::middleware(['auth:sanctum', 'verified'])->get('/proveedores', Proveedores::class )->name('proveedores');
Route::middleware(['auth:sanctum', 'verified'])->get('/productos', Productos::class )->name('productos');
Route::middleware(['auth:sanctum', 'verified'])->get('/nueva-venta', NuevaVenta::class )->name('nueva-venta');
Route::middleware(['auth:sanctum', 'verified'])->get('/caja', Cajas::class )->name('caja');
Route::middleware(['auth:sanctum', 'verified'])->get('/ventas-realizadas', VentasRealizadas::class )->name('ventas-realizadas');
