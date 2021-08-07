<?php

namespace App\Http\Livewire;

use App\Models\Categoria;
use Livewire\Component;
use Livewire\WithPagination;

class Categorias extends Component
{
    use WithPagination;
    protected $paginationTheme = 'simple-bootstrap';
    protected $listeners = ['update', 'delete'];

    public $idCategoria, $categoria; //Model categoria
    public $estado = 'Habilitado';
    public $paginate = 5;
    public $search;

    public $_create = false;
    public $_edit = false;
    public $nItems = 0;

    protected $rules = [
        'categoria' => 'required|unique:categoria',
        'estado' => 'required|in:Habilitado,Deshabilitado',
    ];

    public function render()
    {
        $categorias = Categoria::where('categoria', 'like', '%' . $this->search . '%')->paginate($this->paginate);
        $nItems = $categorias->count();

        return view('livewire.categorias.index', compact('categorias'));
    }

    public function save()
    {
        $validatedData = $this->validate();
        Categoria::create($validatedData);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Categoría creada", 'text' => "Se ha creado correctamente!"]);
        $this->limpiarCampos();
    }

    public function edit(Categoria $model)
    {
        $this->idCategoria = $model->id;
        $this->categoria = $model->categoria;
        $this->estado = $model->estado;

        $this->_edit = true; //show form to edit
    }

    public function update($id)
    {
        $model = Categoria::where('categoria', '=', $this->categoria)->first();

        if ($model->id == $id) {
            $this->rules = array_replace($this->rules, ['categoria' => 'required']);
        }

        $validatedData = $this->validate();

        Categoria::findOrFail($id)->update($validatedData);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Categoría actualizada", 'text' => "Se ha actualizado correctamente!"]);
        $this->limpiarCampos();
    }

    public function delete($id)
    {
        Categoria::findOrFail($id)->delete();

        if ($this->nItems === 1) {
            $this->previousPage();
        }

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Categoría eliminada", 'text' => "Se ha eliminado correctamente!"]);
        $this->limpiarCampos();
    }

    public function limpiarCampos()
    {
        $this->reset(['idCategoria', 'categoria', 'estado']);
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
