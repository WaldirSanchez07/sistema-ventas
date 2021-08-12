<?php

namespace App\Http\Livewire;

use App\Models\Caja;
use Livewire\Component;
use Livewire\WithFileUploads;
use Livewire\WithPagination;

class Cajas extends Component
{
    use WithPagination;
    use WithFileUploads;
    protected $paginationTheme = 'simple-bootstrap';
    protected $listeners = ['update', 'delete'];
    public $id_caja, $descripcion, $monto, $saldo, $tipoMovimiento,$estado,$fecha,$hora;

    public $_ingreso = false;
    public $_egreso = false;
    public $_aperturacaja = false;
    public $_cierrecaja = false;

    public $_edit = false;

    public $paginate = 5;
    public $nItems = 0;

    public $search;

    protected $rules = [
        'descripcion' => 'required',
        'monto' => 'required|numeric|min:0.10',
    ];

    public function render()
    {
        $movimientos = Caja::orderBy('id_caja','DESC')->where('caja.descripcion', 'Like', '%' . $this->search . '%')->paginate($this->paginate);
        $lastregister = Caja::whereRaw('id_caja = (select max(`id_caja`) from caja)')->get();
        $nItems = $movimientos->count();
        
        return view('livewire.cajas.movimiento',compact('movimientos','lastregister'));
    }

    public function save($opc)
    {
         $validatedData = $this->validate();

        if ($opc == 1) {
            $tipoMovimiento = 1;
            $estado = 1;
            $saldoTotal = Caja::sum('monto');
            $saldoactual = $saldoTotal + $this->monto;
        }else{
            $tipoMovimiento = 0;
            $estado = 1;
            $validatedData = array_replace($validatedData, ['monto' => $this->monto*-1]);
            $saldoTotal = Caja::sum('monto');
            $saldoactual = $saldoTotal + ($this->monto * -1);
        }

        $validatedData2 = array("saldo"=>$saldoactual, "tipoMovimiento"=>$tipoMovimiento, "estado"=>$estado);

        //$validatedData = array_replace($validatedData, ['monto' => $this->monto*-1]);

        $datos = array_Merge($validatedData, $validatedData2);

        Caja::create($datos);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Movimiento agregado", 'text' => "Se agregó correctamente!"]);

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
            $saldoactual = ($model->saldo - $model->monto) + $this->monto;
        }else{
            $tipoMovimiento = 0;
            $estado = 1;
            /* $validatedData = $this->validate(); */
            $validatedData = array_replace($validatedData, ['monto' => $this->monto*-1]);
            $saldoactual = ($model->saldo - $model->monto) - $this->monto;
        }

        $validatedData2 = array("saldo"=>$saldoactual, "tipoMovimiento"=>$tipoMovimiento, "estado"=>$estado);

        $datos = array_Merge($validatedData, $validatedData2);
        /* dd($datos); */
        Caja::findOrFail($id)->update($datos);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Movimiento actualizado", 'text' => "Se actualizó correctamente!"]);

        $this->limpiarCampos();
    }

    public function delete(Caja $model)
    {
        dd($this->nItems);
        Caja::findOrFail($model->id_caja)->delete();

        if ($this->nItems === 1) {
            $this->previousPage();
        }

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Movimiento eliminado", 'text' => "Se eliminó correctamente!"]);

        $this->limpiarCampos();
    }

    public function limpiarCampos()
    {
        $this->reset(['descripcion', 'monto']);

        $this->_ingreso = false;
        $this->_egreso = false;
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
