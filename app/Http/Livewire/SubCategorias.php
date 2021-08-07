<?php

namespace App\Http\Livewire;

use App\Models\Categoria;
use App\Models\SubCategoria;
use Livewire\Component;
use Livewire\WithPagination;

class SubCategorias extends Component
{
    use WithPagination;
    protected $paginationTheme = 'simple-bootstrap';
    protected $listeners = ['update', 'delete'];

    public $idSubcategoria, $subcategoria, $categoria_id; //Model subcategoria
    public $estado = 'Habilitado';
    public $categoria, $search;
    public $paginate = 5;

    public $_create = false;
    public $_edit = false;
    public $nItems = 0;

    protected $rules = [
        'subcategoria' => 'required|unique:subcategoria',
        'categoria_id' => 'required|numeric',
        'estado' => 'required|in:Habilitado,Deshabilitado',
    ];

    protected $validationAttributes = [
        'categoria_id' => 'categoria'
    ];

    public function render()
    {
        $categorias = Categoria::all();
        $subcategorias = SubCategoria::where('categoria_id', 'like', '%' . $this->categoria . '%')
            ->where('subcategoria', 'like', '%' . $this->search . '%')->paginate($this->paginate);
        $nItems = $subcategorias->count();

        return view('livewire.subcategorias.index', compact('categorias', 'subcategorias'));
    }

    public function save()
    {
        $validatedData = $this->validate();
        SubCategoria::create($validatedData);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Subcategoría creada", 'text' => "Se ha creado correctamente!"]);
        $this->limpiarCampos();
    }

    public function edit(SubCategoria $model)
    {
        $this->idSubcategoria = $model->id_subcategoria;
        $this->subcategoria = $model->subcategoria;
        $this->categoria_id = $model->categoria_id;
        $this->estado = $model->estado;

        $this->_edit = true; //show form to edit
    }

    public function update($id)
    {
        $model = SubCategoria::where('subcategoria', '=', $this->subcategoria)
            ->where('categoria_id', '=', $this->categoria_id)->first();

        if ($model == null || $model->id_subcategoria == $id) {
            $this->rules = array_replace($this->rules, ['subcategoria' => 'required']);
        }
        
        $validatedData = $this->validate();
        SubCategoria::findOrFail($id)->update($validatedData);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Subcategoría actualizada", 'text' => "Se ha actualizado correctamente!"]);
        $this->limpiarCampos();
    }

    public function delete($id)
    {
        SubCategoria::findOrFail($id)->delete();

        if ($this->nItems === 1) {
            $this->previousPage();
        }

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Subcategoría eliminada", 'text' => "Se ha eliminado correctamente!"]);
        $this->limpiarCampos();
    }

    public function selectedCompanyItem($item)
    {
        if ($item) {
            $this->categoria_id = $item;
        } else {
            $this->company = null;
        }
    }

    public function limpiarCampos()
    {
        $this->reset(['idSubcategoria', 'subcategoria', 'categoria_id', 'estado']);
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
