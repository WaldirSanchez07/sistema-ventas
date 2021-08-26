<main>
    <section class="row">
        <div class="col-xl-2 col-md-4 col-sm-6">
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
        <div class="col-xl-2 col-md-4 col-sm-6">
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
        <div class="col-xl-2 col-md-4 col-sm-6">
            <div class="card text-center">
                <div class="card-body">
                    <div class="avatar bg-light-primary p-50 mb-1">
                        <div class="avatar-content">
                            <i class="far fa-money-bill-alt fa-2x"></i>
                        </div>
                    </div>
                    @if($inventario == null)
                        <h2 class="fw-bolder">0.00</h2>
                    @else
                        <h2 class="fw-bolder">{{ number_format($inventario->valor_total,2) }}</h2>
                    @endif

                    <p class="card-text">Inventario</p>
                </div>
            </div>
        </div>
         <div class="col-xl col-md col-sm-6">
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
        <div class="col-xl col-md col-sm-6">
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
        <div class="col-xl col-md col-sm-6">
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
        <div class="col-xl col-md col-sm">
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
    <section class="row">
        <div class="col-xl-6 col-md-6 col-sm-12">
            <div class="card">
                <div class="card-body">
                    <div id="barchart_values" style="height: 350px;"></div>
                </div>
            </div>
        </div>
        <div class="col-xl-6 col-md-6 col-sm-12">
            <div class="card">
                <div class="card-body">
                    <div id="productos" style="height: 350px;"></div>
                </div>
            </div>
        </div>
    </section>
    @push('scripts')
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    @endpush
    @push('js')
        <script type="text/javascript">
            google.charts.load("current", {
                packages: ["corechart"]
            });
            google.charts.setOnLoadCallback(draw_ingresos);
            google.charts.setOnLoadCallback(draw_productos);

            var chartArea = {
                left: "10%",
                top: "10%",
                height: "100%",
                width: "90%"
            };
            let ingresos = [
                ["Mes", "Monto", {
                    role: "style"
                }],
                ['Enero', 0, '#1E88E5'],
                ['Febrero', 0, '#C62828'],
                ['Marzo', 0, '#3F51B5'],
                ['Abril', 0, '#039BE5'],
                ['Mayo', 0, '#009688'],
                ['Junio', 0, '#FBC02D'],
                ['Julio', 0, '#4CAF50'],
                ['Agosto', 0, '#00C853'],
                ['Septiembre', 0, '#CDDC39'],
                ['Octubre', 0, '#3949AB'],
                ['Noviembre', 0, '#FF7043'],
                ['Diciembre', 0, '#607D8B']
            ];

            function draw_ingresos() {
                @foreach ($ventas as $v)
                    let mes = {{ $v->mes }};
                    for (let i = 0; i < 12; i++) { if(mes==i){ ingresos[i][1]=parseFloat({{ $v->total }}); } } @endforeach

                var data = google.visualization.arrayToDataTable(ingresos);

                var view = new google.visualization.DataView(data);

                view.setColumns([0, 1,
                    {
                        calc: "stringify",
                        sourceColumn: 1,
                        type: "string",
                        role: "annotation"
                    },
                    2
                ]);

                var options = {
                    title: "Ingresos por Mes del Año Actual",
                    chartArea,
                    bar: {
                        groupWidth: "95%"
                    },
                    legend: {
                        position: "none"
                    },

                };
                var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
                chart.draw(view, options);
            }

            function draw_productos() {
                var data = google.visualization.arrayToDataTable([
                    ['Productos', 'Cantidad'],
                    @foreach($productos as $p)
                    [`{{$p->producto}}`,{{$p->importe}}],
                    @endforeach
                ]);

                var options = {
                    title: 'Top 10 productos más vendidos',
                    is3D: true,
                    chartArea,
                };

                var chart = new google.visualization.PieChart(document.getElementById('productos'));
                chart.draw(data, options);
            }

            $(document).ready(function() {
                $(window).resize(function() {
                    draw_ingresos();
                    draw_productos();
                });
            });
        </script>
    @endpush
</main>
