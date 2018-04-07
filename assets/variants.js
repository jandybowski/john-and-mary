
/*jslint browser: true*/
/*global $, jQuery, alert, console, dict, prices, pricesRegular, images, shipping*/

(function ($) {
    'use strict';

    $.fn.productVariants = function (options) {
        var s,

            gs = $.extend({}, $.fn.productVariants.defaults, options),
            ProductVariants = {
                settings: {
                    inputVariantId: $(gs.inputVariantId),
                    newPriceWrapper: $(gs.newPriceWrapper),
                    oldPriceWrapper: $(gs.oldPriceWrapper),
                    thumbsWrapper: $(gs.thumbsWrapper),
                    shippingInfoWrapper: $(gs.shippingInfoWrapper),
                    shippingInfo: gs.shippingInfo,
                    propertyHandler: $(gs.propertyHandler),
                    propertiesHandler: $(gs.propertiesHandler),
                    propertyContainer: $(gs.propertyContainer),
                    options: $(gs.variantsContainer).find(gs.propertyContainer),
                    addToCartButton: $(gs.addToCartButton),
                    changeAddToCartButtonState: gs.changeAddToCartButtonState,
                    selectricSelect: gs.selectricSelect,
					currentVariant: null
                },

                init: function () {
                    s = this.settings;

                    this.bindUIActions();
                    this.initForm();
                    return ProductVariants;
                },

                bindUIActions: function () {
                    s.propertyHandler.on('click', function () {
                        var $this = $(this);
                        /** if property is disabled do nothing */
                        if ($this.hasClass('unavailable')) {
                            return false;
                        } else {
							$this.parent().children().removeClass('active');
							$this.addClass('active');
                            ProductVariants.getVariant();
							ProductVariants.setVariant();
							ProductVariants.deactivateUnavailableProperties();
							
                        }
                    });

                    s.propertiesHandler.on('change', function () {
                        var $this = $(this);

						if (s.selectricSelect === true) {
							s.options.find('select').selectric('refresh');
						}
						$this.find('option').each(function() {
							if(this.selected) {
								$(this).addClass('active');
							} else {
								$(this).removeClass('active');
							}
						});
                        ProductVariants.getVariant();
                        ProductVariants.setVariant();
                        ProductVariants.deactivateUnavailableProperties();

                    });
                },
                checkProperties: function() {

                },
                

                setVariant: function() {
                    var selectProps = s.options.find('.properties');

                    $.each(selectProps, function () {
                        var currentProperty = $(this);
                        $.each(currentProperty.find('.property'), function () {
                            var propName = currentProperty.data('property-name');
                            var propValue = $(this).data('property-value');
                            if (s.currentVariant.hasProperty({name: propName, value: propValue})) {
                                $(this).addClass("active");
                                $(this).prop("selected", "selected");
                            } else {
                                $(this).removeClass('active');
                                $(this).removeProp("selected");
                            }
                        });
                    });

                    ProductVariants.deactivateUnavailableProperties();
                    ProductVariants.setNewImage();
                    ProductVariants.setNewPrice();
                    ProductVariants.setNewShippingInfo();
                    s.inputVariantId.val(s.currentVariant.id);

                    // ProductOptions app additional function
                    var productsOptionsWrapper = $('body').find('#variantsPO'),
                        additionalProperties = productsOptionsWrapper.find('[name^="properties["]');
                    if (productsOptionsWrapper.length && additionalProperties.length) {

                        additionalProperties.each(function () {
                            var newName = $(this).attr('name').replace(/properties\[.*?\]/, 'properties[' + s.currentVariant.id + ']');
                            console.log(newName)
                            $(this).attr('name', newName);
                        });
                    }

                    //additional
                    $('#quantityInfo span').text(s.currentVariant.quantity);
                    $('#refNumber span').text(s.currentVariant.sku);
                    if (s.selectricSelect === true) {
                        s.options.find('select').selectric('refresh');
                    }
                },
                getVariant: function() {
                    var selectsProps = s.options.find('.properties');
                    var options = [];
                    selectsProps.each(function() {
                        var prop = $(this).find('.active').first();
                        var propName = $(this).data('property-name');
                        var propValue = prop.data('property-value');

                        options.push({name: propName, value: propValue});
                    });

                    var variant = getVariant(options);
                    if(variant == null) {
                        for(var c=options.length;c > 0; c=c-1) {
                            var opt = [];
                            for(var d=0;d < c;d++) {
                                opt.push(options[d]);
                            }
                            var newVariant = getVariants(opt);
                            if(newVariant != null) {
                                return s.currentVariant = newVariant[0];
                            }
                        }
                        s.currentVariant =  variants[0];
                    } else s.currentVariant =  variant;

                },
				deactivateProperty: function(property) {
					if(property.parent().is("select")) {
						property.removeAttr('selected');
						property.prop('disabled', true);
						
					} else {
						property.addClass('unavailable');
					}
					
				}, 
				activateProperty: function(property) {
					if(property.parent().is("select")) {
						property.prop('disabled', false);
						
					} else {
						property.removeClass('unavailable');
					}
					

				},
				deactivateAllProperties: function() {
					
					var propsSelects = s.options.find('.properties');
                        propsSelects.each(function(index) {
                           // propsSelects.prop('disabled', true);
                            var propName = $(this).data('property-name');
                            var opt = $(this).find('.property');
                            
                            opt.each(function() {
								ProductVariants.deactivateProperty($(this));
							});
						});
					if (s.selectricSelect === true) {
                        s.options.find('select').selectric('refresh');
                    }
					
				},
                deactivateUnavailableProperties: function() {
                        var props = s.currentVariant.properties;
                        var propsSelects = s.options.find('.properties');
                        propsSelects.each(function(index) {
                            
                            var propName = $(this).data('property-name');
                            var opt = $(this).find('.property');
                            
                            opt.each(function() {
                                var count = 0;
                                var propValue = $(this).data('property-value');
                                var options = [];
                                for(var j=0; j < index;j++) { 
                                    options.push({name: props[j].name,value: props[j].value})
                                }
                                options.push({name: propName, value: propValue});
                                var variants = getVariants(options);
                                if(variants != undefined) {
                                for(j=0; j < variants.length;j++) { 
                                    if(variants[j].hasProperty({name: propName, value: propValue})) {
                                        count+=1;
                                    }   
                                }}
                                if(count==0) {
									ProductVariants.deactivateProperty($(this));
								}
                                else {
									ProductVariants.activateProperty($(this));
								}
                            });

                        });
                        if (s.selectricSelect === true) {
                        s.options.find('select').selectric('refresh');
                    }
                },
                setAddToCartButton: function (condition) {
                    s.addToCartButton.prop('disabled', condition);
                },

                setNewPrice: function () {
                    s.newPriceWrapper.text(s.currentVariant.price);
                    if (s.oldPriceWrapper) {
                        s.oldPriceWrapper.text(s.currentVariant.priceRegular);
                    }
                    var productIdPo = $('body').find('#productIdPo');
                    if (productIdPo.length) {
                        productIdPo.attr('data-price', s.currentVariant.price).attr('data-regular-price', s.currentVariant.priceRegular);
                        Shop.productOptions.setNewPrice()
                    }
                },


                setNewImage: function () {
					s.thumbsWrapper.imagesLoaded(function() {
							var thumb = s.thumbsWrapper.find('.thumb-item') || s.galleryWrapper.find('.gallery-item'),
							i;

							for (i = 0; i < thumb.length; i += 1) {
								if (s.thumbsWrapper.length) {
									if ($(thumb[i]).find('img').attr('src') === s.currentVariant.image) {
										$(thumb[i]).find('a').trigger('click');
									}
								} else {
									if ($(thumb[i]).data('thumb') === s.currentVariant.image) {
										var index = $(thumb[i]).data('hash');
										s.galleryWrapper.find('.slick-dots li:eq('+ index +') button').trigger('click');

									}
								}
								
							}

					})
                    
                },

                setNewShippingInfo: function (variant) {
                    var shippingDefault = s.shippingInfoWrapper.data('shipping-default');
                    if (s.shippingInfoWrapper.length) {
                        if (s.currentVariant.shipping.length) {
                            s.shippingInfoWrapper.find(s.shippingInfo).html(s.currentVariant.shipping);
                        } else {
                            s.shippingInfoWrapper.find(s.shippingInfo).html(shippingDefault);
                        }
                    }
                },

                initHelper: function (property, type, single) {

                },


                initForm: function () {
                    var selectProperties = s.options.first().find('.properties'),
                        properties,
                        variants,
                        currentProperty;
                    properties = selectProperties.find('.property');
                    $.each(properties, function(){
                        currentProperty = $(this);
                        var propName = selectProperties.data('property-name');
                        var propValue = currentProperty.data('property-value');
                        variants = getVariants([{name: propName, value: propValue}]);
                        if(variants != null) {
							s.currentVariant = variants[0];
                            ProductVariants.setVariant();
                            
                            return false;
                        }
                    });
					if(s.currentVariant == null) 
						ProductVariants.deactivateAllProperties();
                }
            };

        return ProductVariants.init();

    };

    $.fn.productVariants.defaults = {
        variantsContainer: '.variants',
        propertyContainer: '.option',
        propertyHandler: '.property',   // for box properties
        propertiesHandler: '.properties', //for properties in select input
        addToCartButton: '.add-to-cart',
        changeAddToCartButtonState: true, //if active, we change add to cart button to disable when current variant i disabled
        inputVariantId: 'input[name=id]',
        newPriceWrapper: '.new-price span',
        oldPriceWrapper: '.old-price span',
        galleryWrapper: '.main-gallery',
        thumbsWrapper: '.thumbs-gallery',
        shippingInfoWrapper: '.shipping-info',
        shippingInfo: 'span',
        selectricSelect: true
    };

}(jQuery));
