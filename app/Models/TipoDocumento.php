<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoDocumento extends Model
{
    use HasFactory;

    protected $table = 'tipo_documento';

    protected $fillable = [
        'tipo'
    ];

    public function clientes(){
        return $this->belongsTo(Cliente::class, 'documento', 'id');  
    }

    public function proveedores(){
        return $this->belongsTo(Proveedor::class, 'documento', 'id');  
    }

    public $timestamps = false;
}
