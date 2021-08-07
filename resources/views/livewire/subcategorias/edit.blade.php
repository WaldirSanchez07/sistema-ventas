<x-modal>
    <div class="modal-header">
        <h6 class="modal-title m-title" id="myModalLabel33">
            <b class="text-wprimary">Editar</b> - Categoria
        </h6>
    </div>
    <form class="needs-validation" novalidate>
        <div class="modal-body">
            <div class="mb-1">
                <label class="form-label" for="basic-addon-name">Nombre</label>
                <input wire:model.defer="subcategoria" type="text"
                    class="form-control @error('subcategoria') is-invalid @enderror" aria-label="Name"
                    aria-describedby="basic-addon-name" required />
                @error('subcategoria')
                    <small class="invalid-feedback">{{ $message }}</small>
                @enderror
            </div>
            <div class="row">
                <div class="col-lg">
                    <label class="form-label">Categoría</label>
                    <select wire:model.defer="categoria_id" class="form-select @error('categoria_id') is-invalid @enderror">
                        <option value="">--- Seleccionar ---</option>
                        @foreach ($categorias as $c)
                            <option value="{{ $c->id_categoria }}">{{ $c->categoria }}</option>
                        @endforeach
                    </select>
                    @error('categoria_id')
                        <small class="text-danger">{{ $message }}</small>
                    @enderror
                </div>
                <div class="col-lg-4">
                    <label class="form-label" for="select-country1">Estado</label>
                    <select wire:model.defer="estado" class="form-select @error('estado') is-invalid @enderror"
                        required>
                        <option value="">--- Seleccionar ---</option>
                        <option value="Habilitado">Habilitado</option>
                        <option value="Deshabilitado">Deshabilitado</option>
                    </select>
                    @error('estado')
                        <small class="invalid-feedback">{{ $message }}</small>
                    @enderror
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button wire:click="limpiarCampos" type="button" class="btn btn-outline-secondary">Cancelar</button>
            <button wire:click="$emit('confirmUpdate',{{ $idSubcategoria }})" type="button"
                class="btn btn-primary">Actualizar</button>
        </div>
    </form>
</x-modal>
