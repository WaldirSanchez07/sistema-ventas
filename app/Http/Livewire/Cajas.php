<?php

namespace App\Http\Livewire;

use App\Models\Caja;
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
    public $id_caja, $descripcion, $monto, $saldo, $tipoMovimiento,$estado,$fecha,$hora;

    public $_ingreso = false;
    public $_retiro = false;
    public $_aperturacaja = false;
    public $_cierrecaja = false;

    public $_edit = false;

    public $cantdatos;

    public $paginate = 10;
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
            ->paginate($this->paginate);
        //$codigo = $movimientos->id_caja;

        $lastregister = Caja::whereRaw('id_caja = (select max(`id_caja`) from caja)')->first();
        $this->cantdatos = $movimientos->count();

        return view('livewire.cajas.movimiento',compact('movimientos','lastregister'));
    }

    public function save($opc)
    {
        if ($opc == 2) {
            $tipoMovimiento = 1;
            $estado = 1;
            $saldoTotal = Caja::sum('monto');
            $saldoactual = $saldoTotal + $this->monto;
            $this->descripcion = "Apertura de Caja";
        }

        $validatedData = $this->validate();

        if ($opc == 1) {
            $tipoMovimiento = 1;
            $estado = 1;
            $saldoTotal = Caja::sum('monto');
            $saldoactual = $saldoTotal + $this->monto;
        }

        if ($opc == 0){
            $tipoMovimiento = 0;
            $estado = 1;
            $validatedData = array_replace($validatedData, ['monto' => $this->monto*-1]);
            $saldoTotal = Caja::sum('monto');
            $saldoactual = $saldoTotal + ($this->monto * -1);
            /* if($this->monto<=$saldoTotal)
            {
                $saldoactual = $saldoTotal + ($this->monto * -1);
            }
            else
            {
                $this->dispatchBrowserEvent('alertWarning', ['title' => "Error", 'text' => "Saldo insuficiente!"]);
            } */
        }

        $validatedData2 = array("saldo"=>$saldoactual, "tipoMovimiento"=>$tipoMovimiento, "estado"=>$estado);
        //$validatedData = array_replace($validatedData, ['monto' => $this->monto*-1]);
        $datos = array_Merge($validatedData, $validatedData2);

        Caja::create($datos);

        if ($opc == 2) {
            $this->dispatchBrowserEvent('alertOpen', ['title' => "Caja Aperturada", 'text' => "Se aperturo correctamente!"]);
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
        if ($monto <= 0) {
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
            $saldoTotal = $model->saldo;
            $saldoactual = ($saldoTotal - $model->monto) - $this->monto;
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

    public function delete(Caja $model)
    {
       Caja::findOrFail($model->id_caja)->delete();

       /*  if ($this->nItems === 1) {
            $this->previousPage();
        } */

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Movimiento eliminado", 'text' => "Se eliminó correctamente!"]);

        $this->limpiarCampos();
    }

    public function close($id)
    {
        dd($id);
        $tipoMovimiento = 1;
        $estado = 0;
        $model = Caja::where('id_caja', '=', $id)->first();
        $model->estado = $estado;
        $saldoTotal = Caja::sum('monto');
        $saldoactual = $saldoTotal + $this->monto;
        //Caja::truncate();
        Caja::findOrFail($id)->update($model);

        $this->dispatchBrowserEvent('alertOpen', ['title' => "Caja Cerrada", 'text' => "Se cerro correctamente!"]);

        $this->limpiarCampos();
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
