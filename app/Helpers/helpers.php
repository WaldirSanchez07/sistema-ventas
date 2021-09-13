<?php

function setActive($nameView){
    return request()->routeIs($nameView) ? 'active' : '';
}

function MenuActive($urls){
    foreach ($urls as $u) {
        if(request()->routeIs($u)){
            return 'open';
        }
    }
}

function isAdmin($rol){
    if($rol == 'Administrador'){
        return true;
    }
    return false;
}

function isJL($rol){
    if($rol == 'Jefe de Línea'){
        return true;
    }
    return false;
}

function isEA($rol){
    if($rol == 'Encargado de almacén'){
        return true;
    }
    return false;
}

function isV($rol){
    if($rol == 'Vendedor'){
        return true;
    }
    return false;
}