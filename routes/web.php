<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ReportesGraficos;
use App\Http\Livewire\AdmProductos;
use App\Http\Livewire\Categorias;
use App\Http\Livewire\Clientes;
use App\Http\Livewire\ComprasRealizadas;
use App\Http\Livewire\Dashboard;
use App\Http\Livewire\InfoEmpresa;
use App\Http\Livewire\Kardex;
use App\Http\Livewire\NuevaCompra;
use App\Http\Livewire\NuevaVenta;
use App\Http\Livewire\Productos;
use App\Http\Livewire\Proveedores;
use App\Http\Livewire\SubCategorias;
use App\Http\Livewire\Cajas;
use App\Http\Livewire\ReporteMovimientos;
use App\Http\Livewire\Usuarios;
use App\Http\Livewire\VentasRealizadas;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Route;

Route::get('/clear-cache', function () {
    Artisan::call('cache:clear');
    return "Cache is cleared";
});

Route::post('/signin', [AuthController::class, 'login'])->name('signin');
Route::get('logout', [AuthController::class, 'logout'])->name('logout');

Route::get('/', function () {
    return view('auth/login');
});

Route::middleware(['auth:sanctum', 'verified'])->get('/dashboard', Dashboard::class)->name('dashboard');

Route::middleware(['auth:sanctum', 'verified', 'auth2:A,V'])->get('/clientes', Clientes::class)->name('clientes');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A'])->get('/categorias', Categorias::class)->name('categorias');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A'])->get('/sub-categorias', SubCategorias::class)->name('sub-categorias');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A'])->get('/adm-productos', AdmProductos::class)->name('adm-productos');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A'])->get('/proveedores', Proveedores::class)->name('proveedores');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,V'])->get('/productos', Productos::class)->name('productos');
Route::middleware(['auth:sanctum', 'verified', 'auth2:V'])->get('/nueva-venta', NuevaVenta::class)->name('nueva-venta');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,V'])->get('/ventas', VentasRealizadas::class)->name('ventas');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A'])->get('/nueva-compra', NuevaCompra::class)->name('nueva-compra');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,C'])->get('/kardex', Kardex::class)->name('kardex');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,V,C'])->get('/factura-venta/{id}', [VentasRealizadas::class, 'pdf']);
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,C'])->get('/tarjeta-kardex/{id?}', [Kardex::class, 'pdf']);
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,V,C'])->get('/reporte-movimiento', [ReporteMovimientos::class, 'pdf'])->name('rep-movimientos');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,C'])->get('/compras', ComprasRealizadas::class)->name('compras');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A'])->get('/info-empresa', InfoEmpresa::class)->name('empresa');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A'])->get('/usuarios', Usuarios::class)->name('usuarios');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,C'])->get('/reporte-ventas', [ReportesGraficos::class, 'reporteVentas'])->name('rep-ventas');
Route::middleware(['auth:sanctum', 'verified', 'auth2:A,V'])->get('/caja', Cajas::class )->name('caja');

Route::get('no-autorizado', function(){
    abort('403');
});

Route::get('error', function(){
    abort('404');
});
