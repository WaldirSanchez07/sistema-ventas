<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    use HasFactory;

    protected $table = 'producto';
    protected $primaryKey = 'id_producto';

    protected $fillable = [
        'producto',
        'stock',
        'stock_minimo',
        'precio_compra',
        'precio_venta',
        'foto',
        'vence',
        'fecha_vence',
        'medida_id',
        'estado',
        'categoria_id',
        'subcategoria_id'
    ];

    public function medidas(){
        return $this->hasOne(UnidadMedida::class, 'id', 'medida_id');
    }

    public function categorias(){
        return $this->hasOne(Categoria::class, 'id_categoria', 'categoria_id');
    }

    public function subcategorias(){
        return $this->hasOne(SubCategoria::class, 'id_subcategoria', 'subcategoria_id');
    }

    public $timestamps = false;
}