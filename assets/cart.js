/*jslint browser: true*/
/*global $, jQuery, alert, //console,*/

;(function ($) {
    'use strict'

    $.fn.cartOptions = function (options) {
        var s,
            gs = $.extend({}, $.fn.cartOptions.defaults, options),
            cartOptions = {
                settings: {
                    cart: $(gs.cartSummary),
                    products: $(gs.cartSummary).find(gs.products),
                    quantityInput: $(gs.products).find(gs.quantityInput),
                    deleteItem: $(gs.products).find(gs.deleteItem),
                    cartPrice: $(gs.cartPrice),
                    cartWidgetPrice: $(gs.cartWidgetPrice),
                    cartItemCount: $(gs.cartItemCount),
                    decreaseButton: $(gs.decreaseButton),
                    increaseButton: $(gs.increaseButton),
                    removeAllButton: $(gs.removeAllButton),
                    cartList: $(gs.cartList),
                    sideMenu: $(gs.sideMenu),
                    productAddToCartButton: $('.add-to-cart, .product-list figure figcaption form button[type="submit"]'),
                    slidingCartWidgetTrigger: $('.cart-widget-trigger'),
                    slidingCartWidgetClose: $('.cart-widget-close'),
                    productAddDone: gs.productAddDone
                },

                init: function () {
                    s = this.settings

                    console.log('init')
                    this.bindUIActions()
                    if (gs.showFreeShippingInfo == true) {
                        this.updateFreeShippingInfo($(gs.cartSumPrice).data('sum'))
                    }
                    if (gs.showDefaultDeliveryCost == true) {
                        cartOptions.sumAllProducts()
                    }
                    return cartOptions
                },
                productCartEvents: function () {
                    $(gs.increaseButton).on('click', function () {
                        var input = $(this).siblings(gs.quantityInput)
                        if (!input.prop('disabled')) {
                            var val = parseInt(input.val())
                            input.val(val + 1)
                            input.change()
                        }
                    })
                    $(gs.decreaseButton).on('click', function () {
                        var input = $(this).siblings(gs.quantityInput)
                        if (!input.prop('disabled')) {
                            var val = parseInt(input.val())
                            input.val(val - 1)
                            input.change()
                        }
                    })
                    $(gs.quantityInput).keypress(function (event) {
                        if (event.which != 8 && isNaN(String.fromCharCode(event.which))) {
                            event.preventDefault()
                        }
                    })
                    $(gs.quantityInput).keyup(function (event) {
                        var keyCode = event.which
                        if (keyCode > 57) {
                            keyCode -= 48
                        }
                        if (event.which != 8 && isNaN(String.fromCharCode(keyCode))) {
                            event.preventDefault()
                        } else {
                            cartOptions.onInputChange($(this), false)
                        }
                    })
                    $(gs.quantityInput).on('change', function () {
                        if (!$.isNumeric($(this).val()) || $(this).val() <= 0) {
                            $(this).val(1)
                        }
                        cartOptions.onInputChange($(this), true)
                    })
                    $(gs.deleteItem).on('click', function (e) {
                        e.preventDefault()
                        var product = $(this).parents(gs.products),
                            line = product.index('.cart-product:not(.item-template)')+1;

                        cartOptions.ajaxUpdateCart(line, 0, product)
                    })
                },
                bindUIActions: function () {
                    cartOptions.productCartEvents()
                    $(gs.removeAllButton).on('click', function (e) {
                        e.preventDefault()
                        cartOptions.ajaxClearCart()
                    })
                    // dynamic things
                    if (gs.isDynamic) {
                        s.slidingCartWidgetTrigger.on('click', function (e) {
                            e.preventDefault()
                            ////console.log('triggered')
                            cartOptions.toggleSlidingCartWidget('toggle')
                        })
                        s.slidingCartWidgetClose.on('click', function () {
                            cartOptions.toggleSlidingCartWidget('toggle')
                        })
                        $(document).keyup(function (e) {
                            if (e.keyCode == 27) { // escape key maps to keycode `27`
                                cartOptions.toggleSlidingCartWidget('close')
                            }
                        })
                        $(document).mouseup(function (e) {
                            var container = $('.sliding-cart-widget')

                            if (!container.is(e.target) // if the target of the click isn't the container...
                                && container.has(e.target).length === 0) // ... nor a descendant of the container
                            {
                                cartOptions.toggleSlidingCartWidget('close')
                            }
                        })

                        s.productAddToCartButton.on('click', function (e) {
                            $(this).attr('disabled','true');
                            e.preventDefault()
                            var thisElement = $(this)
                            cartOptions.productAddToCart(thisElement)

                            if(thisElement.parents().find('.product-list').length){
                                cartOptions.productListGetProgressivPrice(thisElement)
                            }
                        })
                    }
                },
                productAddToCart: function ($this) {
                    var thisForm = $this.parents('form'),
                        productId = thisForm.find('input[name="id"]').val(),
                        id = thisForm.find('input[name="id"]').attr('data-product-id'),
                        productQty = thisForm.find('input[name="quantity"]').val()
                    if (productQty == undefined) {
                        productQty = 1
                    }

                    SHOPLOAJAX.addProductToCart(productId, productQty).done(function (data) {
                        $this.removeAttr('disabled');
                        if (data.result === true) {
                            if (gs.isDynamic) {
                                cartOptions.showShopMessage($(gs.cartWidgetSummary), data.message, 'success')
                                cartOptions.productGetProgressivPrice(id, productId);
                            } else {
                                MAIN.showShopMessage(data.message, 'success')
                            }

                            cartOptions.updateCart()
                            $('body').toggleClass('show-cart-widget')
                            if (s.productAddDone !== null) {
                                s.productAddDone.call(this)
                            }
                        } else {
                            MAIN.showShopMessage(data.message, 'error')
                        }

                    })
                },

                productGetProgressivPrice: function(id, variantId){


                    if (typeof isProgressiv !== 'undefined') {

                        $.ajax({
                            type: 'GET',
                            url: '/ajax/?method=shop.products.info',
                            data: {
                                id: id
                            },
                            dataType: 'json'
                        }).done(function(data) {

                            $.each(data.variants, function(k, v) {
                                if (variants[k]) {
                                    variants[k].price = parseFloat(v.price/100, 10).toFixed(2);
                                }

                                if(v.id == variantId){
                                    var price = parseFloat(v.price/100, 10),
                                        priceRegular = parseFloat(v.price_regular/100, 10);


                                    //console.log('progresive promot v.id == variantId', v.id, variantId, price, priceRegular);

                                    if(price != priceRegular){
                                        $('body').find('.price .new-price').addClass('red').find('span').text(price.toFixed(2));

                                        if($('body').find('.price .old-price').length == 0){
                                            $('body').find('.price ').append('<span class="old-price">' + Shop.money_format.replace('{{amount}}', priceRegular.toFixed(2)) + '</span>');
                                        }


                                    }else{
                                        $('body').find('.price .new-price').removeClass('red').find('span').text(price.toFixed(2));

                                        if($('body').find('.price .old-price').length != 0){
                                            $('body').find('.price .old-price').remove();
                                        }
                                    }

                                    if($('body').find('.properties').length){
                                        $('body').find('.properties').blur();
                                    }
                                }
                            });
                        });
                    }
                },

                productListGetProgressivPrice: function($this){

                    var $product = $this.parents('figcaption'),
                        variantId = $product.find('input[name="id"]').val(),
                        id = $product.find('input[name="id"]').attr('data-product-id');


                    $.ajax({
                        type: 'GET',
                        url: '/ajax/?method=shop.products.info',
                        data: {
                            id: id
                        },
                        dataType: 'json'
                    }).done(function(data) {

                        $.each(data.variants, function(k, v) {

                            if(v.id == variantId){

                                var price = parseFloat(v.price/100, 10),
                                    priceRegular = parseFloat(v.price_regular/100, 10);

                                //console.log('price', price, 'priceRegular', priceRegular)


                                if(price != priceRegular){
                                    if($product.find('.product-price .old-price').length == 0){
                                        $product.find('.product-price p').text('');
                                        $product.find('.product-price p').append('<span class="new-price">' + Shop.money_format.replace('{{amount}}', price.toFixed(2)) + '</span>');
                                        $product.find('.product-price p').append('<span class="old-price">' + Shop.money_format.replace('{{amount}}', priceRegular.toFixed(2)) + '</span>');
                                    }else{
                                        $product.find('.product-price .new-price').text(price.toFixed(2));
                                    }


                                }else{
                                    $product.find('.product-price .new-price').text(price.toFixed(2));

                                    if($product.find('.product-price .old-price').length != 0){
                                        $product.find('.product-price .old-price').remove();
                                    }
                                }
                            }
                        });
                    });
                },

                cartGetProgressivPrice: function(id, variantId){

                    $.ajax({
                        type: 'GET',
                        url: '/ajax/?method=shop.products.info',
                        data: {
                            id: id
                        },
                        dataType: 'json'
                    }).done(function(data) {

                        $.each(data.variants, function(k, v) {

                            if(v.id == variantId){
                                var price = parseFloat(v.price/100, 10);

                                $('body').find(`.cart-product[data-variant-id='${variantId}']`).find('.product-qty input.qty').attr('data-price', price.toFixed(2));
                                $('body').find(`.cart-product[data-variant-id='${variantId}']`).find('.product-price span').text(price.toFixed(2));

                                cartOptions.sumAllProducts()
                            }
                        });
                    });
                },

                updateCart: function ($this) {
                    //console.log('updateCart')
                    var cartList = $('.mini-products-list'),
                        items = cartList.find('.mini-products-item:not(.item-template)'),
                        itemTemplate = cartList.find('.item-template'),
                        cartListEmpty = $('.mini-products-list-empty'),
                        cartHasVariants = false,
                        totalCountHandler = $('#totalCount'),
                        totalPriceHandler = $('.mini-products-list-total-price .price')

                    SHOPLOAJAX.getCart().done(function (data) {
                        if (data.item_count != 0) {
                            if(!$('body#page-cart').length) {
                                s.cartList.parents('form').removeClass('hidden')
                                cartListEmpty.addClass('hidden')
                                $(gs.products).remove()
                            }

                            $.each(data.items, function (i, val) {

                                var price = parseFloat(val.price / 100).toFixed(2)

                                if(!$('body#page-cart').length){
                                    var newItem = itemTemplate.clone();

                                    newItem.attr('data-variant-id', val.variant_id)
                                    newItem.attr('data-product-id', val.product_id)
                                    newItem.find(gs.priceText).text(Shop.money_format.replace('{{amount}}', price))
                                    newItem.find('.product-image img').attr('src', val.image.replace('th1024', 'th160'))
                                    newItem.find('.product-image a').attr('href', val.url)
                                    newItem.find('.mini-products-item-quantity input').val(val.quantity)
                                    newItem.find('.mini-products-item-quantity input').attr('data-current-id', val.variant_id)
                                    newItem.find('.mini-products-item-quantity input').attr('data-price', price)
                                    $.each(val.variant_properties, function (i, val) {
                                        var variant = '<li>' + val.name + ': ' + val.value + '</li>'
                                        newItem.find('.mini-products-item-properties').append(variant)
                                    })
                                    newItem.find('.mini-product-title').text(val.product_title)
                                    if (val.vendor != '') {
                                        newItem.find('.product-vendor').text(val.vendor)
                                    }
                                    newItem.hide()
                                    newItem.removeClass('item-template').appendTo(cartList).fadeIn()
                                    if (val.variant_properties.length > 0) {
                                        cartHasVariants = true
                                    }

                                    if (gs.isDynamic) {
                                        if ($('body').find(`.product-list input[data-product-id='${val.product_id}']`).length) {
                                            var thisElement = $('body').find(`.product-list input[data-product-id='${val.product_id}']`);
                                            cartOptions.productListGetProgressivPrice(thisElement);

                                        }
                                    }
                                }else{
                                    var cartItem = $('body').find(`.cart-product[data-product-id='${val.product_id}']`) ;

                                    cartItem.find('input.qty').val(val.quantity);
                                    cartItem.find('input.qty').attr('data-price', price);
                                    cartItem.find('.product-price').not('.product-price-sum').find('span').text(Shop.money_format.replace('{{amount}}', price));

                                }

                            })
                            cartOptions.productCartEvents()
                            cartOptions.updateCartProductsVariantsView(cartHasVariants)
                        } else {
                            cartList.parents('form').addClass('hidden')
                            cartListEmpty.removeClass('hidden')
                        }

                        cartOptions.sumAllProducts()
                    })
                },
                toggleSlidingCartWidget: function (action) {
                    if (action == 'toggle') {
                        $('body').toggleClass('show-cart-widget')
                    } else if (action == 'close') {
                        $('body').removeClass('show-cart-widget')
                    }
                    return false
                },

                onInputChange: function (input, change) {
                    if (input.data('last') != input.val()) {
                        var product = input.parents(gs.products),
                            variantID = product.attr('data-variant-id'),
                            id = product.attr('data-product-id'),
                            line = product.index('.cart-product:not(.item-template)')+1;



                        input.data('last', input.val())
                        input.data('focus', !change)

                        if (input.val() > 0) {
                            cartOptions.ajaxUpdateCart(line, input.val(), product);
                            if (!gs.isDynamic) {
                                cartOptions.cartGetProgressivPrice(id, variantID);
                            }else{
                                cartOptions.sumAllProducts()
                            }
                        }
                    }
                },
                sumAllProducts: function () {
                    var overall = 0
                    var count = 0
                    $.each($(gs.products), function () {
                        var amount = parseFloat($.trim($(this).find(gs.quantityInput).val() | 0), 10)
                        var price = parseFloat($.trim($(this).find(gs.quantityInput).attr('data-price')), 10)
                        var productOverall = amount * price
                        overall += amount * price
                        count += amount

                        if ($(this).find(gs.productPriceSumWrapper).length) {
                            $(this).find(gs.productPriceSumWrapper).text(Shop.money_format.replace('{{amount}}', productOverall.toFixed(2)))
                        }
                    })
                    var priceWithoutDelivery = parseFloat(overall).toFixed(2)
                    if ($('#sumPriceWithoutShipping').length) {
                        $('#sumPriceWithoutShipping').find('b').text(Shop.money_format.replace('{{amount}}', priceWithoutDelivery))
                    }
                    if (gs.showDefaultDeliveryCost == true) {
                        var newPrice = parseFloat(overall) + parseFloat(gs.cartDefaultDeliveryCost)
                        newPrice = newPrice.toFixed(2)
                    } else {
                        var newPrice = parseFloat(overall).toFixed(2)
                    }


                    if (parseFloat(s.cartPrice.text()) != newPrice) {
                        $(gs.cartPrice).text(Shop.money_format.replace('{{amount}}', newPrice))
                        $(gs.cartWidgetPrice).text(Shop.money_format.replace('{{amount}}', newPrice))
                        $(gs.cartSumPrice).data(newPrice)
                        $(gs.cartItemCount).text(count)
                    }
                    if (gs.showFreeShippingInfo == true && $(gs.products).length != 0) {
                        cartOptions.updateFreeShippingInfo(newPrice)
                    }

                    if (gs.isDynamic) {
                        if ($(gs.cartWidgetSummary).find(gs.products).length == 0) {
                            $('#minicartSummary').addClass('hidden')
                            $('.mini-products-list-empty').removeClass('hidden')
                            $('.cart-free-shipping-info').remove()
                        }
                    } else {
                        if ($(gs.cartSummary).find(gs.products).length == 0) {
                            $('#cartSummary').addClass('hidden')
                            $('.empty-cart').removeClass('hidden')
                            $('.cart-free-shipping-info').remove()
                        }
                    }
                },
                onRemoveProduct: function (product) {
                    product.fadeOut(500, function () {
                        product.remove()
                        if (gs.isDynamic) {
                            var productList = $(gs.cartWidgetSummary).find(gs.products)
                        } else {
                            var productList = $(gs.cartSummary).find(gs.products)
                        }
                        s.products = $(gs.cartSummary).find(gs.products)
                        var cartHasVariants = false

                        $.each(productList, function () {
                            var productHasVariants = $(this).find('.product-variants li').length
                            if (productHasVariants) {
                                cartHasVariants = true
                                return false
                            }
                        })

                        cartOptions.updateCartProductsVariantsView(cartHasVariants)
                        cartOptions.sumAllProducts()
                    })
                },

                ajaxUpdateCart: function (itemLine, qty, product) {
                    var input = product.find(gs.quantityInput),
                        variantId = product.attr('data-variant-id'),
                        id = product.attr('data-product-id');

                    input.prop('disabled', true)
                    SHOPLOAJAX.changeCart(itemLine, qty)
                        .done(function (data) {
                            if (data.status === 'ok') {
                                if (qty == 0) {
                                    if (gs.isDynamic) {
                                        cartOptions.showShopMessage($(gs.cartWidgetSummary), data.message, 'success');
                                    } else {
                                        MAIN.showShopMessage(data.message, 'success')
                                    }
                                    cartOptions.onRemoveProduct(product)
                                }

                                if (gs.isDynamic) {
                                    if($('body').find(`.product-list input[data-product-id='${id}']`).length){
                                        var thisElement = $('body').find(`.product-list input[data-product-id='${id}']`);
                                        cartOptions.productListGetProgressivPrice(thisElement);

                                    }else if($('body#page-product').find('form input[data-product-id]').length){

                                        var thisId = $('body#page-product').find('form input[data-product-id]').attr('data-product-id'),
                                            thisVariantId = $('body#page-product').find('form input[data-product-id]').val();

                                        cartOptions.productGetProgressivPrice(thisId, thisVariantId);
                                    }

                                }

                                cartOptions.updateCart();
                            } else {
                                if (gs.isDynamic) {
                                    cartOptions.showShopMessage($(gs.cartWidgetSummary), data.message, 'error')
                                } else {
                                    MAIN.showShopMessage(data.message, 'error')
                                }

                                if (input.val() > data.max_quantity) {
                                    input.val(data.max_quantity)
                                    input.data('last', data.max_quantity)
                                    cartOptions.sumAllProducts()
                                }
                            }
                            input.prop('disabled', false)
                            if (input.data('focus')) {
                                input.focus()
                            }
                        })
                },
                ajaxClearCart: function () {
                    SHOPLOAJAX.clearCart()
                        .done(function (data) {
                            s.products.each(function () {
                                cartOptions.onRemoveProduct($(this))
                            })

                            if (gs.isDynamic) {
                                $('#minicartSummary').addClass('hidden')
                                $('.mini-products-list-empty').removeClass('hidden')
                            } else {
                                $('#cartSummary').addClass('hidden')
                                $('.empty-cart').removeClass('hidden')
                            }
                            // todo backend zwracać wiadomość i status
                            /*if(data.result === true) {
                             MAIN.showShopMessage(data.message, 'success')
                             s.products.each(function() {
                             cartOptions.onRemoveProduct($(this))
                             })
                             } else {
                             MAIN.showShopMessage(data.message, 'error')
                             }*/
                        })
                },
                updateFreeShippingInfo: function (total_price) {
                    var infoBlock = $('<p />', {'class': gs.freeShippingInfoClass}),
                        priceFreeShippingLabel = cart_free_delivery_info,
                        priceToFreeShipping = parseFloat(cart_free_delivery_price),
                        cartTotalPrice = parseFloat(total_price),
                        freeShippingMessage = $('.cart-free-shipping-info')

                    if (cartTotalPrice < priceToFreeShipping) {
                        var priceToGetFree = priceToFreeShipping - cartTotalPrice,
                            message = cart_free_delivery_info.replace('{price}', '<b>' + Shop.money_format.replace('{{amount}}', priceToGetFree.toFixed(2)) + '</b>')
                        infoBlock.append(message)
                        if (freeShippingMessage.length) {
                            freeShippingMessage.replaceWith(infoBlock)
                        } else {
                            infoBlock.hide()
                            if ($('body').attr('id') == 'page-cart') {
                                $('#page-cart header.cart-title .row').append(infoBlock.fadeIn())
                            } else {
                                $(gs.cartWidgetSummary).before(infoBlock.fadeIn())
                            }
                        }
                    } else {
                        if (freeShippingMessage.length) {
                            freeShippingMessage.fadeOut(function () {
                                freeShippingMessage.remove()
                            })
                        }
                    }
                },

                showShopMessage: function (parent, text, type) {
                    if ($.trim(parent.find('.cart-msg').text()) == '' && text && type) {
                        parent.prepend('<p class="cart-msg ' + type + '">' + text + '</p>')
                    }
                    setTimeout(function () {
                        parent.find('.cart-msg').fadeOut(function () {
                            $(this).remove()
                        })
                    }, 3500)
                },

                updateCartProductsVariantsView: function (hasVariants) {
                    var cartHeadVariants = $('.cart-head-variants'),
                        cartHeadProduct = $('.cart-head-product, .product-data'),
                        cartProductVariants = $('.product-variants')

                    if (hasVariants == true) {
                        cartHeadVariants.show()
                        cartHeadProduct.removeClass('col-md-7').addClass('col-md-5')
                        cartProductVariants.show()
                    } else {
                        cartHeadVariants.hide()
                        cartHeadProduct.removeClass('col-md-5').addClass('col-md-7')
                        cartProductVariants.hide()
                    }
                }
            }
        cartOptions.updateCartOutside = function () {
            cartOptions.updateCart()
            $('body').toggleClass('show-cart-widget')
        }

        return cartOptions.init()
    }
    $.fn.cartOptions.defaults = {
        removeAllButton: '#removeAllProduct',
        products: '.cart-product',
        cartSummary: 'form#cartSummary',
        cartWidgetSummary: '#minicartSummary',
        deleteItem: '.delete-item-button',
        quantityInput: '.product-qty:visible input.qty',
        productPriceSumWrapper: '.product-price-sum span',
        priceText: '.product-price span',
        increaseButton: '.increase-button',
        decreaseButton: '.decrease-button',
        cartSumPrice: '#sumPrice',
        cartPrice: '#sumPrice span',
        cartWidgetPrice: '.mini-products-list-total-price',
        cartItemCount: '.cart-widget-total-count',
        cartList: '.mini-products-list',
        slidingCartWidget: '.sliding-cart-widget',
        showFreeShippingInfo: true,
        freeShippingContainer: '.cart-free-shipping-info',
        freeShippingInfoClass: 'cart-free-shipping-info col-xs-12',
        showDefaultDeliveryCost: true,
        cartDefaultDeliveryCost: cart_delivery_cost,
        isDynamic: false,
        dynamicCartType: 'right',
        productAddDone: null
    }
}(jQuery))
