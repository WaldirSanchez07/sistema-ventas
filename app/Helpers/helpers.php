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