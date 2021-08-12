<main class="content-body">
    <div class="d-flex justify-content-between mb-2">
        <h2 class="content-header-title float-start mb-0 text-dark">Historial de Movimientos</h2>
    </div>
    <div class="d-flex justify-content-between mb-2">
        <button type="button" class="btn btn-primary" wire:click="$set('_ingreso', true)">
            <i class="fal fa-plus-circle"></i>&nbsp;&nbsp;Ingreso&nbsp;&nbsp;
        </button>
        @foreach($lastregister as $l)
            @if($l->estado == false)
                <button type="button" class="btn btn-primary" wire:click="$set('_aperturacaja', true)">
                    &nbsp;&nbsp;Abrir Caja&nbsp;&nbsp;<i class="fal fa-lock-open-alt"></i>
                </button>
            @else
                <button type="button" class="btn btn-danger" wire:click="$set('_cierrecaja', true)">
                    &nbsp;&nbsp;Cerrar Caja&nbsp;&nbsp;<i class="fal fa-lock-open-alt"></i>
                </button>
            @endif
        @endforeach
        <button type="button" class="btn btn-danger" wire:click="$set('_egreso', true)">
            <i class="fal fa-minus-circle"></i>&nbsp;&nbsp;Egreso&nbsp;&nbsp;
        </button>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card box-shadow">
                <div class="card-body">
                    <h6 class="mb-1">Filtros</h6>
                    <div class="row">
                        <div class="col-lg">
                            <div class="input-group input-group-merge">
                                <span class="input-group-text" id="basic-addon-search2">
                                    <i class="far fa-search"></i>
                                </span>
                                <input wire:model="search" type="text" class="form-control" placeholder="Buscar movimiento..."
                                    aria-label="Buscar movimiento..." aria-describedby="basic-addon-search2" />
                            </div>
                        </div>
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
                            <th>ID</th>
                            <th>Fecha / Hora</th>
                            <th>Descripción</th>
                            <th>Monto</th>
                            <th>Saldo Actual</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($movimientos as $m)
                            <tr>
                                <td>{{ $m->id_caja }}</td>
                                <td>
                                    <div>
                                        {{ date('d/m/Y', strtotime($m->fecha)) }}
                                    </div>
                                    <div>
                                        {{\Carbon\Carbon::parse($m->fecha)->subMinute()->diffForHumans()}}
                                    </div>
                                </td>
                                <td>{{ $m->descripcion }}</td>
                                <td>
                                    @if($m->tipoMovimiento == '1')
                                        <div id="uno">
                                            <span class="badge rounded-pill bg-primary">
                                                {{ number_format($m->monto, 2) }}
                                            </span>
                                        </div>
                                    @else
                                        <div id="dos">
                                            <span class="badge rounded-pill bg-danger ">
                                                {{ number_format($m->monto, 2) }}
                                            </span>
                                        </div>
                                    @endif
                                </td>
                                <td>{{ number_format($m->saldo, 2) }}</td>
                                <td>
                                    <button type="button"
                                        class="btn btn-icon btn-icon rounded-circle btn-flat-success title-edit"
                                        wire:click="edit({{ $m->id_caja}})" wire:loading.attr="disabled">
                                        <i class="far fa-pen"></i>
                                    </button>
                                    <button type="button"
                                        class="btn btn-icon btn-icon rounded-circle btn-flat-danger title-delete"
                                        wire:click="$emit('confirmDelete',{{ $m->id_caja }})"
                                        wire:loading.attr="disabled">
                                        <i class="far fa-trash-alt"></i>
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
                        {{ $movimientos->links() }}
                    </div>
                </div>
            </div>
        </div>
    </div>

    @if ($_ingreso)
        @include('livewire.cajas.ingreso')
    @endif
    @if ($_aperturacaja)
        @include('livewire.cajas.aperturacaja')
    @endif
    @if ($_cierrecaja)
        @include('livewire.cajas.cierrecaja')
    @endif
    @if ($_egreso)
        @include('livewire.cajas.egreso')
    @endif
    {{-- Opciones --}}
    @if ($_edit)
        @include('livewire.cajas.editarcaja')
    @endif

    @push('js')
        <script>
            var isRtl = $('html').attr('data-textdirection') === 'rtl'
            const url = 'cajas';

            /****** Start events for Categoria *****/

            Livewire.on('confirmUpdate', id => {
                Swal.fire(
                    alertBody("El movimiento será actualizado.", 'btn-primary')
                ).then((result) => {
                    if (result.isConfirmed) {
                        Livewire.emitTo(url, 'update', id);
                    }
                })
            });

            Livewire.on('confirmDelete', id => {
                Swal.fire(
                    alertBody("El movimiento será eliminado.", 'btn-danger')
                ).then((result) => {
                    if (result.isConfirmed) {
                        Livewire.emitTo(url, 'delete', id);
                    }
                })
            });

            Livewire.on('alertSuccess', msj => {
                toastr['success'](`${msj}`, 'Progress Bar', {
                    closeButton: true,
                    tapToDismiss: false,
                    progressBar: true,
                    rtl: isRtl
                });
            })

            window.addEventListener('alertSuccess', event => {
                toastr['success'](`${event.detail.text}`, `${event.detail.title}`, {
                    closeButton: true,
                    tapToDismiss: false,
                    progressBar: true,
                    rtl: isRtl
                });
            })

            /****** End events for Tipo *****/

            function alertBody(texto, button) {
                let body = {
                    title: '¿Estás seguro?',
                    text: texto,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Confirmar',
                    cancelButtonText: 'Cancelar',
                    buttonsStyling: false,
                    customClass: {
                        confirmButton: 'btn round ' + button + '',
                        cancelButton: 'btn round btn-flat-dark',
                    }
                }
                return body;
            }
        </script>
    @endpush
</main>


