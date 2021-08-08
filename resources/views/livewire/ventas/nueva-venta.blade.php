<main class="content-body">
    <div class="d-flex justify-content-between mb-2">
        <h2 class="content-header-title float-start mb-0 text-dark">Nueva venta</h2>
    </div>
    @php
        function Nformat($money)
        {
            return number_format($money, 2, '.', ',');
        }
    @endphp
    <div class="row">
        <div class="col-lg-8">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-1 align-items-center">
                                <h6 class="m-0">
                                    <i class="fas fa-user-tie"></i>&nbsp;&nbsp;Información del cliente
                                </h6>
                                <button class="btn btn-sm btn-info" wire:click="$set('_clientes', true)">
                                    <i class="far fa-search-plus"></i>&nbsp;&nbsp;Buscar
                                </button>
                            </div>
                            <div class="row">
                                <div class="col-lg-6 mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">Nombre</label>
                                        <input value="{{ $cliente }}" class="form-control" type="text" disabled>
                                    </div>
                                </div>
                                <div class="col-lg mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">Tipo de documento</label>
                                        <input value="{{ $documento }}" class="form-control" type="text" disabled>
                                    </div>
                                </div>
                                <div class="col-lg mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">N° de documento</label>
                                        <input value="{{ $nDoc }}" class="form-control" type="text" disabled>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between mb-1">
                                <h6 class="m-0">
                                    <i class="fas fa-box"></i>&nbsp;&nbsp;Información del producto
                                </h6>
                            </div>
                            <div class="row">
                                <div class="col-lg mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">SKU</label>
                                        <div class="input-group">
                                            <input wire:model.defer="sku" type="number" class="form-control">
                                            <button class="btn btn-info" id="button-addon2" type="button">
                                                <i class="far fa-search-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">Nombre</label>
                                        <input value="{{ $producto }}" class="form-control" type="text" disabled>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-3 mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">Stock</label>
                                        <input value="{{ $stock }}" class="form-control" type="number"
                                            placeholder="0.00" disabled>
                                    </div>
                                </div>
                                <div class="col-lg-3 mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">Precio</label>
                                        <input value="{{ Nformat($precio) }}" class="form-control box" type="number"
                                            placeholder="0.00" disabled>
                                    </div>
                                </div>
                                <div class="col-lg-3 mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">Catidad</label>
                                        <input wire:model="cantidad" class="form-control box" type="number"
                                            placeholder="0.00">
                                    </div>
                                </div>
                                <div class="col-lg-3 mb-1">
                                    <div class="form-group input">
                                        <label class="form-label label">Subtotal</label>
                                        <input value="{{ Nformat($_subtotal) }}" class="form-control" type="number"
                                            placeholder="0.00" disabled>
                                    </div>
                                </div>
                            </div>
                            <form class="text-end" wire:submit.prevent="addDetalle">
                                <button type="submit" wire:loading.attr="disabled" class="btn btn-success">
                                    Agregar
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 mt-2">
                    <div class="table-responsive bg-white table-shadow">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Código</th>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                    <th>Subtotal</th>
                                    <th>Quitar</th>
                                </tr>
                            </thead>
                            <tbody>
                                @php
                                    $i = 0;
                                @endphp
                                @if (count($table) > 0)
                                    @foreach ($table as $t)
                                        <tr>
                                            <td>{{ $i += 1 }}</td>
                                            <td>{{ $t['sku'] }}</td>
                                            <td title="{{ $t['producto'] }}">
                                                {{ substr($t['producto'], 0, 40) }}{{ strlen($t['producto']) > 40 ? '...' : '' }}
                                            </td>
                                            <td>{{ $t['cantidad'] }}</td>
                                            <td>{{ Nformat($t['precio']) }}</td>
                                            <td>{{ Nformat($t['subtotal']) }}</td>
                                            <td>
                                                <button title="Quitar" wire:click="removeDetalle({{ $t['sku'] }})"
                                                    class="btn icon-btn btn-sm btn-outline-danger">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    @endforeach
                                    <tr class="font-weight-bold">
                                        <td colspan="4"></td>
                                        <td>Total:</td>
                                        <td>{{ Nformat($subtotal) }}</td>
                                        <td></td>
                                    </tr>
                                @else
                                    <tr>
                                        <td colspan="7" class="text-center">
                                            No hay registros
                                        </td>
                                    </tr>
                                @endif
                            </tbody>
                        </table>
                    </div>
                    <div class="rotate" wire:loading wire:target="search">
                        <i class="far fa-spinner-third fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg">
            <div class="card">
                <div class="card-body">
                    <h6>
                        Datos de la venta
                    </h6>
                    <div class="form-group mb-1">
                        <label class="form-label label">Fecha</label>
                        <input type="date" value="{{ date('Y-m-d') }}" class="form-control" type="text" disabled>
                    </div>
                    <div class="form-group mb-1">
                        <label class="form-label label">Descuento</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">%</span>
                            </div>
                            <input type="number" class="form-control" placeholder="0.00"
                                value="{{ Nformat($porcent) > 0 ?? '' }}">
                        </div>
                    </div>
                    <div class="form-group mb-1">
                        <label class="form-label label">Total pagado</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">S/</span>
                            </div>
                            <input type="number" class="form-control" placeholder="0.00" wire:model="pagado">
                        </div>
                    </div>
                    <div class="form-group mb-1">
                        <label class="form-label label">Total devuelto</label>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text">S/</span>
                            </div>
                            <input type="number" class="form-control" placeholder="0.00"
                                value="{{ Nformat($vuelto) }}" disabled>
                        </div>
                    </div>
                    <div class="form-group d-flex flex-column gap-1">
                        <div class="d-flex justify-content-between">
                            <label class="form-label">Subtotal:</label>
                            <span class="_label">{{ Nformat($subtotal) }}</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <label class="form-label">IGV(18%):</label>
                            <span class="_label">{{ Nformat($igv) }}</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <label class="form-label">Descuento:</label>
                            <span class="_label text-danger">{{ Nformat($descuento) }}</span>
                        </div>
                        <hr class="border-secondary">
                        <div class="d-flex justify-content-between">
                            <h6 class="_label font-weight-bold">Total:</h6>
                            <span class="_label font-weight-bold">{{ Nformat($total) }}</span>
                        </div>
                    </div>
                    <div class="text-center">
                        <button wire:click="save" class="btn btn-outline-primary" @if (!$active) disabled @endif>
                            Procesar venta
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
<main