<main>
    <section class="row">
        <div class="col-xl-12 col-md-12 col-sm-12">
            <div class="card">
                <div class="card-body">
                    <div class="text-center">
                        <img src="{{asset('images/logo2.png')}}" alt="Olano S.A.C" class="portada">
                    </div>
                    <br>
                    <p class="jumbotron">
                        Somos Distribuciones <b>Olano S.A.C</b>, una empresa peruana con más de 27 años de presencia a nivel nacional, comercializando todo lo que necesitas para realizar mejoras en tu hogar con productos de calidad y los mejores precios. Estamos para acompañarte en el proceso de construir el proyecto de tus sueños, con un servicio especializado de asesoramiento y de excelente atención. Tu positiva experiencia de compra es nuestro propósito y pasión.
                    </p>
                </div>
            </div>
        </div>
    </section>
    <section class="row justify-content-center">
        <div class="col-xl-3 col-md-4 col-sm-6">
            <div class="card text-center">
                <div class="card-body">
                    <div class="avatar bg-light-success p-50 mb-1">
                        <div class="avatar-content">
                            <i class="far fa-chart-line fa-2x"></i>
                        </div>
                    </div>
                    <h2 class="fw-bolder">{{ number_format($ingresos[0]->total, 2) }}</h2>
                    <p class="card-text">Ingresos</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-4 col-sm-6">
            <div class="card text-center">
                <div class="card-body">
                    <div class="avatar bg-light-danger p-50 mb-1">
                        <div class="avatar-content">
                            <i class="far fa-chart-line-down fa-2x"></i>
                        </div>
                    </div>
                    <h2 class="fw-bolder">{{ number_format($egresos[0]->total, 2) }}</h2>
                    <p class="card-text">Egresos</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-4 col-sm-6">
            <div class="card text-center">
                <div class="card-body">
                    <div class="avatar bg-light-primary p-50 mb-1">
                        <div class="avatar-content">
                            <i class="far fa-money-bill-alt fa-2x"></i>
                        </div>
                    </div>
                    <h2 class="fw-bolder">{{ number_format($inventario->valor_total ?? 0, 2) }}</h2>
                    <p class="card-text">Inventario</p>
                </div>
            </div>
        </div>
         <div class="col-xl-3 col-md-3 col-sm-6">
            <div class="card text-center">
                <div class="card-body">
                    <div class="avatar bg-light-secondary p-50 mb-1">
                        <div class="avatar-content">
                            <i class="far fa-truck fa-2x"></i>
                        </div>
                    </div>
                    <h2 class="fw-bolder">{{ $cpro }}</h2>
                    <p class="card-text">Proveedores</p>
                </div>
            </div>
        </div>
    </section>
    <section class="row justify-content-center">
        <div class="col-xl-3 col-md-3 col-sm-6">
            <div class="card text-center">
                <div class="card-body">
                    <div class="avatar bg-light-warning p-50 mb-1">
                        <div class="avatar-content">
                            <i class="far fa-box fa-2x"></i>
                        </div>
                    </div>
                    <h2 class="fw-bolder">{{ $cp }}</h2>
                    <p class="card-text">Productos</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-3 col-sm-6">
            <div class="card text-center">
                <div class="card-body">
                    <div class="avatar bg-light-info p-50 mb-1">
                        <div class="avatar-content">
                            <i class="far fa-user-tie fa-2x"></i>
                        </div>
                    </div>
                    <h2 class="fw-bolder">{{ $cc }}</h2>
                    <p class="card-text">Clientes</p>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-3 col-sm">
            <div class="card text-center">
                <div class="card-body">
                    <div class="avatar bg-light-dark p-50 mb-1">
                        <div class="avatar-content">
                            <i class="far fa-users fa-2x"></i>
                        </div>
                    </div>
                    <h2 class="fw-bolder">{{ $cu }}</h2>
                    <p class="card-text">Usuarios</p>
                </div>
            </div>
        </div>
    </section>
</main>
