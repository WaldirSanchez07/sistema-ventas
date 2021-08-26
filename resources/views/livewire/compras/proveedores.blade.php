<x-modal class="modal-lg">
    <div class="modal-header">
        <h6 class="modal-title m-title" id="myModalLabel33">
            <b class="text-wprimary">Buscar</b> - Proveedor
        </h6>
        <button type="button" class="btn-close" wire:click="$set('_proveedor',false)"></button>
    </div>
    <div class="modal-body">
        <div class="input-group input-group-merge mb-1">
            <span class="input-group-text" id="basic-addon-search2">
                <i class="far fa-search"></i>
            </span>
            <input wire:model="search" type="text" class="form-control" placeholder="Buscar proveedor..."/>
        </div>
        <div class="table-responsive bg-white table-shadow position-relative">
            <table class="table table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Razón Social</th>
                        <th>Documento</th>
                        <th>N° Documento</th>
                        <th class="text-center">Agregar</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($proveedores as $p)
                        <tr>
                            <td width="45%">{{ $p->raz_social }}</td>
                            <td>{{ $p->tipos->tipo }}</td>
                            <td>{{ $p->nrodocumento }}</td>
                            <td class="text-center">
                                <button type="button"
                                    class="btn btn-flat-primary "
                                    wire:click="addCliente({{ $p->id_proveedor }})" wire:loading.attr="disabled">
                                    <i class="far fa-plus"></i>
                                </button>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="rotate" wire:loading wire:target="search">
                <i class="far fa-spinner-third fa-2x"></i>
            </div>
        </div>
    </div>
</x-modal>