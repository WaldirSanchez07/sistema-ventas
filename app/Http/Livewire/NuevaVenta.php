<?php

namespace App\Http\Livewire;

use App\Models\Cliente;
use App\Models\Producto;
use Illuminate\Support\Facades\DB;
use Livewire\Component;

class NuevaVenta extends Component
{
    public $subtotal = 0, $igv = 0, $total = 0; //venta
    public $idCliente, $cliente, $buscarCliente; //cliente
    public $sku, $producto, $stock = 0, $precio = 0; //producto
    public $cantidad, $_subtotal = 0, $__subtotal = 0;
    public $pagado, $vuelto, $descuento, $_descuento = 0;
    public $oldSubtotal;

    public $_cliente = false;
    public $table = array();
    public $add = true, $venta = false;

    public function render()
    {
        $clientes = Cliente::where('nombre', 'like', '%' . $this->buscarCliente . '%')
            ->orWhere('nrodocumento', 'like', '%' . $this->buscarCliente . '%')->paginate(7);

        return view('livewire.ventas.nueva-venta', compact('clientes'));
    }

    public function buscarProducto()
    {
        $producto = Producto::where('id_producto', '=', $this->sku)->first();
        if (!$producto) return;
        $this->producto = $producto->producto;
        $this->stock = $producto->stock;
        $this->precio = $producto->precio_venta;
    }

    public function updatedCantidad()
    {
        if ($this->cantidad > $this->stock) {
            $this->add = false;
            $this->subtotal = 0;
            return;
        } else {
            $cant = (floatval($this->precio) * floatval($this->cantidad)) - $this->descuento ?? 0;
            if ($cant >= 0) {
                $this->add = true;
                $this->_subtotal = $cant ?? 0;
                $this->oldSubtotal = $cant ?? 0;
            }else{
                $this->add = false;
                $this->_subtotal = 0;
                $this->oldSubtotal = 0;
            }
        }
    }

    public function updatedDescuento()
    {
        if ($this->cantidad > 0 && $this->descuento > 0) {
            if ($this->_subtotal > $this->descuento) {
                $this->add = true;
                $cant = floatval($this->oldSubtotal) - floatval($this->descuento);
                $this->_subtotal = $cant ?? 0;
            } else {
                $this->add = false;
                $this->_subtotal = $this->oldSubtotal;
            }
        } else {
            $this->add = true;
            $this->_subtotal = $this->oldSubtotal;
        }
    }

    public function addDetalle()
    {
        $ok = true;
        foreach ($this->table as $i => $value) {
            if ($value['sku'] == $this->sku) {
                $ok = false;
                $this->dispatchBrowserEvent('alertWarning', ['title' => "Advertencia", 'text' => "El producto ya está en el detalle!"]);
            }
        }

        if ($ok) {
            $this->table[] = [
                'sku' => $this->sku,
                'producto' => $this->producto,
                'precio' => $this->precio,
                'cantidad' => $this->cantidad,
                'descuento' => $this->descuento ?? 0,
                'subtotal' => $this->_subtotal,
            ];
            $this->__subtotal += $this->_subtotal;
            $this->igv = floatval($this->__subtotal * 0.18);
            $this->_descuento += $this->descuento ?? 0;
            $this->total = $this->__subtotal;
            $this->subtotal = $this->total - $this->igv;
            $this->limpiarInfoProducto();
            $this->dispatchBrowserEvent('alertSuccess', ['title' => "Detalle venta", 'text' => "El producto se agregó al detalle!"]);
        }
    }

    public function removeDetalle($_sku)
    {
        foreach ($this->table as $i => $value) {
            if ($value['sku'] == $_sku) {
                $this->__subtotal -= $value['subtotal'];
                $this->igv = floatval($this->__subtotal * 0.18);
                $this->_descuento -= $this->descuento ?? 0;
                $this->total = $this->__subtotal;
                $this->subtotal = $this->total - $this->igv;
                unset($this->table[$i]);
                $this->dispatchBrowserEvent('alertSuccess', ['title' => "Detalle venta", 'text' => "El producto se quitó del detalle!"]);
            }
        }
    }

    public function updatedPagado()
    {
        if ($this->subtotal > 0 && $this->pagado >= $this->subtotal) {
            $cant = floatval($this->pagado) - floatval($this->total);
            $this->vuelto = $cant ?? 0;
        } else {
            $this->vuelto = 0;
        }
    }

    public function addCliente(Cliente $model)
    {
        $this->idCliente = $model->id_cliente;
        $this->cliente = $model->nombre;
        $this->_cliente = false;
    }

    public function save()
    {
        if (!$this->idCliente) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Advertencia", 'text' => "Debé agregar un cliente!"]);
            return;
        }

        if (!count($this->table)) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Advertencia", 'text' => "No hay productos en el detalle!"]);
            return;
        }

        if ($this->pagado >= $this->total) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Advertencia", 'text' => "Debe pagar el monto total!"]);
            return;
        }

        DB::beginTransaction();
        try {
            $id = DB::table('venta')->insertGetId([
                'cliente_id' => $this->idCliente,
                'subtotal' => $this->subtotal,
                'igv' => $this->igv,
                'total' => $this->total,
                'fecha' => date('Y-m-d H:i:s')
            ]);

            foreach ($this->table as $i => $value) {
                DB::table('detalle_venta')->insert([
                    'venta_id' => $id,
                    'producto_id' => $value['sku'],
                    'cantidad' => $value['cantidad'],
                    'precio' => $value['precio'],
                    'descuento' => $value['descuento']
                ]);
            }

            DB::commit();
            $this->limpiarCampos();
            return $this->dispatchBrowserEvent('alertSuccess', ['title' => "Nueva venta", 'text' => "Venta registrada!"]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    public function limpiarInfoProducto()
    {
        $this->reset(['sku', 'producto', 'stock', 'precio', 'cantidad', 'descuento', '_subtotal']);
    }

    public function limpiarCampos()
    {
        $this->reset(['pagado', 'vuelto', 'subtotal', 'igv', 'descuento', 'total', 'cliente', '_descuento', 'table']);
        $this->_cliente = false;
        $this->limpiarValidation();
    }

    public function limpiarValidation()
    {
        $this->resetErrorBag();
        $this->resetValidation();
    }
}