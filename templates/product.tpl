<!--
    Poniżej znajduje się paleta kolorów do której należy przypisywać kolory wg. schematu:


             'nazwa_koloru_w_panelu'=>'#321312',


    Czyli najpierw wpisujemy nazwę koloru którą wpisaliśmy w wariancie produktu, a następnie przypisujemy do niej kolor HEX. Należy pamiętać, że paleta będzie działać tylko wtedy gdy składnia     będzie poprawna!
    Ostani kolor nie powinien mieć na końcu znaku przecinka.
-->
{$pallete = [
'sand'=> '#ebd4bb',
'black'=> '#414644',
'mint'=> '#c4e6da',
'grey'=> '#a3a3a3',
'light gray'=> '#e8e8e8',
'pink'=> '#dabdcb',
'green'=> '#c2d8b7',
'blue'=> '#e8f8f8'
]}
<div class="container product-2">
    <div class="row">
        <!-- Gallery column -->
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-7">
            {assign var="photos" value=$product->getImages()}
            {if $photos}
            <div class="gallery-wrapper">
                <div class="main-gallery-wrapper">
                    <div class="main-gallery" data-slider-id="1" data-zoom-ratio="{$settings->zoom_ratio}" data-fade="{$settings->gallery_type}">
                        {assign var=i value=0}
                        {foreach from=$photos item="photo" name="list"}
                        <figure class="gallery-item" data-hash="{$i}">
                            <a href="{$photo->url|product_img_url:th2048}" data-large="{$photo->url|product_img_url:th1024}"  >
                                <img src="{$photo->url|product_img_url:th640}" {if $photo->alt}alt="{$photo->alt}"{else}alt="{$product->title}"{/if} />
                            </a>
                        </figure>
                        {assign var=i value=$i+1}
                        {/foreach}
                    </div>
                </div>
                <div class="thumbs-wrapper">
                    <div class="thumbs-gallery">
                        {assign var=i value=0}
                        {foreach from=$photos item="photo" name="list"}
                        <div class="thumb-item" data-image="{$photo->url|product_img_url:th640}">
                            <a href="{$i}"><img data-index="{$i}" src="{$photo->url|product_img_url:th100}" {if $photo->alt}alt="{$photo->alt}"{else}alt="{$product->title}"{/if} /></a>
                        </div>
                        {assign var=i value=$i+1}
                        {/foreach}
                    </div>
                </div>
            </div>
            {/if}
        </div>
        <!-- End Gallery column -->
        <!-- Start Product Info column -->
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-5">
            <div class="product-info">
                {assign var="variants" value=$product->getVariants()}
                {assign var="properties" value=$product->getProperties()}
                <form action="{reverse_url name='shop_cart_add'}" method="post">
                    <input type="hidden" name="id" value="{$variants[0]->id}" data-quantity="{$variant->quantity}" data-property1="{$variants[0]->property1}" data-property2="{$variants[0]->property2}" data-property3="{$variants[0]->property3}" data-product-id="{$product->id}" />
                    <input type="hidden" name="return_to" value="" />

                    <header>
                        <h1>{$product->title}</h1>
                    </header>
                    {if $settings->show_vendor}
                        {if $product->vendor->title}<span class="product-vendor">{trans}store_theme_translations.vendor{/trans} {$product->vendor->title}</span>{/if}
                    {/if}
                    {if $settings->show_shipping_info}
                        <div class="shipping-info" data-shipping-default="{$settings->shipping_info}">
                            {foreach from=$product->variants item="variant"}
                                {if $variant->availability_description != '' && $variant->availability_description != ' '}
                                    {assign shipping $variant->availability_description}
                                {/if}
                            {/foreach}
                            {if $shipping}
                                {trans}store_theme_translations.shipping_info_label{/trans} <span>{$shipping}</span>
                            {else}
                                {trans}store_theme_translations.shipping_info_label{/trans} <span>{$settings->shipping_info}</span>
                            {/if}       
                        </div>
                    {/if}
                    <div class="product-actions" >
                        <div class="price price-changeable">
                            <span class="new-price {if $product->on_sale}red{/if}">
                                <span>{$product->price_min|money_without_currency}</span> {$shop->currency|replace:'PLN':'zł'}
                            </span>
                            {if $product->on_sale}
                            <span class="old-price">
                                <span>{$product->price_regular|money_without_currency}</span> {$shop->currency|replace:'PLN':'zł'}
                            </span>
                            {/if}
                        </div>
                        
                        
                        {if $variants|@count > 1}
                        <div class="variants">
                            {foreach from=$product->getProperties() key="property_name" item="properties" name="loopOuter"}
                                {if $property_name|lower == 'kolor' || $property_name|lower == 'color' || $property_name|lower == 'colour'}
                                    <div class="option option-colour">
                                        <ul data-property-name="{$property_name}" class="properties">
                                            {foreach from=$properties item="value" name="loopInner"}
                                                <li class="param{$property_name|ucfirst} property {$property_name}{if $active_value == $value} active{/if}{if $value|handle == 'bialy' || $value|handle == 'white'} white{/if}"
                                                    id="opt{$smarty.foreach.loopOuter.iteration}{$smarty.foreach.loopInner.iteration}"
                                                    data-property-name="{$property_name}"
                                                    data-property-value="{$value}">
                                                    <span style="background: {$pallete[$value|lower]};"></span>
                                                </li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                {else}
                                    <div class="option">
                                        <label for="property{$smarty.foreach.loopOuter.iteration}">{$property_name}</label>
                                        <select name="{$property_name}" data-property-name="{$property_name}" class="properties select transparent-label" id="property{$smarty.foreach.loopOuter.iteration}">
                                            {foreach from=$properties item="value" name="loopInner"}
                                                <option class="property" value="{$value}" data-property-value="{$value}" id="opt{$smarty.foreach.loopOuter.iteration}{$smarty.foreach.loopInner.iteration}">{$value}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>
                        {/if}
                        <div class="row">
                            {if $product->available}
                            <div class="col-xs-12">
                                <input type="number" name="quantity" value="1" min="1" class="product-quantity">
                                <button name="addToCard" class="btn btn-black btn-large add-to-cart" type="submit">{trans}store_theme_translations.add_to_cart_button_label{/trans}</button>
                            </div>
                            {/if}

                        </div>
                        
                        <div class="product-description wysiwyg-content">
                            {$product->description}
                        </div>
                        <div class="product-share">
                            <span>{trans}store_theme_translations.share{/trans}</span>
                            <ul>
                                <li><a href="https://www.facebook.com/sharer/sharer.php?u={reverse_url name=shop_product product_name=$product->url}&p[images][0]={$product->main_image|product_img_url:th1024}" target="_blank"><i class="icon-facebook"></i></a></li>

                                <li><a href="http://twitter.com/share?url={reverse_url name=shop_product  product_name=$product->url}" target="_blank"><i class="icon-twitter"></i></a></li>

                                <li><a href="http://pinterest.com/pin/create/button/?url={reverse_url name=shop_product product_name=$product->url}" target="_blank"><i class="icon-pinterest"></i></a></li>

                                <li><a href="https://plus.google.com/share?url={reverse_url name=shop_product  product_name=$product->url}" target="_blank"><i class="icon-google-plus"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- End Product Info column -->
    </div>
</div>
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="pswp__bg"></div>
    <div class="pswp__scroll-wrap">
        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>
        <div class="pswp__ui pswp__ui--hidden">

            <div class="pswp__top-bar">

                <div class="pswp__counter"></div>

                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>

                <button class="pswp__button pswp__button--fs" {if !$settings->enable_fullscreen}style="display: none;"{/if} title="Toggle fullscreen"></button>

                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                        <div class="pswp__preloader__cut">
                            <div class="pswp__preloader__donut"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div>
            </div>
            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
            </button>
            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
            </button>
            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>
        </div>
    </div>
</div>
{snippet file="product_matrix"}



{snippet file="rich_snippet"}
{if $product->getPromotion()->promotion_type == 3}
    <script>
        var isProgressiv = 1;
    </script>
{/if}

{snippet file="footer"}