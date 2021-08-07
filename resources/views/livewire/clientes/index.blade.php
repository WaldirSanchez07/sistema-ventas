<div>
    <x-slot name="header">
        <div class="col-12">
            <h2 class="content-header-title float-start mb-0">Clientes</h2>
            <div class="breadcrumb-wrapper">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">General</a></li>
                    <li class="breadcrumb-item active">Clientes</li>
                </ol>
            </div>
        </div>
    </x-slot>
    <!-- Accordion start -->
    <section id="clientes">
        <div class="mb-1">
            <button wire:click="$set('_create', true)" type="button" class="btn btn-primary">
                <i class="far fa-plus"></i>
                <span>Nuevo</span>
            </button>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="table-responsive bg-white table-shadow">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Nombres</th>
                                <th>Documento</th>
                                <th>N° documento</th>
                                <th>Dirección</th>
                                <th>Telefono</th>
                                <th>Email</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($clientes as $c)
                                <tr>
                                    <td>{{ $c->nombre }}</td>
                                    <td>{{ $c->tipos->tipo }}</td>
                                    <td>{{ $c->nrodocumento }}</td>
                                    <td>{{ $c->direccion }}</td>
                                    <td>{{ $c->telefono }}</td>
                                    <td>{{ $c->email }}</td>
                                    <td>
                                        <button type="button"
                                            class="btn btn-icon btn-icon rounded-circle btn-flat-success title-edit"
                                            wire:click="edit({{ $c->id_cliente }})" wire:loading.attr="disabled">
                                            <i class="far fa-pen"></i>
                                        </button>
                                        <button type="button"
                                            class="btn btn-icon btn-icon rounded-circle btn-flat-danger title-delete"
                                            wire:click="$emit('confirmDelete',{{ $c->id_cliente }})"
                                            wire:loading.attr="disabled">
                                            <i class="far fa-trash-alt"></i>
                                        </button>
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
                            {{ $clientes->links() }}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Accordion end -->
    @if ($_create)
        @include('livewire.clientes.create')
    @endif
    @if ($_edit)
        @include('livewire.clientes.edit')
    @endif

    @push('js')
        <script>
            var isRtl = $('html').attr('data-textdirection') === 'rtl'
            const url = 'clientes';

            /****** Start events for Categoria *****/

            Livewire.on('confirmUpdate', id => {
                Swal.fire(
                    alertBody("El cliente será actualizado.", 'btn-primary')
                ).then((result) => {
                    if (result.isConfirmed) {
                        Livewire.emitTo(url, 'update', id);
                    }
                })
            });

            Livewire.on('confirmDelete', id => {
                Swal.fire(
                    alertBody("El cliente será eliminado.", 'btn-danger')
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
                        confirmButton: 'btn btn-round ' + button + '',
                        cancelButton: 'btn btn-round btn-default ml-2',
                    }
                }
                return body;
            }
        </script>
    @endpush
</div>
