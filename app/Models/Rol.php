<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rol extends Model
{
    use HasFactory;

    protected $table = 'rol';
    protected $primaryKey = "id_rol";
    protected $fillable = ['id_rol','rol'];

    public function users(){
        return $this->belongsTo(User::class, 'rol_id', 'id_rol');  
    }
}
