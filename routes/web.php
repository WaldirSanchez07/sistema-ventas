<?php

use App\Http\Controllers\AuthController;
use App\Http\Livewire\AdmProductos;
use App\Http\Livewire\Categorias;
use App\Http\Livewire\Clientes;
use App\Http\Livewire\SubCategorias;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/clear-cache', function() {
    Artisan::call('cache:clear');
    return "Cache is cleared";
});

Route::post('/signin', [AuthController::class, 'login'])->name('signin');
Route::get('logout', [AuthController::class, 'logout'])->name('logout');

Route::get('/', function () {
    return view('welcome');
});

Route::middleware(['auth:sanctum', 'verified'])->get('/dashboard', function () {
    return view('dashboard');
})->name('dashboard');

Route::middleware(['auth:sanctum', 'verified'])->get('/clientes', Clientes::class )->name('clientes');
Route::middleware(['auth:sanctum', 'verified'])->get('/categorias', Categorias::class )->name('categorias');
Route::middleware(['auth:sanctum', 'verified'])->get('/sub-categorias', SubCategorias::class )->name('sub-categorias');
Route::middleware(['auth:sanctum', 'verified'])->get('/adm-productos', AdmProductos::class )->name('adm-productos');