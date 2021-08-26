<?php

namespace App\Http\Livewire;

use App\Models\Cliente;
use App\Models\Producto;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Livewire\Component;

class Dashboard extends Component
{
    public function render()
    {
        $ventas = DB::select('call ventas_x_mes');
        $productos = DB::select('call productos_mas_vendidos');
        $ingresos = DB::table('venta')->select(DB::raw('SUM(total) as total'))->get();
        $egresos = DB::table('compra')->select(DB::raw('SUM(total) as total'))->get();
        $inventario = DB::table('kardex')->get()->last();
        $cp = Producto::all()->count();
        $cc = Cliente::all()->count();
        $cu = User::all()->count();
        return view('dashboard', compact('ventas', 'productos', 'ingresos', 'egresos', 'inventario', 'cp', 'cc', 'cu'));
    }
}
