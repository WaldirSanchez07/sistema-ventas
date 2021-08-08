<?php

namespace App\Http\Livewire;

use App\Models\Categoria;
use App\Models\Producto;
use App\Models\SubCategoria;
use Livewire\Component;
use Livewire\WithPagination;

class Productos extends Component
{
    use WithPagination;
    protected $paginationTheme = 'bootstrap';

    public $search, $categoria = "", $subcategoria = "";
    public $paginate = 10;

    public function render()
    {
        $productos = Producto::join('categoria as c', 'c.id_categoria', '=', 'producto.categoria_id')
            ->join('subcategoria as s', 's.id_subcategoria', '=', 'producto.subcategoria_id')
            ->where('producto.categoria_id', 'Like', '%' . $this->categoria . '%')
            ->where('producto.subcategoria_id', 'Like', '%' . $this->subcategoria . '%')
            ->where('producto.producto', 'Like', '%' . $this->search . '%')
            ->paginate($this->paginate);
        $total = Producto::all()->count();
        $categorias = Producto::select('producto.categoria_id')->groupBy('producto.categoria_id')->get();
        $subcategorias = SubCategoria::where('categoria_id', 'like', '%' . $this->categoria . '%')->get();
        $nItems = $productos->count();

        return view('livewire.adm-productos.viewall', compact('productos', 'categorias', 'subcategorias', 'total'));
    }
    public function limpiar()
    {
        $this->reset(['categoria', 'subcategoria']);
    }
}
