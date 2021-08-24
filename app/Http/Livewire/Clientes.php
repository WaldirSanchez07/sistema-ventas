<?php

namespace App\Http\Livewire;

use App\Models\Cliente;
use App\Models\TipoDocumento;
use Illuminate\Support\Facades\Http;
use Livewire\Component;
use Livewire\WithPagination;

class Clientes extends Component
{
    use WithPagination;
    protected $paginationTheme = 'bootstrap';
    public $idCliente, $nombre, $documento, $nrodocumento, $direccion, $telefono, $email;
    public $paginate = 5;
    public $nItems = 0;
    public $search;
    public $_create = false; //Modal create
    public $_edit = false; //Modal edit

    protected $listeners = ['limpiarCampos', 'update', 'delete'];

    protected $rules = [
        'nombre' => 'required',
        'documento' => 'required|numeric',
        'nrodocumento' => 'required|numeric',
        /* 'direccion' => 'required', */
        /* 'telefono' => 'numeric', */
        'email' => 'nullable'
    ];

    protected $validationAttributes = [
        'nrodocumento' => 'nro documento',
        'email' => 'correo'
    ];

    public function render()
    {
        $tipoDoc = TipoDocumento::all();
        $clientes = Cliente::orderBy('id_cliente','DESC')
        ->where('nombre', 'like', '%' . $this->search . '%')
        ->orWhere('nrodocumento', 'like', '%' . $this->search . '%')->paginate($this->paginate);
        $this->nItems = $clientes->count();

        return view('livewire.clientes.index', compact('tipoDoc', 'clientes'));
    }

    public function buscandoDatos(){
        $nrodoc = $this->nrodocumento;
        if (strlen($nrodoc)== 8) {
            $url = Http::get('https://dniruc.apisperu.com/api/v1/dni/'.$nrodoc.'?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbXllc2h1YTcyN0BnbWFpbC5jb20ifQ.0z14bKT2JWPsbs2y9j40RWrW_RvG9XaXtwUh2MRGOyQ');
            $this->nombre = $url->json('nombres').' '.$url->json('apellidoPaterno').' '.$url->json('apellidoMaterno');
        } else if (strlen($nrodoc)== 11) {
            $url = Http::get('https://dniruc.apisperu.com/api/v1/ruc/'.$nrodoc.'?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbXllc2h1YTcyN0BnbWFpbC5jb20ifQ.0z14bKT2JWPsbs2y9j40RWrW_RvG9XaXtwUh2MRGOyQ');
           /*  dd($url->json()); */
            $this->nombre = $url->json('razonSocial');
            $this->direccion = $url->json('direccion');
        } else{
             $this->dispatchBrowserEvent('alertWarning', ['title' => "Datos no encontrados", 'text' => "Error inesperado!"]);
             return 0;
        }
        /* dd($url->json('nombres')); */

        /* $this->nombre = $url->json('nombres').' '.$url->json('apellidoPaterno').' '.$url->json('apellidoMaterno'); */
        /* dd($datos); */
    }

    public function save()
    {
        /* dd($this->validate()); */
        $validatedData = $this->validate();
        $validatedData2 = array("direccion"=>$this->direccion,"telefono"=>$this->telefono);
        $datos =  array_Merge($validatedData, $validatedData2);
        /* dd($datos); */

        if ($this->email) {
            $this->validate(['email' => 'email']);
        }

        Cliente::create($datos);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Cliente creado", 'text' => "Se ha creado correctamente!"]);
        $this->limpiarCampos();
    }

    public function edit(Cliente $model)
    {
        $this->idCliente = $model->id_cliente;
        $this->nombre = $model->nombre;
        $this->documento = $model->documento;
        $this->nrodocumento = $model->nrodocumento;
        $this->telefono = $model->telefono;
        $this->email = $model->email;
        $this->direccion = $model->direccion;

        $this->_edit = true;
    }

    public function update($id)
    {
        $validatedData = $this->validate();
         $validatedData2 = array("direccion"=>$this->direccion,"telefono"=>$this->telefono);
        $datos =  array_Merge($validatedData, $validatedData2);
        if ($this->email) {
            $this->validate([
                'email' => 'email'
            ]);
        }

        Cliente::findOrFail($id)->update($datos);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Cliente actualizado", 'text' => "Se ha actualizado correctamente!"]);
        $this->limpiarCampos();
    }

    public function delete($id)
    {
        Cliente::findOrFail($id)->delete();

        if ($this->nItems === 1) {
            $this->previousPage();
        }

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Cliente eliminado", 'text' => "Se ha eliminado correctamente!"]);
        $this->limpiarCampos();
    }

    public function limpiarCampos()
    {
        $this->reset(['idCliente', 'nombre', 'documento', 'nrodocumento', 'direccion', 'telefono', 'email']);
        $this->_create = false;
        $this->_edit = false;
        $this->limpiarValidation();
    }

    public function limpiarValidation()
    {
        $this->resetErrorBag();
        $this->resetValidation();
    }
}
