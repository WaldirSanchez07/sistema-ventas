<?php

namespace App\Http\Livewire;

use App\Models\Compra;
use App\Models\DetalleCompra;
use Livewire\Component;
use Livewire\WithPagination;

class ComprasRealizadas extends Component
{
    use WithPagination;
    protected $paginationTheme = 'simple-bootstrap';
    public $paginate = 5;
    public $idCompra;

    public $_detalle = false;

    public function render()
    {
        $compras = Compra::orderBy('id_compra','DESC')->paginate($this->paginate);
        $detalle = DetalleCompra::where('compra_id', '=', $this->idCompra)->get();

        return view('livewire.compras.realizadas', compact('compras', 'detalle'));
    }

    public function verDetalle($id)
    {
        $this->idCompra = $id;
        $this->_detalle = true;
    }
}
