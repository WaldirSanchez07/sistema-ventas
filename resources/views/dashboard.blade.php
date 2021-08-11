<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Dashboard') }}
        </h2>
    </x-slot>

    {{-- <div class="full-box page-header">
        <h3 class="text-left">
            <i class="fab fa-dashcube fa-fw"></i> &nbsp; DASHBOARD
        </h3>
        <p class="text-justify">
            ¡Bienvenido <strong>Administrador Principal</strong>! Este es el panel principal del sistema acá podrá encontrar atajos para acceder a los distintos listados de cada módulo del sistema.
        </p>
    </div> --}}
    <div class="container-fluid">
        <div class="full-box tile-container">
            <a href="{{route('adm-productos')}} " class="tile">
                <div class="tile-tittle">Productos</div>
                <div class="tile-icon">
                    <i class="fas fa-cubes fa-fw"></i>
                </div>
            </a>
            <a href="{{route('categorias')}}" class="tile">
                <div class="tile-tittle">Categorías</div>
                <div class="tile-icon">
                    <i class="fas fa-tags fa-fw"></i>
                </div>
            </a>
            <a href="{{route('sub-categorias')}}" class="tile">
                <div class="tile-tittle">Sub Categorías</div>
                <div class="tile-icon">
                    <i class="fas fa-tag fa-fw"></i>
                </div>
            </a>
            <a href="{{route('clientes')}}" class="tile">
                <div class="tile-tittle">Clientes</div>
                <div class="tile-icon">
                    <i class="fas fa-users fa-fw"></i>
                </div>
            </a>
            <a href="{{route('proveedores')}}" class="tile">
                <div class="tile-tittle">Proveedores</div>
                <div class="tile-icon">
                    <i class="fas fa-shipping-fast fa-fw"></i>
                </div>
            </a>
            <a href="{{route('productos')}}" class="tile">
                <div class="tile-tittle">Mostrar</div>
                <div class="tile-icon">
                    <i class="fas fa-th-list"></i>
                </div>
            </a>
            <a href="#" class="tile">
                <div class="tile-tittle">Reportes</div>
                <div class="tile-icon">
                    <i class="fas fa-folder-open fa-fw"></i>
                    {{-- <p> &nbsp; </p> --}}
                </div>
            </a>
            <a href="#" class="tile">
                <div class="tile-tittle">Inventario</div>
                <div class="tile-icon">
                    <i class="fas fa-clipboard fa-fw"></i>
                </div>
            </a>
            <a href="{{route('nueva-venta')}}" class="tile">
                <div class="tile-tittle">Ventas</div>
                <div class="tile-icon">
                    <i class="fas fa-shopping-cart fa-fw"></i>
                </div>
            </a>
            <a href="#" class="tile">
                <div class="tile-tittle">Almacen</div>
                <div class="tile-icon">
                    <i class="fas fa-warehouse fa-fw"></i>
                </div>
            </a>
            <a href="{{route('caja')}}" class="tile">
                <div class="tile-tittle">Movimientos</div>
                <div class="tile-icon">
                    <i class="fas fa-cash-register fa-fw"></i>
                </div>
            </a>
            {{-- <a href="#" class="tile">
                <div class="tile-tittle">Kardex</div>
                <div class="tile-icon">
                    <i class="fas fa-pallet fa-fw"></i>
                </div>
            </a> --}}


        </div>
    </div>
    {{--<div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <x-jet-welcome />
            </div>
        </div>
    </div>--}}
</x-app-layout>
