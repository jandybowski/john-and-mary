jQuery( document ).ready(function( $ ) {
    'use strict';
    var p,
    productContainer = $('.product-2'),
    PRODUCT_2 = {
        settings:{
            productContainer: productContainer,
            mainGallery: productContainer.find('.main-gallery'),
            thumbsGallery: productContainer.find('.thumbs-gallery'),
            isMobile: 0,
            windowWidth: $(window).width(),
            variantsHandler: productContainer.find('.variants')

        },

        init: function(){
            console.log('PRODUCT_2 INIT');
            p = this.settings;
            this.windowLoadHandler();
            this.bindUIActions();
        },

        windowLoadHandler: function() {
            if ( p.windowWidth < '990' )
            {
                p.isMobile = 1;
            }

            if ( p.isMobile === 1 ) {
                PRODUCT_2.mobileGallery();
            } else {
                PRODUCT_2.desktopGallery();
            }

            if ( p.variantsHandler.length ) {
                Shop.productHandler = p.productContainer.productVariants({
                    productSectionContainer: '.product-2',
                    selectricSelect:true
                });
            }
            return false;
        },

        bindUIActions: function(){
            p.thumbsGallery.on('click', '.thumb-item a', function(e){
                e.preventDefault();
                var itemIndex = $(this).attr('href');
                p.mainGallery.slick('slickGoTo',itemIndex);
            });

            $('.slick-slider').on('beforeChange', function(){
               $('.slick-track').attr('inChange', '1')
            });  

            $('.slick-slider').on('afterChange', function(){  
                $('.slick-track').attr('inChange', '0')    
            }); 
        },

        mobileGallery: function() {
            p.mainGallery.on('init', function(){ 
                p.mainGallery.fadeTo("slow", 1);
                p.mainGallery.find('.gallery-item').css("position", "relative");
                p.mainGallery.find('a').on('click', function(e) {e.preventDefault();})
            });
            p.mainGallery.slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                arrows: true,
                adaptiveHeight: true,
                dots: false,
                fade: p.mainGallery.data('fade')
            });
            initPhotoSwipeFromDOM('.main-gallery a', p.mainGallery.data('zoom-ratio'));
            p.thumbsGallery.on('init', function(){ 
                p.thumbsGallery.fadeTo("slow", 1);
                p.thumbsGallery.find('.thumb-item').css("position", "relative");
            });
            p.thumbsGallery.slick({
                slidesToShow: 4,
                slidesToScroll: 1,
                arrows: false,
                dots: false
            });
        },

        desktopGallery: function() {
            p.mainGallery.on('init', function(){ 
                p.mainGallery.fadeTo("slow", 1);
                p.mainGallery.find('.gallery-item').css("position", "relative");
            });
            p.mainGallery.slick({
                slidesToShow: 1,
                slidesToScroll: 1,
                arrows: false,
                adaptiveHeight: true,
                infinite: false,
                dots: false,
                fade: p.mainGallery.data('fade')
            });

            initPhotoSwipeFromDOM('.main-gallery a', p.mainGallery.data('zoom-ratio'));
            p.mainGallery.imagesLoaded(function(){
                p.thumbsGallery.slick({
                    slidesToShow: 5,
                    slidesToScroll: 1,
                    infinite: false
                });
            });
            p.thumbsGallery.on('init', function(){ 
                p.thumbsGallery.fadeTo("slow", 1);
                p.thumbsGallery.find('.thumb-item').css("position", "relative");
            });
           
        },

    };


    PRODUCT_2.init();
});