<x-modal>
    <div class="modal-header">
        <h6 class="modal-title m-title" id="myModalLabel33">
            <b class="text-wprimary">Agregar</b> - Cliente
        </h6>
    </div>
    <form wire:submit.prevent="save" class="needs-validation" novalidate>
        <div class="modal-body">
            <div class="row">
                <div class="col-lg">
                    <div class="mb-1">
                        <label class="form-label" for="select-country1">Documento</label>
                        <select wire:model.defer="documento"
                            class="form-select @error('documento') is-invalid @enderror" id="select-country1" required>
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
                        <label class="form-label label">Nro Documento</label>
                        <div class="input-group">
                            <input wire:model.defer="nrodocumento" type="number" class="form-control">
                            <a wire:click="buscandoDatos()" class="btn btn-primary" id="button-addon2" type="button">
                                <i class="far fa-search-plus"></i>
                            </a>
                        </div>
                        @error('nrodocumento')
                            <small class="invalid-feedback">{{ $message }}</small>
                        @enderror
                    </div>
                </div>
            </div>
            <div class="mb-1">
                <label class="form-label" for="basic-addon-name">Nombre</label>
                <input wire:model.defer="nombre" type="text" class="form-control @error('nombre') is-invalid @enderror"
                    aria-label="Name" aria-describedby="basic-addon-name" required />
                @error('nombre')
                    <small class="invalid-feedback">{{ $message }}</small>
                @enderror
            </div>
            <div class="mb-1">
                <label class="form-label" for="basic-addon-name">Dirección</label>
                <input wire:model.defer="direccion" type="text" class="form-control @error('direccion') is-invalid @enderror" aria-label="Name" aria-describedby="basic-addon-name" required />
                @error('direccion')
                    <small class="invalid-feedback">{{ $message }}</small>
                @enderror
            </div>
            <div class="mb-1">
                <label class="form-label" for="basic-addon-name">Telefono</label>
                <input wire:model.defer="telefono" type="number"
                    class="form-control @error('telefono') is-invalid @enderror" aria-label="Name"
                    aria-describedby="basic-addon-name" required />
                @error('telefono')
                    <small class="invalid-feedback">{{ $message }}</small>
                @enderror
            </div>
            <div class="mb-1">
                <label class="form-label" for="basic-addon-name">Correo</label>
                <input wire:model.defer="email" type="text" class="form-control @error('email') is-invalid @enderror"
                    aria-label="Name" aria-describedby="basic-addon-name" required />
                @error('email')
                    <small class="invalid-feedback">{{ $message }}</small>
                @enderror
            </div>
        </div>
        <div class="modal-footer">
            <button wire:click="limpiarCampos" type="button" class="btn btn-outline-dark"
                data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">Guardar</button>
        </div>
    </form>
</x-modal>
