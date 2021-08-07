<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubCategoria extends Model
{
    use HasFactory;

    protected $table = 'subcategoria';
    protected $primaryKey = "id_subcategoria";
    
    protected $fillable = [
        'subcategoria',
        'categoria_id',
        'estado',
    ];

    public function categorias(){
        return $this->hasOne(Categoria::class, 'id_categoria', 'categoria_id'); 
    }

    public function productos(){
        return $this->belongsToMany(Producto::class, 'productos_categorias', 'producto_id', 'categoria_id');
    }

    public $timestamps = false;
}
