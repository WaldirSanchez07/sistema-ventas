<?php

namespace App\Http\Livewire;

use App\Models\Categoria;
use App\Models\Producto;
use App\Models\SubCategoria;
use App\Models\UnidadMedida;
use Illuminate\Support\Facades\Storage;
use Livewire\Component;
use Livewire\WithFileUploads;
use Livewire\WithPagination;

class AdmProductos extends Component
{
    use WithPagination;
    use WithFileUploads;

    public $idProducto, $producto, $stock, $stock_minimo, $precio_compra, $precio_venta, $foto, $vence, $fecha_vence;
    public $medida_id, $categoria_id, $subcategoria_id;
    public $estado = 'Disponible';
    public $vto = false;
    public $oldFoto;

    public $paginate = 5;
    public $nItems = 0;

    public $_create = false;
    public $_edit = false;

    public $search, $categoria, $subcategoria;

    protected $rules = [
        'producto' => 'required|unique:producto',
        'stock' => 'required|numeric|min:1',
        'stock_minimo' => 'required|numeric|min:1',
        'precio_compra' => 'required|numeric|min:0.10|max:2000.99',
        'precio_venta' => 'required|numeric|min:0.10|max:2000.99',
        'foto' => 'nullable|image|max:2048',
        'vence' => 'required|in:Si,No',
        'fecha_vence' => 'nullable',
        'medida_id' => 'required|numeric',
        'categoria_id' => 'required',
        'subcategoria_id' => 'nullable',
        'estado' => 'required|in:Disponible,Stock mínimo,Agotado,Vencido'
    ];

    protected $validationAttributes = [
        'medida_id' => 'medida',
        'categoria_id' => 'categoria',
        'subcategoria_id' => 'subcategoria',
    ];

    public function render()
    {
        $productos = Producto::join('categoria as c', 'c.id_categoria', '=', 'producto.categoria_id')
            ->join('subcategoria as s', 's.id_subcategoria', '=', 'producto.subcategoria_id')
            ->where('producto.categoria_id', 'Like', '%' . $this->categoria . '%')
            ->where('producto.subcategoria_id', 'Like', '%' . $this->subcategoria . '%')
            ->where('producto.producto', 'Like', '%' . $this->search . '%')
            ->paginate($this->paginate);

        $subcats = Producto::select('producto.subcategoria_id')->groupBy('producto.subcategoria_id')->get();
        $cats = Producto::select('producto.categoria_id')->groupBy('producto.categoria_id')->get();
        $medidas = UnidadMedida::all();
        $categorias = Categoria::all();
        $subcategorias = SubCategoria::where('categoria_id', '=', $this->categoria_id)->get();
        $nItems = $productos->count();

        return view('livewire.adm-productos.index', compact('productos', 'medidas', 'categorias', 'subcategorias', 'subcats', 'cats'));
    }

    public function save()
    {
        if ($this->vto) {
            $this->rules = array_replace($this->rules, ['fecha_vence' => 'required|date']);
            $this->vence = 'Si';
        } else {
            $this->vence = 'No';
            $this->fecha_vence = null;
        }

        $validatedData = $this->validate();

        $imgName = uniqid() . '.' . $this->foto->getClientOriginalExtension();
        $this->foto->storeAs('storage', $imgName, 'public_uploads');

        $validatedData = array_replace($validatedData, ['foto' => $imgName]);

        Producto::create($validatedData);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Producto agregado", 'text' => "Se agregó correctamente!"]);
        $this->limpiarCampos();
    }

    public function edit(Producto $model)
    {
        $this->idProducto = $model->id_producto;
        $this->producto = $model->producto;
        $this->stock = $model->stock;
        $this->stock_minimo = $model->stock_minimo;
        $this->precio_compra = $model->precio_compra;
        $this->precio_venta = $model->precio_venta;
        $this->oldFoto = $model->foto;
        $this->foto = $model->foto;
        $this->vto = $model->vence == 'Si' ? true : false;
        $this->medida_id = $model->medida_id;
        $this->fecha_vence = $model->fecha_vence;
        $this->categoria_id = $model->categoria_id;
        $this->subcategoria_id = $model->subcategoria_id;
        $this->estado = $model->estado;

        $this->_edit = true; //show form to edit
    }

    public function update($id)
    {
        if ($this->vto) {
            $this->rules = array_replace($this->rules, ['fecha_vence' => 'required|date']);
            $this->vence = 'Si';
        } else {
            $this->vence = 'No';
            $this->fecha_vence = null;
        }

        $this->rules = array_replace($this->rules, ['foto' => 'nullable']);

        $validatedData = $this->validate();

        if ($this->foto !== $this->oldFoto) {
            $this->rules = array_replace($this->rules, ['foto' => 'image|max:1024']);
            $validatedData = $this->validate();

            $imgName = uniqid() . '.' . $this->foto->getClientOriginalExtension();
            $this->foto->storeAs('storage', $imgName, 'public_uploads');
            $validatedData = array_replace($validatedData, ['foto' => $imgName]);

            $this->removeImage($this->oldFoto);
        }

        Producto::findOrFail($id)->update($validatedData);

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Producto actualizado", 'text' => "Se actualizó correctamente!"]);
        $this->limpiarCampos();
    }

    public function delete(Producto $model)
    {
        Producto::findOrFail($model->id_producto)->delete();
        $this->removeImage($model->photo);

        if ($this->nItems === 1) {
            $this->previousPage();
        }

        $this->dispatchBrowserEvent('alertSuccess', ['title' => "Producto eliminado", 'text' => "Se eliminó correctamente!"]);
        $this->limpiarCampos();
    }

    public function removeImage($image_path)
    {
        if (!$image_path) {
            return;
        }
        if (Storage::disk('public_uploads')->exists('storage/' . $image_path)) {
            Storage::disk('public_uploads')->delete('storage/' . $image_path);
        }
    }

    public function limpiarCampos()
    {
        $this->reset(['idProducto', 'producto', 'stock', 'stock_minimo', 'precio_compra', 'precio_venta', 'foto', 'vence', 'fecha_vence']);
        $this->reset(['estado']);

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
