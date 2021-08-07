<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Proveedor extends Model
{
    use HasFactory;

    protected $table = 'proveedor';
    protected $primaryKey = "id_proveedor";

    protected $fillable = [
        'nombre',
        'documento',
        'nrodocumento',
        'contacto',
        'direccion',
        'telefono',
        'email',
        'estado'
    ];

    public function tipos(){
        return $this->hasOne(TipoDocumento::class, 'id', 'tipo_id');   
    }

    public $timestamps = false;
}
