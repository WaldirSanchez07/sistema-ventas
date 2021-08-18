<?php

namespace App\Http\Livewire;

use App\Models\DetalleVenta;
use App\Models\Venta;
use Livewire\Component;

class VentasRealizadas extends Component
{
    public $paginate = 5;
    public $idVenta;

    public $_detalle = false;

    public function render()
    {
        $ventas = Venta::paginate($this->paginate);
        $detalle = DetalleVenta::where('venta_id', '=', $this->idVenta)->get();

        return view('livewire.ventas.realizadas', compact('ventas','detalle'));
    }

    public function verDetalle($id)
    {
        $this->idVenta = $id;
        $this->_detalle = true;
    }
}
