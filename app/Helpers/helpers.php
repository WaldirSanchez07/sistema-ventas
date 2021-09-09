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

function isAdmin_V($rol){
    switch ($rol) {
        case 'Administrador':
            return true;
            break;
        case 'Vendedor':
            return true;
            break;
        default:
            return false;
            break;
    }
}

function isAdmin_C($rol){
    switch ($rol) {
        case 'Administrador':
            return true;
            break;
        case 'Contador':
            return true;
            break;
        default:
            return false;
            break;
    }
}
