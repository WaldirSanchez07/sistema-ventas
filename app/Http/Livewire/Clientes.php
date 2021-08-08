<?php

namespace App\Http\Livewire;

use App\Models\Cliente;
use App\Models\TipoDocumento;
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
        'direccion' => 'required',
        'telefono' => 'required|numeric',
        'email' => 'nullable'
    ];

    protected $validationAttributes = [
        'nrodocumento' => 'nro documento',
        'email' => 'correo'
    ];

    public function render()
    {
        $tipoDoc = TipoDocumento::all();
        $clientes = Cliente::where('nombre', 'like', '%' . $this->search . '%')
            ->orWhere('nrodocumento', 'like', '%' . $this->search . '%')->paginate($this->paginate);
        $this->nItems = $clientes->count();

        return view('livewire.clientes.index', compact('tipoDoc', 'clientes'));
    }

    public function save()
    {
        $validatedData = $this->validate();

        if ($this->email) {
            $this->validate(['email' => 'email']);
        }

        Cliente::create($validatedData);

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

        if ($this->email) {
            $this->validate([
                'email' => 'email'
            ]);
        }

        Cliente::findOrFail($id)->update($validatedData);

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
