<?php

namespace App\Http\Livewire;

use App\Models\Producto;
use App\Models\Proveedor;
use App\Models\Caja;
use Illuminate\Support\Facades\DB;
use Livewire\Component;

class NuevaCompra extends Component
{
    public $subtotal = 0, $igv = 0, $total = 0; //compra
    public $idProveedor, $proveedor, $search; //proveedor
    public $sku, $producto, $stock = 0, $precio; //producto
    public $cantidad, $_subtotal = 0, $__subtotal = 0;
    public $pagado, $vuelto, $descuento, $_descuento = 0;
    public $oldSubtotal;

    public $_proveedor = false;
    public $table = array();
    public $add = true, $compra = false;

    public function render()
    {
        $proveedores = Proveedor::where('raz_social', 'like', '%' . $this->search . '%')
            ->orWhere('nrodocumento', 'like', '%' . $this->search . '%')
            ->orWhere('contacto', 'like', '%' . $this->search . '%')->paginate(7);

        return view('livewire.compras.nueva', compact('proveedores'));
    }

    public function buscarProducto()
    {
        $movimientos = Caja::all();
         $cantdatos = $movimientos->count();
        if ($cantdatos == null) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "Debe aperturar caja!"]);
            return;
        }
        if ($this->sku == null) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "No ha ingresado el SKU!!"]);
            return;
        }
        $producto = Producto::where('id_producto', '=', $this->sku)->first();
        if (!$producto) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "SKU no encontrado!!"]);
            return;
        }
        $this->producto = $producto->producto;
        $this->stock = $producto->stock;
    }

    public function updatedCantidad()
    {
        $cant = (floatval($this->precio) * floatval($this->cantidad)) - $this->descuento ?? 0;
        if ($cant >= 0) {
            $this->add = true;
            $this->_subtotal = $cant ?? 0;
            $this->oldSubtotal = $cant ?? 0;
        } else {
            $this->add = false;
            $this->_subtotal = 0;
            $this->oldSubtotal = 0;
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
        $movimientos = Caja::all();
         $cantdatos = $movimientos->count();
        if ($cantdatos == null) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "Debe aperturar caja!"]);
            return;
        }
        if ($this->producto == null) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "No ha seleccionado el producto!!"]);
            return;
        }
        if ($this->precio == null) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "No ha ingresado el precio!!"]);
            return;
        }
        if ($this->cantidad == null) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "No ha ingresado la cantidad!!"]);
            return;
        }
        
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
            $this->dispatchBrowserEvent('alertSuccess', ['title' => "Detalle compra", 'text' => "El producto se agregó al detalle!"]);
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
                $this->dispatchBrowserEvent('alertSuccess', ['title' => "Detalle compra", 'text' => "El producto se quitó del detalle!"]);
            }
        }
    }

    public function updatedPagado()
    {
        if ($this->subtotal > 0 && $this->pagado >= $this->subtotal) {
            $cant = floatval($this->pagado) - floatval($this->total);
            if ($cant < 0){
                $this->vuelto = 0;
            }else{
                $this->vuelto = $cant ?? 0;
            }
        } else {
            $this->vuelto = 0;
        }
    }

    public function addCliente(Proveedor $model)
    {
        $movimientos = Caja::all();
        $cantdatos = $movimientos->count();
        if ($cantdatos == null) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "Debe aperturar caja!"]);
            return;
        }
        $this->idProveedor = $model->id_proveedor;
        $this->proveedor = $model->raz_social;
        $this->_proveedor = false;
    }

    public function save()
    {
        $movimientos = Caja::all();
        $cantdatos = $movimientos->count();
        if ($cantdatos == null) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "Debe aperturar caja!"]);
            return;
        }
        if (!count($this->table)) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Advertencia", 'text' => "No hay productos en el detalle!"]);
            return;
        }
        if (!$this->idProveedor) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Advertencia", 'text' => "Debé agregar un cliente!"]);
            return;
        }
        if ($this->pagado < $this->total) {
            $this->dispatchBrowserEvent('alertWarning', ['title' => "Advertencia", 'text' => "Debe pagar el monto total!"]);
            return;
        }

        DB::beginTransaction();
        try {
            $id = DB::table('compra')->insertGetId([
                'proveedor_id' => $this->idProveedor,
                'subtotal' => $this->subtotal,
                'igv' => $this->igv,
                'total' => $this->total,
                'fecha' => date('Y-m-d H:i:s')
            ]);

            foreach ($this->table as $i => $value) {
                DB::table('detalle_compra')->insert([
                    'compra_id' => $id,
                    'producto_id' => $value['sku'],
                    'cantidad' => $value['cantidad'],
                    'precio' => $value['precio'],
                    'descuento' => $value['descuento']
                ]);
            }

            DB::commit();
            
            /* Registrando en caja la compra*/
            $lastregister = Caja::whereRaw('id_caja = (select max(`id_caja`) from caja)')->first();
            if ($lastregister->saldo < $this->total) {
                $this->dispatchBrowserEvent('alertWarning', ['title' => "Atención", 'text' => "Saldo insuficiente en caja. Por favor ingresar dinero!!"]);
                return;
            }

            $descripcion = "Compra";
            $tipoMovimiento = 0 ;
            $monto=$this->total*-1;
            $saldo=0;
            $estado = 1;

            $datos = array("descripcion"=>$descripcion, "tipoMovimiento"=>$tipoMovimiento,"monto"=>$monto , "saldo"=>$saldo , "estado"=>$estado);
            Caja::create($datos);
            DB::select('call Actualizar()');

            DB::table('usuario_compra')->insert([
                'usuario_id' => auth()->user()->id,
                'compra_id' => $id,
                'fecha' => date('Y-m-d H:i:s'),
            ]);

            $this->limpiarCampos();
            return $this->dispatchBrowserEvent('alertSuccess', ['title' => "Nueva compra", 'text' => "Compra registrada!"]);
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
        $this->reset(['pagado', 'vuelto', 'subtotal', 'igv', 'descuento', 'total', 'proveedor', '_descuento', 'table']);
        $this->reset(['_subtotal', '__subtotal']);
        $this->_proveedor = false;
        $this->limpiarValidation();
    }

    public function limpiarValidation()
    {
        $this->resetErrorBag();
        $this->resetValidation();
    }
}
