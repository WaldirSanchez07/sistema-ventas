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
        'raz_social',
        'documento',
        'nrodocumento',
        'contacto',
        'direccion',
        'telefono',
        'email',
        'estado'
    ];

    public function tipos(){
        return $this->hasOne(TipoDocumento::class, 'id', 'documento');   
    }

    public $timestamps = false;
}
