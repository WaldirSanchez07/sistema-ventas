<div class="modal fade text-start show" id="inlineForm" style="display: block;" tabindex="-1"
    aria-labelledby="myModalLabel33" aria-hidden="true" role="dialog">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h6 class="modal-title m-title" id="myModalLabel33">cliente - <b class="text-wprimary">Editar</b></h6>
            </div>
            <form class="needs-validation" novalidate>
                <div class="modal-body">
                    <div class="mb-1">
                        <label class="form-label" for="basic-addon-name">Nombre</label>
                        <input wire:model.defer="nombre" type="text"
                            class="form-control @error('nombre') is-invalid @enderror" aria-label="Name"
                            aria-describedby="basic-addon-name" required />
                        @error('nombre')
                            <small class="invalid-feedback">{{ $message }}</small>
                        @enderror
                    </div>
                    <div class="row">
                        <div class="col-lg">
                            <div class="mb-1">
                                <label class="form-label" for="select-country1">Documento</label>
                                <select wire:model.defer="documento"
                                    class="form-select @error('documento') is-invalid @enderror" required>
                                    <option value="">--- Seleccionar ---</option>
                                    @foreach ($tipoDoc as $t)
                                        <option value="{{ $t->id }}">{{ $t->tipo }}</option>
                                    @endforeach
                                </select>
                                @error('documento')
                                    <small class="invalid-feedback">{{ $message }}</small>
                                @enderror
                            </div>
                        </div>
                        <div class="col-lg">
                            <div class="mb-1">
                                <label class="form-label" for="basic-addon-name">Nro Documento</label>
                                <input wire:model.defer="nrodocumento" type="text"
                                    class="form-control @error('nrodocumento') is-invalid @enderror" aria-label="Name"
                                    aria-describedby="basic-addon-name" required />
                                @error('nrodocumento')
                                    <small class="invalid-feedback">{{ $message }}</small>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="mb-1">
                        <label class="form-label" for="basic-addon-name">Dirección</label>
                        <input wire:model.defer="direccion" type="text"
                            class="form-control @error('direccion') is-invalid @enderror" aria-label="Name"
                            aria-describedby="basic-addon-name" required />
                        @error('direccion')
                            <small class="invalid-feedback">{{ $message }}</small>
                        @enderror
                    </div>
                    <div class="mb-1">
                        <label class="form-label" for="basic-addon-name">Telefono</label>
                        <input wire:model.defer="telefono" type="text"
                            class="form-control @error('telefono') is-invalid @enderror" aria-label="Name"
                            aria-describedby="basic-addon-name" required />
                        @error('telefono')
                            <small class="invalid-feedback">{{ $message }}</small>
                        @enderror
                    </div>
                    <div class="mb-1">
                        <label class="form-label" for="basic-addon-name">Correo</label>
                        <input wire:model.defer="email" type="text"
                            class="form-control @error('email') is-invalid @enderror" aria-label="Name"
                            aria-describedby="basic-addon-name" required />
                        @error('email')
                            <small class="invalid-feedback">{{ $message }}</small>
                        @enderror
                    </div>
                </div>
                <div class="modal-footer">
                    <button wire:click="limpiarCampos" type="button" class="btn btn-outline-secondary"
                        data-bs-dismiss="modal">Cancelar</button>
                    <button wire:click.prevent="$emit('confirmUpdate',{{ $idCliente }})" type="button"
                        class="btn btn-primary" data-bs-dismiss="modal">Actualizar</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal-backdrop fade show"></div>
