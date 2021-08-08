<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Categoria extends Model
{
    use HasFactory;

    protected $table = 'categoria';
    protected $primaryKey = 'id_categoria';

    protected $fillable = [
        'categoria',
        'estado'
    ];

    public function subcategorias(){
        return $this->belongsTo(SubCategoria::class, 'categoria_id', 'id_categoria');  
    }

    public $timestamps = false;
}
