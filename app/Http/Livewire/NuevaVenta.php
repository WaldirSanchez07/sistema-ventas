<?php

namespace App\Http\Livewire;

use Livewire\Component;

class NuevaVenta extends Component
{
    public $cliente, $documento, $nDoc; //cliente
    public $producto, $sku, $cantidad; //producto
    public $stock = 0; //producto
    public $precio = 0; //producto
    public $_subtotal = 0;

    public $porcent = 0;
    public $pagado;
    public $vuelto = 0;
    public $igv = 0;
    public $descuento = 0;
    public $total = 0;
    public $subtotal = 0;

    public $_clientes = false;
    public $_productos = false;
    public $active = false;
    public $sCliente, $sProducto;

    public $table = array();

    public function render()
    {
        return view('livewire.ventas.nueva-venta');
    }
}
