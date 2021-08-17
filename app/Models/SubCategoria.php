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
        return $this->hasOne(Producto::class, 'categoria_id', 'id_categoria');
    }

    public $timestamps = false;
}
