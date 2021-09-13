<?php

namespace App\Http\Livewire;

use App\Models\Caja;
use App\Models\Venta;
use App\Models\DetalleVenta;
use App\Models\Compra;
use App\Models\DetalleCompra;
use App\Models\Empresa;
use PDF;
use Carbon\Carbon;
use Livewire\Component;
use Livewire\WithFileUploads;
use Livewire\WithPagination;
use Illuminate\Support\Facades\DB;

class Cajas extends Component
{
    use WithPagination;
    use WithFileUploads;
    protected $paginationTheme = 'simple-bootstrap';
    protected $listeners = ['update', 'delete'];
    public $id_caja, $descripcion, $monto, $saldo, $tipoMovimiento,$estado,$fecha,$hora,$saldoactual;

    public $_ingreso = false;
    public $_retiro = false;
    public $_aperturacaja = false;
    public $_cierrecaja = false;

    public $idVenta;
     public $idCompra;
    public $_detalle = false;
    public $_detalle2 = false;

    public $_edit = false;

    public $cantdatos;

    public $paginate = 5;
    public $nItems = 0;

    public $search;

    protected $rules = [
        'descripcion' => 'required',
        'monto' => 'required|numeric',
    ];

    public function render()
    {
        $movimientos = Caja::orderBy('id_caja','DESC')
            ->where('caja.descripcion', 'Like', '%' . $this->search . '%')
            ->where('caja.estadoMovimiento', '=',1)
            ->whereDate('caja.fecha','=',Carbon::today())
            ->paginate($this->paginate);

        $lastregister = Caja::whereRaw('id_caja = (select max(`id_caja`) from caja)')->first();

        $this->cantdatos = $movimientos->count();

        $cantidadApertura = Caja::where('caja.descripcion', '=','Apertura de Caja')
            ->whereDate('caja.fecha','=',Carbon::today())
            ->get();
        $cantidadApertura = $cantidadApertura->count();

        $venta = Venta::all();
        $detalle = DetalleVenta::where('venta_id', '=', $this->idVenta)->get();
        $venta2 = Venta::where('id_venta', '=', $this->idVenta)->get();

        $compra = Compra::all();
        $detallecompra = DetalleCompra::where('compra_id', '=', $this->idCompra)->get();
        $compra2 = Compra::where('id_compra', '=', $this->idCompra)->get();

     /*    $fechas = Caja::select('fecha')->get(); */

        return view('livewire.cajas.movimiento',compact('movimientos','lastregister','venta','detalle','venta2','compra','detallecompra','compra2','cantidadApertura'));
    }

    public function save($opc)
    {
        //Cierre
        if ($opc == 3) {
            $tipoMovimiento = 0;
            $estado = 0;
            $saldoTotal = Caja::sum('monto');
            $monto = $saldoTotal*-1;
            $saldoactual = 0;
            $descripcion = "Cierre de Caja";
        }
        //Apertura
        if ($opc == 2) {
            $tipoMovimiento = 1;
            $estado = 1;
            $saldoTotal = Caja::sum('monto');
            $saldoactual = $saldoTotal + $this->monto;
            $this->descripcion = "Apertura de Caja";
            $validatedData = $this->validate();
            /* } else{
                $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "Solo puede aperturar una vez al día la caja"]);
                return;
            } */
        }
        //Ingreso
        if ($opc == 1) {
            $tipoMovimiento = 1;
            $estado = 1;
            $saldoTotal = Caja::sum('monto');
            $saldoactual = $saldoTotal + $this->monto;
            $validatedData = $this->validate();
        }
        //Egreso
        if ($opc == 0){
            $validatedData = $this->validate();
            $tipoMovimiento = 0;
            $estado = 1;
            $validatedData = array_replace($validatedData, ['monto' => $this->monto*-1]);
            $saldoTotal = Caja::sum('monto');
            $saldoactual = $saldoTotal + ($this->monto * -1);
            if($this->monto<=$saldoTotal)
            {
                $saldoactual = $saldoTotal + ($this->monto * -1);
            }
            else
            {
                $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "Saldo insuficiente!"]);
                return;
            }
        }

        if ($opc == 3) {
            $validatedData2 = array("saldo"=>$saldoactual, "tipoMovimiento"=>$tipoMovimiento, "estado"=>$estado, "monto"=>$monto, "descripcion" =>$descripcion);
            $datos = $validatedData2;
        }else{
            $validatedData2 = array("saldo"=>$saldoactual, "tipoMovimiento"=>$tipoMovimiento, "estado"=>$estado);
            $datos = array_Merge($validatedData, $validatedData2);
        }
        //$validatedData = array_replace($validatedData, ['monto' => $this->monto*-1]);
        /* $datos = array_Merge($validatedData, $validatedData2); */

        Caja::create($datos);

        $id = Caja::whereRaw('id_caja = (select max(`id_caja`) from caja)')->first();
        DB::table('usuario_caja')->insert([
                'usuario_id' => auth()->user()->id,
                'caja_id' => $id->id_caja,
                'fecha' => date('Y-m-d H:i:s'),
        ]);

        if ($opc == 3) {
            $this->dispatchBrowserEvent('alertSuccess', ['title' => "Caja Cerrada", 'text' => "Se cerró correctamente!"]);
        }
        if ($opc == 2) {
            $this->dispatchBrowserEvent('alertSuccess', ['title' => "Caja Aperturada", 'text' => "Se aperturo correctamente!"]);
        }
        if ($opc == 1) {
             $this->dispatchBrowserEvent('alertSuccess', ['title' => "Dinero ingresado", 'text' => "Se ingreso correctamente!"]);
        }
        if ($opc == 0) {
             $this->dispatchBrowserEvent('alertSuccess', ['title' => "Dinero retirado", 'text' => "Se retiró correctamente!"]);
        }

        $this->limpiarCampos();
    }

     public function edit(Caja $model)
    {
        $this->id_caja = $model->id_caja;
        $this->descripcion = $model->descripcion;
        $this->tipoMovimiento = $model->tipoMovimiento;
        $monto = $model->monto;
        if ($monto < 0) {
            $monto = $monto * (-1);
            $this->monto = $monto;
        }else{
            $this->monto = $monto;
        }
        $this->saldo = $model->saldo;
        $this->fecha = $model->fecha;
        $this->estado = $model->estado;

        $this->_edit = true; //show form to edit
    }

    public function update($id)
    {
        $model = Caja::where('id_caja', '=', $id)->first();

        $validatedData = $this->validate();

        if ($model->tipoMovimiento == 1) {
            $tipoMovimiento = 1;
            $estado = 1;
            //$saldoTotal = Caja::sum('monto');
            $saldoTotal = $model->saldo;
            $saldoactual = ($saldoTotal - $model->monto) + $this->monto;
            //Falta hacer
        }else{
            //revisar
            $tipoMovimiento = 0;
            $estado = 1;
            /* $validatedData = $this->validate(); */
            $validatedData = array_replace($validatedData, ['monto' => $this->monto*-1]);
            //$saldoTotal = Caja::sum('monto');
            $ultimosaldo = Caja::whereRaw('id_caja = (select max(`id_caja`) from caja)')->first();
            $saldoTotal = ($model->monto*-1)+$ultimosaldo->saldo;
            if($this->monto<=$saldoTotal)
            {
                $saldoactual = ($saldoTotal - $model->monto) - $this->monto;
            }
            else
            {
                $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "Saldo insuficiente!"]);
                return;
            }
        }

        $validatedData2 = array("saldo"=>$saldoactual, "tipoMovimiento"=>$tipoMovimiento, "estado"=>$estado);

        $datos = array_Merge($validatedData, $validatedData2);
        /* dd($datos); */
        Caja::findOrFail($id)->update($datos);

        DB::select('call Actualizar()');

        if ($model->tipoMovimiento == 1) {
             $this->dispatchBrowserEvent('alertUpdate', ['title' => "Ingreso actualizado", 'text' => "Se actualizó correctamente!"]);
        }else{
             $this->dispatchBrowserEvent('alertUpdate', ['title' => "Retiro actualizado", 'text' => "Se actualizó correctamente!"]);
        }

        $this->limpiarCampos();
    }

    public function delete($id)
    {
        $movimiento=Caja::findOrFail($id);
        $movimiento->monto=0;
        $movimiento->estadoMovimiento=0;
        $movimiento->save();

        DB::select('call Actualizar()');

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Movimiento eliminado", 'text' => "Se eliminó correctamente!"]);

        $this->limpiarCampos();
    }

    public function verDetalle($id)
    {
        /* dd($id); */
        $this->idVenta = $id;
        $this->_detalle = true;
    }

    public function pdf($id)
    {
        $ventas = Venta::join('detalle_venta as d', 'venta.id_venta', '=', 'd.venta_id')
            ->join('producto as p', 'p.id_producto', '=', 'd.producto_id')
            ->join('unidad_medida as m', 'm.id', '=', 'p.medida_id')
            ->where('venta.id_venta', '=', $id)->get();
        $empresa = Empresa::first();
        //return view('livewire.ventas.pdf', compact('ventas'));
        $pdf = PDF::loadView('livewire.ventas.pdf', compact('ventas','empresa'));
        return $pdf->stream('factura-venta.pdf');
    }

    public function verDetalle2($id)
    {
        /* dd($id); */
        $this->idCompra = $id;
        $this->_detalle2 = true;
    }

    public function limpiarCampos()
    {
        $this->reset(['descripcion', 'monto']);

        $this->_ingreso = false;
        $this->_retiro = false;
        $this ->_aperturacaja = false;
        $this ->_cierrecaja = false;
        $this ->_edit = false;
        $this->limpiarValidation();
    }

    public function limpiarValidation()
    {
        $this->resetErrorBag();
        $this->resetValidation();
    }
}
