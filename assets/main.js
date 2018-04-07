var m,
MAIN = {
    settings: {
        windowHandler: $(window),
        select: $('.select'),
        shopMessageWrapper: $('#shopNotyfication'),
        shopMessage: $('#shopMessage'),
        navToggle: $('#navToggle'),
        stickyBar: $('.sticky-bar'),
        filtersContainer: $('.filters'),
        langSwitcher: $('.langWidget select'),
        openSearchButton: $('.openSearch'),
        searchFormWrapper: $('#searchFormWrapper'),
        searchCloseButton: $('#searchClose'),
        mobileNav: $('#mobileMenu'),
        mobileLangSwitcher: $('.mobile-lang-switcher select'),
        body: $('body')
    },

    init: function () {
        m = this.settings;
        this.windowLoadHandler();
        this.bindUIActions();
        console.log('init')
    },

    windowLoadHandler: function () {
        if($('#cartSummary').length) {
          Shop.cartHandler = $('#cartSummary').cartOptions({
                showFreeShippingInfo: cart_free_delivery_show,
                showDefaultDeliveryCost: cart_delivery_cost_show
            });
        } else {
            if ($('#minicartSummary').length) {
            Shop.cartHandler = $('#minicartSummary').cartOptions({
                    isDynamic: useDynamicCart,
                    dynamicCartType: dynamicCartType,
                    showFreeShippingInfo: cart_free_delivery_show,
                    showDefaultDeliveryCost: cart_delivery_cost_show,
                    products: ".mini-products-item:not(.item-template)",
                    quantityInput: ".mini-products-item-quantity:visible input",
                    priceText: ".mini-products-item-price",
                    cartPrice: ".mini-products-list-total-price .price",
                    productAddDone: function() {
						 if (typeof UpSellAppProduct !== "undefined" && typeof upSellData !== "undefined") {
                            if (upSellData.ajaxCart == true) {
                                UpSellAppProduct.checkForCampaign();	 
                            }
                        }
					}
                });
            }
        }

        if (m.mobileNav.length) {
            MAIN.mobileMenuInit();
        }

        if (m.select.length) {
            MAIN.selectricInit(m.select);
        }

        if (m.filtersContainer.length) {
            var filterProperties = false,
                filterVendor = false,
                filterTags = false,
                filterPrice = false,
                filterSort = false;

            if (m.filtersContainer.find('.filter-property').length) {
                filterProperties = true;
            }
            if (m.filtersContainer.find('.filter-vendor').length) {
                filterVendor = true;
            }
            if (m.filtersContainer.find('.filter-tags').length) {
                filterTags = true;
            }
            if (m.filtersContainer.find('.filter-sort').length) {
                filterSort = true;
            }
            if (m.filtersContainer.find('.filter-price').length) {
                filterPrice = true;
            }

            m.filtersContainer.productFilters({
                filterProperties: filterProperties,
                filterVendor: filterVendor,
                filterPrice: filterPrice,
                filterSort: filterSort,
                filterTags: filterTags
            });
        }
        if (m.shopMessage.find('p').length) {
            MAIN.showShopMessage();
        }
        

        return false;
    },

    bindUIActions: function () {
        if (!m.mobileNav.length) {
            MAIN.navToggleInit();
        }
        
        m.shopMessage.bind("DOMNodeInserted", function () {
            MAIN.showShopMessage();
        });

        m.langSwitcher.change(function () {
            MAIN.changeLang(this);
        });

        m.mobileLangSwitcher.on('change', function() {
            window.location = m.body.find('.mobile-lang-switcher select').find('option:selected').val();
        });

        if (m.stickyBar.length) {
            m.windowHandler.scroll(function () {
                MAIN.stickMenu();
            });
        }

        m.openSearchButton.on('click', function(e){
            e.preventDefault();
            m.searchFormWrapper.addClass('show');
            setTimeout(function() {
                m.searchFormWrapper.find('#searchForm input[type="search"]').focus();
            }, 400);
        });

        m.searchCloseButton.on('click',function(e){
            e.preventDefault();
            m.searchFormWrapper.removeClass('show');
        });

        m.searchFormWrapper.on('click', function(){
            $(this).removeClass('show');
        });
        m.searchFormWrapper.find('#searchForm').on('click', function(event){
            event.stopPropagation();
        });
    },

    selectricInit: function (select) {
        select.selectric({
            disableOnMobile: false
        });
    },

    navToggleInit: function () {
        m.navToggle.on('click', function (e) {
            e.preventDefault();
            $('#mainNav').toggle();
        });
    },

    mobileMenuInit: function() {
         var menuTheme,
            navbarsArray = [],
            searchBoxObject = {
                "position": "top",
                "content": [
                    '<div class="mobile-search-box">' +
                    '<form  action="'+ searchActionUrl +'" method="get">' +
                    '<input type="search" placeholder="'+ searchPlaceholder +'" name="q" />' +
                    '<button type="submit"><i class="icon icon-search"></i></button>' +
                    '</form>' +
                    '</div>'
                ]
            },
            langSwitcherObject = {
                "position": "bottom",
                "content": [
                    '<div class="mobile-lang-switcher">' +
                    '<select class="select select-small" name="lang" tabindex="0" placeholder="' + langPlaceholder + '">' +
                        '<option value="0" selected="selected">'+ langPlaceholder +'</option>' +
							'<option value="'+langSwitcherFirstUrl+'">'+langSwitcherFirstTitle+'</option>' +
							'<option value="'+langSwitcherSecondUrl+'">'+langSwitcherSecondTitle+'</option>' +
						'</select>' +
					'</div>' 
                ]
            },
            socialIconObject = {
                "position": "bottom",
                "content": [
                ]
            };
        if (showSearchBox == 1) {
            navbarsArray.push(searchBoxObject);
        }
        
        if (showLangSwitcher == 1) {
            navbarsArray.push(langSwitcherObject);
        }

        if (showSocialIcons == 1) {
            if (socialIconsShowFacebook == 1) {
                socialIconObject.content.push('<a href="'+ socialIconsFacebookUrl +'" target="_blank" class="icon icon-facebook"></a>')
            }
            if (socialIconsShowTwitter == 1) {
                socialIconObject.content.push('<a href="'+ socialIconsTwitterUrl +'" target="_blank" class="icon icon-twitter"></a>')
            }
            if (socialIconsShowPinterest == 1) {
                socialIconObject.content.push('<a href="'+ socialIconsPinterestUrl+'" target="_blank" class="icon icon-pinterest-p"></a>')
            }
            if (socialIconsShowInstagram == 1) {
                socialIconObject.content.push('<a href="'+ socialIconsInstagramUrl +'" target="_blank" class="icon icon-instagram"></a>')
            }
            navbarsArray.push(socialIconObject);
        }

      

        if (mobileMenuTheme == 'dark') {
            menuTheme = 'theme-dark';
        } else if (mobileMenuTheme == 'light') {
            menuTheme = 'theme-white';
        }
  
        m.mobileNav.mmenu({
            "extensions": [
                "pagedim-black",
                menuTheme
            ],
            "navbars": navbarsArray,
            navbar: {
                title: false
            }

        }, {
            // configuration
            offCanvas: {
                pageSelector: "#page"
            }
            
        });
        
    },

    changeLang: function (lang) {
        window.location = lang.value
    },

    showShopMessage: function (text, type) {
        if ($.trim(m.shopMessage.text()) == '' && text && type) {
            m.shopMessage.prepend('<p class="'+type+'">'+text+'</p>');
            m.shopMessageWrapper.addClass(type);
        } 
        setTimeout(function () {
            m.shopMessageWrapper.removeAttr('class');
            m.shopMessage.html('');
        }, 3500);
    },
    
    stickMenu: function () {
        var afterStickHeight = $('.unsticky-after-this').outerHeight(),
            afterContainerHeight = $('.sticky-after-this').outerHeight(),
            fromTop = m.windowHandler.scrollTop();
        if (fromTop >= afterContainerHeight + afterStickHeight) {
            m.stickyBar.addClass('is-sticky');
            $('body').css('padding-top', afterContainerHeight);
        } else if (fromTop <= afterStickHeight) {
            m.stickyBar.removeClass('is-sticky');
            $('body').css('padding-top', 0);
        }
    },
};

$(function(){
     MAIN.init();
});