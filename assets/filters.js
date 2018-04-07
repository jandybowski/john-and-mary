/*jslint browser: true*/
/*global $, jQuery, alert, console, dict, prices, pricesRegular, images, shipping*/

(function ($) {
    'use strict';
    $.fn.productFilters = function (options) {
        var s,
            gs = $.extend({}, $.fn.productFilters.defaults, options),
            ProductFilters = {
                settings: {
                    filterActiveProperty: window.location.search,
                    filterSectionHandler: $(gs.filterSectionHandler),

                    filterProperties: gs.filterProperties,
                    filterPropertiesHandler: gs.filterPropertiesHandler,
                    filterPropertiesWrapper: $(gs.filterPropertiesWrapper),
                    filterPropertiesMultiple: gs.filterPropertiesMultiple,

                    filterVendor: gs.filterVendor,
                    filterVendorHandler: gs.filterVendorHandler,
                    filterVendorWrapper: $(gs.filterVendorWrapper),
                    filterVendorMultiple: gs.filterVendorMultiple,

                    filterPrice: gs.filterPrice,
                    filterPriceHandler: gs.filterPriceHandler,
                    filterPriceWrapper: $(gs.filterPriceWrapper),
                    filterPriceMultiple: gs.filterPriceMultiple,

                    filterSort: gs.filterSort,
                    filterSortHandler: gs.filterSortHandler,
                    filterSortWrapper: $(gs.filterSortWrapper),
                    filterSortMultiple: gs.filterSortMultiple,

                    filterTags: gs.filterTags,
                    filterTagsHandler: gs.filterTagsHandler,
                    filterTagsWrapper: $(gs.filterTagsWrapper),
                    filterTagsMultiple: gs.filterTagsMultiple,

                    filterUseSelectric: gs.filterUseSelectric,

                    sliderRangeHandler: $(gs.sliderRangeHandler),
                    sliderRangeAmountMinHandler: $(gs.sliderRangeAmountMinHandler),
                    sliderRangeAmountMaxHandler: $(gs.sliderRangeAmountMaxHandler),
                    sliderRangeConfirmHandler: $(gs.sliderRangeConfirmHandler),
                    sliderRangeMinValueDefault: gs.sliderRangeMinValueDefault,
                    sliderRangeMaxValueDefault: gs.sliderRangeMaxValueDefault,

                    prodListContainer: gs.prodListContainer,
                    gridCol2: $(gs.gridCol2),
                    gridCol3: $(gs.gridCol3),

                    selectUrl: $(gs.selectUrl)
                },
                init: function () {
                    s = this.settings;

                    this.bindUIActions();
                    this.initFilters();
	
                },

                bindUIActions: function () {
                    s.filterSectionHandler.find('input[type="checkbox"]').on('click', function () {
                        var $this = $(this),
                            $thisParentType = $(this).closest(s.filterSectionHandler).data('filter-type');

                        if ($thisParentType == 'filter-property' && s.filterPropertiesHandler == 'checkbox' && s.filterPropertiesMultiple === false) {
                            ProductFilters.checkActiveCheckboxOption($this);
                            localStorage.removeItem('properties['+$this.attr('data-name')+']');
                        } else if ($thisParentType == 'filter-vendor' && s.filterVendorHandler == 'checkbox' && s.filterVendorMultiple === false) {
                            ProductFilters.checkActiveCheckboxOption($this);
                        } else if ($thisParentType == 'filter-tags' && s.filterTagsHandler == 'checkbox' && s.filterTagsMultiple === false) {
                            ProductFilters.checkActiveCheckboxOption($this);
                        } else if ($thisParentType == 'filter-sort' && s.filterSortHandler == 'checkbox') {
                            ProductFilters.checkActiveCheckboxOption($this);
                        } else if ($thisParentType == 'filter-price' && s.filterPriceHandler == 'checkbox') {
                            ProductFilters.checkActiveCheckboxOption($this);
                        }

                        ProductFilters.filterResults();
                    });

                    s.filterSectionHandler.find('select').on('change', function () {
                        var $this = $(this);
                        ProductFilters.filterResults();
                    });

                    s.sliderRangeConfirmHandler.on('click',function(e){
                        e.preventDefault();
                        ProductFilters.filterResults();
                    });
                    s.gridCol2.on('click', function(){
                      $(this).addClass('active');
                      s.gridCol3.removeClass('active');
                      s.prodListContainer.find('.span-prod-3').removeClass('span-prod-3').addClass('span-prod-2');
                    });
                    s.gridCol3.on('click', function(){
                      $(this).addClass('active');
                      s.gridCol2.removeClass('active');
                      s.prodListContainer.find('.span-prod-2').removeClass('span-prod-2').addClass('span-prod-3');
                    });

                    s.selectUrl.on('change', function(){
                        var $this = $(this);
                        ProductFilters.selectGoToUrl($this);
                    });

                },

                checkActiveCheckboxOption: function(target) {
                    if(target.is(':checked')){
                       target.closest(s.filterSectionHandler).find('input[type="checkbox"]').each(function(){
                            $(this).prop('checked',false);
                        });
                        target.prop('checked', true);
                    }
                },

                findActiveFilterProperties: function(filterActiveProperty) {
                    var propertiesStorage = [];

                    if (s.filterPropertiesHandler == 'checkbox') {
                        s.filterPropertiesWrapper.find('input[type="checkbox"]').each(function(){
                            propertiesStorage.push('properties['+$(this).attr('data-name')+']');

                            clearPropertiesStorage(propertiesStorage);

                            var $this = $(this);
                            if (s.filterPropertiesMultiple === true) {
                                $.each( propertiesStorage, function( i, val ) {
                                    if (localStorage.getItem(val) !== null ) {
                                        var localStoragePropertyValues = localStorage.getItem(val).split('+');
                                        if ( localStoragePropertyValues.indexOf($this.val()) > -1 ) {
                                            $this.attr('checked','checked');
                                        }
                                    }
                                });
                            } else {
                                $.each( propertiesStorage, function( i, val ) {
                                    if ( localStorage.getItem(val) == $this.val() ) {
                                        $this.attr('checked','checked');
                                    }
                                });
                            }
                        });
                    } else if (s.filterPropertiesHandler == 'select') {
                        s.filterPropertiesWrapper.find('select option').each(function(){
                            propertiesStorage.push('properties['+$(this).parent().attr('data-name')+']');
                            var $this = $(this);

                            clearPropertiesStorage(propertiesStorage);

                            $.each( propertiesStorage, function( i, val ) {
                                if ( localStorage.getItem(val) == $this.val() ) {
                                    $this.attr('selected','selected');
                                }
                            });

                        });
                        if (s.filterUseSelectric === true) {
                            s.filterPropertiesWrapper.find('select').selectric('refresh');
                        }
                    }

                    function clearPropertiesStorage(propertiesStorage) {
                        if ( filterActiveProperty == '') {
                            $.each( propertiesStorage, function( i, val ) {
                                localStorage.removeItem(val);
                            });
                        }
                    }
                },

                findActiveFilterVendors: function(filterActiveProperty) {
                    var vendorsStorage = [];

                    if ( filterActiveProperty == '') {
                        localStorage.removeItem('vendor');
                    }

                    if (s.filterVendorHandler == 'checkbox') {
                        s.filterVendorWrapper.find('input[type="checkbox"]').each(function(){
                            var $this = $(this);
                            if (s.filterVendorMultiple === true && localStorage.getItem('vendor') !== null) {
                                vendorsStorage = localStorage.getItem('vendor').split('+');
                                 $.each( vendorsStorage, function( i, val ) {
                                    if ( val == $this.val() ) {
                                        $this.attr('checked','checked');
                                    }
                                 });
                            } else {
                                if ( localStorage.getItem('vendor') == $this.val() ) {
                                    $this.attr('checked','checked');
                                }
                            }
                        });
                    } else if (s.filterVendorHandler == 'select') {
                        s.filterVendorWrapper.find('select option').each(function(){
                            var $this = $(this);

                            if ( localStorage.getItem('vendor') == $this.val() ) {
                                $this.attr('selected','selected');
                            }
                        });
                        if (s.filterUseSelectric === true) {
                            s.filterVendorWrapper.find('select').selectric('refresh');

                        }
                    }
                },

                findActiveFilterTags: function(filterActiveProperty) {
                    var tagsStorage = [];

                    if ( filterActiveProperty == '') {
                        localStorage.removeItem('tags');
                    }

                    if (s.filterTagsHandler == 'checkbox') {
                        s.filterTagsWrapper.find('input[type="checkbox"]').each(function(){
                            var $this = $(this);
                            if (s.filterTagsMultiple === true && localStorage.getItem('tags') !== null) {
                                tagsStorage = localStorage.getItem('tags').split('+');
                                 $.each( tagsStorage, function( i, val ) {
                                    if ( val == $this.val() ) {
                                        $this.attr('checked','checked');
                                    }
                                 });
                            } else {
                                if ( localStorage.getItem('tags') == $this.val() ) {
                                    $this.attr('checked','checked');
                                }
                            }
                        });
                    } else if (s.filterTagsHandler == 'select') {
                        s.filterTagsWrapper.find('select option').each(function(){
                            var $this = $(this);

                            if ( localStorage.getItem('tags') == $this.val() ) {
                                $this.attr('selected','selected');
                            }
                        });
                        if (s.filterUseSelectric === true) {
                            s.filterTagsWrapper.find('select').selectric('refresh');

                        }
                    }
                },

                findActiveFilterSort: function(filterActiveProperty) {
                    var sortStorage = [];

                    if ( filterActiveProperty == '') {
                        localStorage.removeItem('sort');
                    }

                    if (s.filterSortHandler == 'checkbox') {
                        s.filterSortWrapper.find('input[type="checkbox"]').each(function(){
                            var $this = $(this);

                            if ( localStorage.getItem('sort') == $this.val() ) {
                                $this.attr('checked','checked');
                            }

                        });
                    } else if (s.filterSortHandler == 'select') {
                        s.filterSortWrapper.find('select option').each(function(){
                            var $this = $(this);

                            if ( localStorage.getItem('sort') == $this.val() ) {
                                $this.attr('selected','selected');
                            }
                        });
                        if (s.filterUseSelectric === true) {
                            s.filterSortWrapper.find('select').selectric('refresh');

                        }
                    }
                },

                findActiveFilterPrice: function(filterActiveProperty) {
                    if ( filterActiveProperty == '') {
                        localStorage.removeItem('price_from');
                        localStorage.removeItem('price_to');
                    }

                    var priceFrom = localStorage.getItem('price_from'),
                        priceTo = localStorage.getItem('price_to');

                    if (s.filterPriceHandler == 'checkbox') {
                        s.filterPriceWrapper.find('input[type="checkbox"]').each(function(){
                            var $this = $(this),
                                dataMin = $this.data('min'),
                                dataMax = $this.data('max');

                            if ( priceFrom == dataMin && priceTo == dataMax) {
                                $this.attr('checked','checked');
                            }

                        });
                    } else if (s.filterPriceHandler == 'select') {
                        s.filterPriceWrapper.find('select option').each(function(){
                            var $this = $(this),
                                dataMin = $this.data('min'),
                                dataMax = $this.data('max');

                            if ( priceFrom == dataMin && priceTo == dataMax) {
                                $this.attr('selected','selected');
                            }
                        });
                        if (s.filterUseSelectric === true) {
                            s.filterPriceWrapper.find('select').selectric('refresh');

                        }
                    } else if (s.filterPriceHandler == 'slider-range') {
                        var priceMin = priceFrom;
                        var priceMax = priceTo;
                        var currency = s.sliderRangeAmountMinHandler.data('currency');
                        if (priceMin === null){
                            priceMin = s.sliderRangeMinValueDefault;
                        }
                        if (priceMax === null){
                            priceMax = s.sliderRangeMaxValueDefault;
                        }
						console.log(s.sliderRangeMinValueDefault);
						console.log(s.sliderRangeMaxValueDefault);
                        console.log(priceMin + '  ' +priceMax);
                        s.sliderRangeHandler.slider({
                            range: true,
                            min: s.sliderRangeMinValueDefault,
                            max: s.sliderRangeMaxValueDefault,
                            values: [ priceMin, priceMax ],
                            slide: function( event, ui ) {
                                s.sliderRangeAmountMinHandler.val(  ui.values[ 0 ].toFixed(2) + ' ' + currency);
                                s.sliderRangeAmountMaxHandler.val(  ui.values[ 1 ].toFixed(2) + ' ' + currency);

                                s.sliderRangeAmountMinHandler.data('min',ui.values[ 0 ].toFixed(2));
                                s.sliderRangeAmountMaxHandler.data('max',ui.values[ 1 ].toFixed(2));
                            }
                        });

                        s.sliderRangeAmountMinHandler.data('min', priceMin);
                        s.sliderRangeAmountMaxHandler.data('max', priceMax);

                        s.sliderRangeAmountMinHandler.val( s.sliderRangeHandler.slider( "values", 0 ).toFixed(2)  + ' ' + currency);
                        s.sliderRangeAmountMaxHandler.val( s.sliderRangeHandler.slider( "values", 1 ).toFixed(2) + ' ' + currency);
                    }
                },

                filterResultsProperties: function() {
                    var properties = [],
                        propertiesStorage = [],
                        propertiesArray = [],
                        propertiesArray2 = [];

                    if (s.filterPropertiesHandler == 'checkbox') {
                        s.filterPropertiesWrapper.find('input[type="checkbox"]').each(function(){
                            if ( $(this).is(':checked') ) {
                                if (s.filterPropertiesMultiple === true) {
                                    var thisPropertiesArray = [];
                                    propertiesArray.push($(this).val());
                                    propertiesArray2 = propertiesArray.join('+');
                                    properties = 'properties['+$(this).attr('data-name')+']=' + propertiesArray2;
                                    propertiesStorage = 'properties['+$(this).attr('data-name')+']'
                                } else {
                                    properties.push('properties['+$(this).attr('data-name')+']='+$(this).val());
                                    localStorage.removeItem('properties['+$(this).attr('data-name')+']');
                                    localStorage.setItem('properties['+$(this).attr('data-name')+']', $(this).val());
                                }
                            }
                        });
                        if (s.filterPropertiesMultiple === true) {
                            localStorage.setItem(propertiesStorage, propertiesArray2);
                        } else {
                            properties = properties.join('&');
                        }
                        console.log(properties);
                    } else if (s.filterPropertiesHandler == 'select') {
                        s.filterPropertiesWrapper.find('select').each(function(){
                            if ( $(this).find('option:selected').val() != 0 )
                            {
                                properties.push('properties['+$(this).attr('data-name')+']='+$(this).find('option:selected').val());
                                localStorage.removeItem('properties['+$(this).attr('data-name')+']');
                                localStorage.setItem('properties['+$(this).attr('data-name')+']', $(this).val());
                            } else if ($(this).find('option:selected').val() == 0) {
                                localStorage.removeItem('properties['+$(this).attr('data-name')+']');
                            }
                        });
                        properties = properties.join('&');
                    }
                    console.log(properties);
                    return properties;
                },

                filterResultsVendors: function() {
                    var vendors = [],
                        vendorsArray = [];

                    if (s.filterVendorHandler == 'checkbox') {
                        s.filterVendorWrapper.find('input[type="checkbox"]').each(function(){
                            if ( $(this).is(':checked') ) {
                                if ( $(this).val() != 0 ) {
                                    if (s.filterTagsMultiple === true) {
                                        vendors.push($(this).val());
                                        vendorsArray = vendors.join('+');
                                    } else {
                                        vendorsArray.push($(this).val());
                                    }
                                }
                            }
                        });
                    } else if (s.filterVendorHandler == 'select') {
                        s.filterVendorWrapper.find('select').each(function(){
                            if ( $(this).find('option:selected').val() != 0 ) {
                                vendorsArray.push($(this).val());
                            }
                        });
                    }
                    localStorage.removeItem('vendor');
                    if ( vendorsArray.length !== 0 ) {
                        localStorage.setItem('vendor', vendorsArray);
                    }
                    return vendorsArray;
                },

                filterResultsTags: function() {
                    var tags = [],
                        tagsArray = [];

                    if (s.filterTagsHandler == 'checkbox') {
                        s.filterTagsWrapper.find('input[type="checkbox"]').each(function(){
                            if ( $(this).is(':checked') ) {
                                if ( $(this).val() != 0 ) {
                                    if (s.filterTagsMultiple === true) {
                                        tags.push($(this).val());
                                        tagsArray = tags.join('+');
                                    } else {
                                        tagsArray.push($(this).val());
                                    }
                                }
                            }
                        });
                    } else if (s.filterTagsHandler == 'select') {
                        s.filterTagsWrapper.find('select').each(function(){
                            if ( $(this).find('option:selected').val() != 0 ) {
                                tagsArray.push($(this).val());
                            }
                        });
                    }

                    localStorage.removeItem('tags');
                    if ( tagsArray != '' ) {
                        localStorage.setItem('tags', tagsArray);
                    }

                    return tagsArray;
                },

                filterResultsSort: function() {
                    var sortArray = [];

                    if (s.filterSortHandler == 'checkbox') {
                        s.filterSortWrapper.find('input[type="checkbox"]').each(function(){
                            if ( $(this).is(':checked') ) {
                                if ( $(this).val() != 0 ) {
                                    sortArray.push($(this).val());
                                }
                            }
                        });
                    } else if (s.filterSortHandler == 'select') {
                        s.filterSortWrapper.find('select').each(function(){
                            if ( $(this).find('option:selected').val() != 0 ) {
                                sortArray.push($(this).val());
                            }
                        });
                    }

                    localStorage.removeItem('sort');
                    if ( sortArray.length !== 0 ) {
                        localStorage.setItem('sort', sortArray);
                    }
                    console.log(sortArray);
                    return sortArray;
                },

                filterResultsPrice: function() {
                    var priceUrl = '',
                        priceFrom = '',
                        priceTo ='';

                    if (s.filterPriceHandler == 'checkbox') {
                        s.filterPriceWrapper.find('input[type="checkbox"]').each(function(){
                            if ( $(this).is(':checked') ) {
                                priceFrom = $(this).data('min');
                                priceTo = $(this).data('max');
                            }
                        });
                    } else if (s.filterPriceHandler == 'select') {
                        s.filterPriceWrapper.find('select').each(function(){
                            if ( $(this).find('option:selected').val() != 0 ) {
                                priceFrom = $(this).find('option:selected').attr('data-min');
                                priceTo = $(this).find('option:selected').attr('data-max');
                            }
                        });
                    } else if (s.filterPriceHandler == 'slider-range') {
                        priceFrom = s.sliderRangeAmountMinHandler.data('min');
                        priceTo = s.sliderRangeAmountMaxHandler.data('max');
                    }

                    localStorage.removeItem('price_from');
                    localStorage.removeItem('price_to');
                    if ( priceFrom != '' && priceTo != '' ) {
                        localStorage.setItem('price_from', priceFrom);
                        localStorage.setItem('price_to', priceTo);
                    }

                    priceUrl = 'price_from=' + priceFrom + '&price_to=' + priceTo;
                    console.log(priceUrl);
                    return priceUrl;
                },

                filterResults: function() {
                    var url = window.location.origin + window.location.pathname,
                        propertiesAll = [];

                    if ( s.filterProperties === true && ProductFilters.filterResultsProperties().length !== 0) {
                        propertiesAll.push(ProductFilters.filterResultsProperties());
                    }

                    if ( s.filterVendor === true && ProductFilters.filterResultsVendors().length !== 0) {
                        propertiesAll.push('vendor='+ ProductFilters.filterResultsVendors());
                    }

                    if ( s.filterPrice === true && ProductFilters.filterResultsPrice().length !== 0) {
                        propertiesAll.push(ProductFilters.filterResultsPrice());
                    }

                    if ( s.filterTags === true && ProductFilters.filterResultsTags().length !== 0) {
                        propertiesAll.push('tags='+ ProductFilters.filterResultsTags());
                    }

                    if ( s.filterSort === true && ProductFilters.filterResultsSort().length !== 0) {
                        propertiesAll.push(ProductFilters.filterResultsSort());
                    }

                    propertiesAll = propertiesAll.join('&');
                    console.log('link'+propertiesAll);
                    window.location.href = url+"?"+propertiesAll;
                },

                selectGoToUrl: function($this){
                    window.location.replace($this.val());
                },

                initFilters: function () {
                    console.log('ProductFilters init');
                    if (s.filterProperties == true) {
                        ProductFilters.findActiveFilterProperties(s.filterActiveProperty);
                    }
                    if (s.filterVendor == true) {
                        ProductFilters.findActiveFilterVendors(s.filterActiveProperty);
                    }
                    if (s.filterTags == true) {
                        ProductFilters.findActiveFilterTags(s.filterActiveProperty);
                    }
                    if (s.filterSort == true) {
                        ProductFilters.findActiveFilterSort(s.filterActiveProperty);
                    }
                    if (s.filterPrice == true) {
                        ProductFilters.findActiveFilterPrice(s.filterActiveProperty);
                    }
                }
            };

        return ProductFilters.init();

    };

    $.fn.productFilters.defaults = {
        filterSectionHandler: '.filter-section',

        filterProperties: true,
        filterPropertiesHandler: 'checkbox', // can be 'select', 'checkbox'
        filterPropertiesWrapper: '.filter-property',
        filterPropertiesMultiple: false, // not work with select

        filterVendor: true,
        filterVendorHandler: 'checkbox', // can be 'select', 'checkbox'
        filterVendorWrapper: '.filter-vendor',
        filterVendorMultiple: true, // not work with select

        filterPrice: true,
        filterPriceHandler: 'slider-range', // can be 'select', 'checkbox' or 'slider-range'
        filterPriceWrapper: '.filter-price',
        // slider-range settings
        sliderRangeHandler: '.slider-range',
        sliderRangeAmountMinHandler: '.amount-min',
        sliderRangeAmountMaxHandler: '.amount-max',
        sliderRangeConfirmHandler: '.subFilter',
        sliderRangeMinValueDefault: Math.floor(parseFloat($('.amount-min').data('min'))),
        sliderRangeMaxValueDefault: Math.ceil(parseFloat($('.amount-max').data('max'))),

        filterSort: true,
        filterSortHandler: 'select', // can be 'select', 'checkbox'
        filterSortWrapper: '.filter-sort',

        filterTags: true,
        filterTagsHandler: 'checkbox', // can be 'select', 'checkbox'
        filterTagsWrapper: '.filter-tags',
        filterTagsMultiple: true,

        filterUseSelectric: true,

        selectUrl: '.select-url'
    };
}(jQuery));