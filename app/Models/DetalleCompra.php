<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetalleCompra extends Model
{
    use HasFactory;
    protected $table = 'detalle_compra';
    protected $primaryKey = 'id_detalle';

    protected $fillable = [
        'compra_id',
        'producto_id',
        'cantidad',
        'precio',
        'descuento'
    ];

    public function compras(){
        return $this->belongsTo(Compra::class, 'id_compra', 'compra_id');
    }

    public function productos(){
        return $this->hasOne(Producto::class, 'id_producto', 'producto_id');
    }
}
