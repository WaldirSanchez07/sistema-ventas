<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReportesGraficos extends Controller
{
    public function reporteVentas(){
        $ventas = DB::select('call ventas_x_mes');
        $productos = DB::select('call productos_mas_vendidos');
        return view('livewire.reportes.rep-ventas', compact('ventas', 'productos'));
    }
}
