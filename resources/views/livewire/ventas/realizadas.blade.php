<main class="content-body">
    <div class="d-flex justify-content-between mb-2">
        <h2 class="content-header-title float-start mb-0 text-dark">Ventas realizadas</h2>
    </div>
    @php
        function Nformat($money)
        {
            return number_format($money, 2, '.', ',');
        }
    @endphp
    <div class="row">
        <div class="col-sm-12">
            <div class="card box-shadow">
                <div class="card-body">
                    <h6 class="mb-1">Filtros</h6>
                    <div class="input-group input-group-merge">
                        <span class="input-group-text" id="basic-addon-search2">
                            <i class="far fa-search"></i>
                        </span>
                        <input type="text" class="form-control" placeholder="Buscar..."
                            aria-label="Buscar..." aria-describedby="basic-addon-search2" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 mb-4">
            <div class="table-responsive bg-white box-shadow">
                <table class="table table-hover">
                    <thead class="table-secondary">
                        <tr>
                            <th>Fecha</th>
                            <th>Cliente</th>
                            <th>Subtotal</th>
                            <th>IGV</th>
                            <th>Total</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($ventas as $v)
                            <tr>
                                <td>{{ date('d/m/Y h:s a', strtotime($v->fecha)) }}</td>
                                <td width="40%">{{ $v->clientes->nombre }}</td>
                                <td>{{ $v->subtotal }}</td>
                                <td>{{ Nformat($v->igv) }}</td>
                                <td>{{ Nformat($v->total) }}</td>
                                <td>
                                    <button type="button"
                                        class="btn btn-icon btn-icon rounded-circle btn-flat-success title-detalle"
                                        wire:click="verDetalle({{ $v->id_venta }})" wire:loading.attr="disabled">
                                        <i class="fas fa-clipboard-list"></i>
                                    </button>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
                <div class="d-flex px-1 align-items-center">
                    <div class="col-lg-1">
                        <div class="mb-1">
                            <label class="form-label" for="basicSelect">Mostrar</label>
                            <select wire:model="paginate" class="form-select form-select-sm" id="basicSelect">
                                <option value="5">5</option>
                                <option value="10">10</option>
                                <option value="20">20</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg">
                        {{$ventas->links()}}
                    </div>
                </div>
            </div>
        </div>
    </div>
    @if ($_detalle)
        @include('livewire.ventas.ver-detalle')
    @endif
</main>
