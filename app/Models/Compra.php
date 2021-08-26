<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Compra extends Model
{
    use HasFactory;
    protected $table = 'compra';
    protected $primaryKey = 'id_compra';

    protected $fillable = [
        'proveedor_id',
        'subtotal',
        'igv',
        'total',
        'fecha'
    ];

    public function detalles(){
        return $this->hasMany(DetalleCompra::class, 'compra_id', 'id_compra');
    }

    public function proveedores(){
        return $this->hasOne(Proveedor::class, 'id_proveedor', 'proveedor_id');
    }
}
