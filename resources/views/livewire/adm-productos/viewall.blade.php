<main>
    <div class="content-detached content-right">
        <div class="content-body">
            <!-- E-commerce Content Section Starts -->
            <section id="ecommerce-header">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="ecommerce-header-items">
                            <div class="result-toggler">
                                <button class="navbar-toggler shop-sidebar-toggler" type="button"
                                    data-bs-toggle="collapse">
                                    <span class="navbar-toggler-icon d-block d-lg-none"><i
                                            data-feather="menu"></i></span>
                                </button>
                                <div class="search-results">{{ $productos->count() . ' de ' . $total }} de productos
                                </div>
                            </div>
                            <div class="view-options d-flex">
                                <div class="btn-group" role="group">
                                    <input type="radio" class="btn-check" name="radio_options" id="radio_option2"
                                        autocomplete="off" checked />
                                    <label class="btn btn-icon btn-outline-primary view-btn list-view-btn"
                                        for="radio_option2"><i data-feather="list" class="font-medium-3"></i></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- E-commerce Content Section Starts -->

            <!-- background Overlay when sidebar is shown  starts-->
            <div class="body-content-overlay"></div>
            <!-- background Overlay when sidebar is shown  ends-->

            <!-- E-commerce Search Bar Starts -->
            <section id="ecommerce-searchbar" class="ecommerce-searchbar">
                <div class="row mt-1">
                    <div class="col-sm-12">
                        <div class="input-group input-group-merge">
                            <input wire:model="search" type="text" class="form-control search-product" id="shop-search"
                                placeholder="Buscar Producto" aria-label="Search..." aria-describedby="shop-search" />
                            <span class="input-group-text"><i data-feather="search" class="text-muted"></i></span>
                        </div>
                    </div>
                </div>
            </section>
            <!-- E-commerce Search Bar Ends -->

            <!-- E-commerce Products Starts -->
            <section id="ecommerce-products" class="list-view">
                @foreach ($productos as $p)
                    <div class="card ecommerce-card">
                        <div class="item-img text-center">
                            <a href="javascript:void(0);">
                                <img class="img-fluid card-img-top" src="{{ asset('storage/' . $p->foto) }}"
                                    alt="img-placeholder" /></a>
                        </div>
                        <div class="card-body">
                            <h6 class="item-name">
                                <a class="text-body" href="javascript:void(0);">{{ $p->producto }}</a>
                                {{--<span class="card-text item-company">By <a href="#"
                                        class="company-name">Apple</a></span>--}}
                            </h6>
                            <div class="item-wrapper">
                                <div class="row">
                                    <div class="col-lg">
                                        <i class="fad fa-box"></i>
                                        <b>&nbsp;Stock:&nbsp;</b>{{ $p->stock }}
                                    </div>
                                    <div class="col-lg">
                                        <i class="fad fa-ruler"></i>
                                        <b>&nbsp;Medida:&nbsp;</b>{{ $p->medidas->medida }}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg">
                                        <i class="fad fa-calendar-alt"></i>
                                        <b>&nbsp;Vencimiento:&nbsp;</b>
                                        {{ $p->fecha_vence ? date('d/m/Y', strtotime($p->fecha_vence)) : 'No vence' }}
                                    </div>
                                </div>
                            </div>
                            <p class="card-text item-description">
                                On Retina display that never sleeps, so it’s easy to see the time and other important
                                information, without
                            </p>
                        </div>
                        <div class="item-options text-center">
                            <div class="item-wrapper">
                                <div class="item-cost">
                                    <h4 class="item-price">{{ 'S/' . number_format($p->precio_venta, 2) }}</h4>
                                </div>
                            </div>
                            <button class="btn btn-light btn-wishlist" style="cursor: default">
                                <i class="fas fa-barcode"></i>
                                <span>{{ 'SKU: ' . $p->id_producto }}</span>
                            </button>
                            <button class="btn btn-primary btn-copy" data-sku="{{$p->id_producto}}">
                                <i class="far fa-copy"></i>
                                <span class="add-to-cart">Copiar SKU</span>
                            </button>
                        </div>
                    </div>
                @endforeach
            </section>
            <!-- E-commerce Products Ends -->

            <!-- E-commerce Pagination Starts -->
            <section class="d-flex justify-content-center">
                {{ $productos->links() }}
            </section>
            <!-- E-commerce Pagination Ends -->
        </div>
    </div>
    <div class="sidebar-detached sidebar-left">
        <div class="sidebar">
            <!-- Ecommerce Sidebar Starts -->
            <div class="sidebar-shop">
                <div class="row">
                    <div class="col-sm-12">
                        <h6 class="filter-heading d-none d-lg-block">Filtros</h6>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <!-- Categories Starts -->
                        <div id="product-categories">
                            <h6 class="filter-title mt-0">Categorias</h6>
                            <ul class="list-unstyled categories-list">
                                <li>
                                    <div class="form-check">
                                        <input wire:model="categoria" type="radio" id="category" name="category"
                                            class="form-check-input" value="" checked />
                                        <label class="form-check-label" for="category">Todo</label>
                                    </div>
                                </li>
                                @foreach ($categorias as $c)
                                    <li>
                                        <div class="form-check">
                                            <input wire:model="categoria" type="radio"
                                                id="category{{ $c->categoria_id }}" name="category"
                                                class="form-check-input" value="{{ $c->categoria_id }}" />
                                            <label class="form-check-label" for="category{{ $c->categoria_id }}">
                                                {{ $c->categorias->categoria }}
                                            </label>
                                        </div>
                                    </li>
                                @endforeach
                            </ul>
                        </div>
                        <!-- Categories Ends -->

                        <!-- Brands starts -->
                        <div class="brands">
                            <h6 class="filter-title">Subcategorias</h6>
                            <ul class="list-unstyled brand-list">
                                <li>
                                    <div class="form-check">
                                        <input wire:model="subcategoria" type="radio" id="sub" name="subcategory"
                                            class="form-check-input" value="" checked />
                                        <label class="form-check-label" for="sub">Todo</label>
                                    </div>
                                </li>
                                @foreach ($subcategorias as $s)
                                    <li>
                                        <div class="form-check">
                                            <input wire:model="subcategoria" type="radio"
                                                id="sub{{ $s->id_subcategoria }}" name="subcategory"
                                                class="form-check-input" value="{{ $s->id_subcategoria }}" />
                                            <label class="form-check-label" for="sub{{ $s->id_subcategoria }}">
                                                {{ $s->subcategoria }}
                                            </label>
                                        </div>
                                    </li>
                                @endforeach
                            </ul>
                        </div>
                        <!-- Brand ends -->

                        <!-- Clear Filters Starts -->
                        <div id="clear-filters">
                            <button wire:click="limpiar" type="button" class="btn w-100 btn-primary">Limpiar filtros</button>
                        </div>
                        <!-- Clear Filters Ends -->
                    </div>
                </div>
            </div>
            <!-- Ecommerce Sidebar Ends -->
        </div>
    </div>
    @push('styles')
        <link rel="stylesheet" type="text/css" href="{{ asset('rs/vendors/css/extensions/nouislider.min.css') }}">
        <link rel="stylesheet" type="text/css" href="{{ asset('rs/css/pages/dashboard-ecommerce.css') }}">
        <link rel="stylesheet" type="text/css" href="{{ asset('rs/css/pages/app-ecommerce.css') }}">
    @endpush
    @push('scripts')
        <script src="{{ asset('rs/vendors/js/extensions/wNumb.min.js') }}"></script>
        <script src="{{ asset('rs/vendors/js/extensions/nouislider.min.js') }}"></script>
        <script src="{{ asset('rs/js/scripts/pages/app-ecommerce.js') }}"></script>
    @endpush
    @push('js')
        <script>
            var isRtl = $('html').attr('data-textdirection') === 'rtl';
            function copyToClipboard(value) {
                var tempInput = document.createElement('input');
                tempInput.value = value;
                document.body.appendChild(tempInput);
                tempInput.select();
                toastr['success'](tempInput.value.split("'")[1], 'SKU copiado! 📋', {
                    closeButton: true,
                    tapToDismiss: false,
                    rtl: isRtl
                });
                document.execCommand('copy');
                document.body.removeChild(tempInput);
            }

            // Copy Icon On Click
            $(document).on('click', '.btn-copy', function() {
                var $this = $(this),
                iconCode = $this.data('sku');
                copyToClipboard(iconCode);
            });
        </script>
    @endpush
</main>