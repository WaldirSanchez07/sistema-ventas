<!-- BEGIN: Main Menu-->
<div class="main-menu menu-fixed menu-light menu-accordion menu-shadow" data-scroll-to-active="true">
    <div class="navbar-header">
        <ul class="nav navbar-nav flex-row">
            <li class="nav-item me-auto">
                <a class="navbar-brand" href="/dashboard">
                <span class="brand-logo">
                        <svg viewbox="0 0 139 95" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" height="24">
                            <defs>
                                <lineargradient id="linearGradient-1" x1="100%" y1="10.5120544%" x2="50%" y2="89.4879456%">
                                    <stop stop-color="#000000" offset="0%"></stop>
                                    <stop stop-color="#FFFFFF" offset="100%"></stop>
                                </lineargradient>
                                <lineargradient id="linearGradient-2" x1="64.0437835%" y1="46.3276743%" x2="37.373316%" y2="100%">
                                    <stop stop-color="#EEEEEE" stop-opacity="0" offset="0%"></stop>
                                    <stop stop-color="#FFFFFF" offset="100%"></stop>
                                </lineargradient>
                            </defs>
                            <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                <g id="Artboard" transform="translate(-400.000000, -178.000000)">
                                    <g id="Group" transform="translate(400.000000, 178.000000)">
                                        <path class="text-dark" id="Path" d="M-5.68434189e-14,2.84217094e-14 L39.1816085,2.84217094e-14 L69.3453773,32.2519224 L101.428699,2.84217094e-14 L138.784583,2.84217094e-14 L138.784199,29.8015838 C137.958931,37.3510206 135.784352,42.5567762 132.260463,45.4188507 C128.736573,48.2809251 112.33867,64.5239941 83.0667527,94.1480575 L56.2750821,94.1480575 L6.71554594,44.4188507 C2.46876683,39.9813776 0.345377275,35.1089553 0.345377275,29.8015838 C0.345377275,24.4942122 0.230251516,14.560351 -5.68434189e-14,2.84217094e-14 Z" style="fill:currentColor"></path>
                                        <path id="Path1" d="M69.3453773,32.2519224 L101.428699,1.42108547e-14 L138.784583,1.42108547e-14 L138.784199,29.8015838 C137.958931,37.3510206 135.784352,42.5567762 132.260463,45.4188507 C128.736573,48.2809251 112.33867,64.5239941 83.0667527,94.1480575 L56.2750821,94.1480575 L32.8435758,70.5039241 L69.3453773,32.2519224 Z" fill="#0c0c0c" opacity="0.2"></path>
                                        <polygon id="Path-2" fill="#000000" opacity="0.049999997" points="69.3922914 32.4202615 32.8435758 70.5039241 54.0490008 16.1851325"></polygon>
                                        <polygon id="Path-21" fill="#000000" opacity="0.099999994" points="69.3922914 32.4202615 32.8435758 70.5039241 58.3683556 20.7402338"></polygon>
                                        <polygon id="Path-3" fill="#0c0c0c" opacity="0.099999994" points="101.428699 0 83.0667527 94.1480575 130.378721 47.0740288"></polygon>
                                    </g>
                                </g>
                            </g>
                        </svg>
                    </span>
                    <h2 class="brand-text text-dark">Olano S.A.C</h2>
                </a>
            </li>
            <li class="nav-item nav-toggle">
                <a class="nav-link modern-nav-toggle pe-0" data-bs-toggle="collapse">
                    <i class="d-none d-xl-block menu-icon font-medium-4 text-dark" data-feather="menu"></i>
                </a>
            </li>
        </ul>
    </div>
    <div class="shadow-bottom"></div>
    <div class="main-menu-content">
        <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
            <li class=" nav-item {{setActive('dashboard')}}">
                <a class="d-flex align-items-center" href="/dashboard">
                    <i data-feather='layout'></i>
                    <span class="menu-title text-truncate" data-i18n="Clientes">Dashboard</span>
                </a>
            </li>
            <li class=" navigation-header">
                <span data-i18n="Apps &amp; Pages">General</span>
                <i data-feather="more-horizontal"></i>
            </li>
            <li class="nav-item">
                <a class="d-flex align-items-center" href="#">
                    <i data-feather="package"></i>
                    <span class="menu-title text-truncate" data-i18n="Dashboards">Productos</span>
                </a>
                <ul class="menu-content">
                    <li class="{{setActive('adm-productos')}}">
                        <a class="d-flex align-items-center" href="{{route('adm-productos')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="Analytics">Adm. Productos</span>
                        </a>
                    </li>
                    <li class="{{setActive('categorias')}}">
                        <a class="d-flex align-items-center" href="{{route('categorias')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="eCommerce">Adm. Categorias</span>
                        </a>
                    </li>
                    <li class="{{setActive('sub-categorias')}}">
                        <a class="d-flex align-items-center" href="{{route('sub-categorias')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="eCommerce">Adm. Sub Categorias</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-item {{setActive('clientes')}}">
                <a class="d-flex align-items-center" href="{{route('clientes')}}">
                    <i data-feather='users'></i>
                    <span class="menu-title text-truncate" data-i18n="Clientes">Clientes</span>
                </a>
            </li>
            <li class="nav-item {{setActive('proveedores')}}">
                <a class="d-flex align-items-center" href="{{route('proveedores')}}">
                    <i data-feather='truck'></i>
                    <span class="menu-title text-truncate">Proveedores</span>
                </a>
            </li>
            <li class="nav-item {{setActive('productos')}}">
                <a class="d-flex align-items-center" href="{{route('productos')}}">
                    <i data-feather="package"></i>
                    <span class="menu-title text-truncate">Productos</span>
                </a>
            </li>
            <li class=" nav-item">
                <a class="d-flex align-items-center" href="#">
                    <i data-feather='trending-up'></i>
                    <span class="menu-title text-truncate" data-i18n="Dashboards">Reportes</span>
                </a>
                <ul class="menu-content">
                    <li>
                        <a class="d-flex align-items-center" href="#">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="Analytics">Reporte #1</span>
                        </a>
                    </li>
                    <li>
                        <a class="d-flex align-items-center" href="#">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="eCommerce">Reporte #2</span>
                        </a>
                    </li>
                </ul>
            </li>
            {{--<li class=" nav-item">
                <a class="d-flex align-items-center" href="#">
                    <i data-feather='clipboard'></i>
                    <span class="menu-title text-truncate" data-i18n="Dashboards">Inventario</span>
                </a>
                <ul class="menu-content">
                    <li>
                        <a class="d-flex align-items-center" href="#">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="Analytics">Reporte #1</span>
                        </a>
                    </li>
                    <li>
                        <a class="d-flex align-items-center" href="#">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="eCommerce">Reporte #2</span>
                        </a>
                    </li>
                </ul>
            </li>--}}
            <li class=" nav-item">
                <a class="d-flex align-items-center" href="#">
                    <i data-feather='shopping-cart'></i>
                    <span class="menu-title text-truncate">Ventas</span>
                </a>
                <ul class="menu-content">
                    <li class="{{setActive('nueva-venta')}}">
                        <a class="d-flex align-items-center" href="{{route('nueva-venta')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate">Nueva venta</span>
                        </a>
                    </li>
                    <li class="{{setActive('ventas')}}">
                        <a class="d-flex align-items-center" href="{{route('ventas')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate">Ventas realizadas</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li class=" nav-item">
                <a class="d-flex align-items-center" href="#">
                    <i data-feather='shopping-bag'></i>
                    <span class="menu-title text-truncate">Compras</span>
                </a>
                <ul class="menu-content">
                    <li class="{{setActive('nueva-compra')}}">
                        <a class="d-flex align-items-center" href="{{route('nueva-compra')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate">Nueva compra</span>
                        </a>
                    </li>
                    <li class="{{setActive('compras')}}">
                        <a class="d-flex align-items-center" href="{{route('compras')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate">Compras realizadas</span>
                        </a>
                    </li>
                </ul>
            </li>
            {{--<li class=" nav-item">
                <a class="d-flex align-items-center" href="#">
                    <i data-feather='grid'></i>
                    <span class="menu-title text-truncate" data-i18n="Dashboards">Almacen</span>
                </a>
                <ul class="menu-content">
                    <li>
                        <a class="d-flex align-items-center" href="#">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="Analytics">Reporte #1</span>
                        </a>
                    </li>
                    <li>
                        <a class="d-flex align-items-center" href="#">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="eCommerce">Reporte #2</span>
                        </a>
                    </li>
                </ul>
            </li>--}}
            <li class="nav-item {{setActive('kardex')}}">
                <a class="d-flex align-items-center" href="{{route('kardex')}}">
                    <i data-feather='folder'></i>
                    <span class="menu-title text-truncate">Kardex</span>
                </a>
            </li>
            <li class=" nav-item">
                <a class="d-flex align-items-center" href="#">
                    <i data-feather='credit-card'></i>
                    <span class="menu-title text-truncate" data-i18n="Dashboards">Movimientos</span>
                </a>
                <ul class="menu-content">
                    <li class="{{setActive('caja')}}">
                        <a class="d-flex align-items-center" href="{{route('caja')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate" data-i18n="Analytics">Caja</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li class=" navigation-header">
                <span data-i18n="Apps &amp; Pages">Operaciones</span>
                <i data-feather="more-horizontal"></i>
            </li>
            <li class=" nav-item">
                <a class="d-flex align-items-center" href="#">
                    <i data-feather='settings'></i>
                    <span class="menu-title text-truncate">Configuraciones</span>
                </a>
                <ul class="menu-content">
                    <li class="{{setActive('empresa')}}">
                        <a class="d-flex align-items-center" href="{{route('empresa')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate">Datos de la empresa</span>
                        </a>
                    </li>
                    <li class="{{setActive('usuarios')}}">
                        <a class="d-flex align-items-center" href="{{route('usuarios')}}">
                            <i data-feather="circle"></i>
                            <span class="menu-item text-truncate">Usuarios</span>
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>
<!-- END: Main Menu-->
