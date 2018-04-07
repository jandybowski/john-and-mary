jQuery(document).ready(function ($) {
    'use strict';
    var b,
        BANNER_7 = {
            settings: {
                bannerContainer: $('.banner-27'),
                bannerSlider: $('.banner-27').find('.slides'),
                bannerSliderWrapper: $('.banner-27').find('.slider-wrapper'),
                bannerContainerNav: $('.banner-27').find('.prev, .next'),
                bannerLoader: $('.banner-27').find('.slider-loader')
            },

            init: function () {
                b = this.settings;
                this.windowLoadHandler();
                this.bindUIActions();
            },

            windowLoadHandler: function () {
                if (b.bannerSlider.length) {
                    BANNER_7.initSlider();
                }

                return false;
            },

            bindUIActions: function () {
            },

            initSlider: function () {
                b.bannerSliderWrapper.imagesLoaded(function () {
                    b.bannerSlider.on('init', function () {
                        b.bannerLoader.hide();
                        b.bannerSliderWrapper.fadeTo("slow", 1);
                    });
                    b.bannerSlider.slick({
                        slidesToShow: 1,
                        slidesToScroll: 1,
                        arrows: true,
                        adaptiveHeight: false,
                        dots: true,
                        autoplay: b.bannerSlider.data('auto'),
                        autoplaySpeed: b.bannerSlider.find('li').eq(0).data('duration') * 1000,
                        fade: true,
                        cssEase: 'linear'
                    });
                });
            },

        };

    BANNER_7.init();
});
