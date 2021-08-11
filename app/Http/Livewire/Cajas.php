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
    public $idcaja, $descripcion, $monto, $saldo, $tipoMovimiento,$estado,$fecha,$hora;

    public $_ingreso = false;
    public $_egreso = false;
    public $_aperturacaja = false;
    public $_cierrecaja = false;

    public $ingreso;
    public $egreso;

    public $valor=0;
    public $paginate = 5;
    public $search;

    protected $rules = [
        'descripcion' => 'required',
        'monto' => 'required|numeric|min:0.10',
    ];

    public function render()
    {
        $movimientos = Caja::where('caja.descripcion', 'Like', '%' . $this->search . '%')->paginate($this->paginate);
        $lastregister = Caja::whereRaw('id_caja = (select max(`id_caja`) from caja)')->get();
        /* dd($lastregister); */

        return view('livewire.cajas.movimiento',compact('movimientos','lastregister'));
    }

    public function mount()
    {
         $this->ingreso = true;
        $valor = $this->ingreso;
        $this->egreso = false;
        $valor2 = $this->egreso;
          return $valor2;
    }

    public function save()
    {
        dd($this->mount());


        if ($this->mount() == true) {
            /* $tipoMovimiento = 1;
            $validatedData = $this->validate();
            $m=$validatedData["monto"];
            $saldoTotal = Caja::sum('monto');
            $saldo = $saldoTotal + $m; */
            dd("Hola");
        }
        if ($this->egreso == true) {
            /* $tipoMovimiento = 0;
            $validatedData = $this->validate();
            $m=$validatedData["monto"];
            $m=-$m;
            $saldoTotal = Caja::sum('monto');
            $saldo = $saldoTotal + $m; */
            dd("Hola2");
        }

        dd($tipoMovimiento,$saldo);
        /* $tipoMovimiento = 1; */

        /* if ($this->ingreso == 1) {
            $tipoMovimiento = 1;
        }
        if ($this->egreso == 0) {
            $tipoMovimiento = 0;
        } */

        /* dd($tipoMovimiento); */
         $estado = 1;

        $validatedData2 = array("saldo"=>$saldo, "tipoMovimiento"=>$tipoMovimiento, "estado"=>$estado);

        $datos = array_Merge($validatedData, $validatedData2);

        dd($datos);

        Caja::create($datos);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Movimiento agregado", 'text' => "Se agregó correctamente!"]);

        $this->limpiarCampos();
    }

    public function limpiarCampos()
    {
        $this->reset(['descripcion', 'monto']);

        $this->_create = false;
        $this->_edit = false;
        $this->limpiarValidation();
    }

    public function limpiarValidation()
    {
        $this->resetErrorBag();
        $this->resetValidation();
        $this->previousPage();
    }
}
