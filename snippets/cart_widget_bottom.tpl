<div id="cartWidgetBottom" class="sliding-cart-widget">
    <button id="closeTriggerTop" class="cart-widget-trigger"><i class="icon icon-close"></i></button>
    <div class="container">

        <form id="minicartSummary" class="col-sm-12" action="{reverse_url name=shop_cart}" method="post">
            {assign productsNotHaveVariants 0}
            {foreach from=$cart->items item="item"}
                {if $item->variant->properties|count > 0 && $item->properties|count > 0}
                    {assign productsNotHaveVariants 1}
                {/if}
            {/foreach}
            <div id="tableHead" {if $cart->item_count == 0}class="hidden"{/if}>
                <div class="row">
                    <div class="col-xs-5{if $productsNotHaveVariants == '1'} col-sm-4 col-md-5{else} col-sm-6 col-md-7{/if} cart-head-product">{trans}store_theme_translations.cart_head_product{/trans}</div>
                    <div class="col-xs-2 col-md-2 cart-head-variants"{if $productsNotHaveVariants != '1'} style="display: none;"{/if}>{trans}store_theme_translations.cart_head_variants{/trans}</div>
                    <div class="col-xs-2 col-md-2 align-left xs-hide">{trans}store_theme_translations.cart_head_amount{/trans}</div>
                    <div class="col-xs-2 col-md-1 quantity align-center xs-hide">{trans}store_theme_translations.cart_head_quantity{/trans}</div>
                    <div class="col-xs-2 col-md-2 align-left xs-hide">{trans}store_theme_translations.cart_head_amount_sum{/trans}</div>
                </div>
            </div>
            <ol class="mini-products-list row">
                <li class="mini-products-item cart-product col-xs-12 item-template" >
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-5 product-data">
                            <div class="delete-item">
                                <button type="button" class="delete-item-button">
                                    <i class="icon icon-close"></i>
                                </button>
                            </div>
                            <div class="product-image">
                                <a href=""><img src="" /></a>
                            </div>
                            <div class="product-info">
                                <p class="product-vendor"></p>
                                <h2><a class="mini-product-title" href=""></a></h2>
                                <div class="xs-show">
                                    <ul class="product-variants mini-products-item-properties"{if $productsNotHaveVariants != '1'} style="display: none"{/if}>

                                    </ul>
                                    <div class="product-qty mini-products-item-quantity">
                                        <button class="decrease-button" type="button">-</button>
                                        <input class="qty" name="" id="" value="" data-price="" type="text">
                                        <button class="increase-button" type="button">+</button>
                                    </div>
                                    <div class="product-price mini-products-item-price" data-price="">
                                        <span></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <ul class="col-xs-12 col-sm-2 col-md-2 xs-hide product-variants mini-products-item-properties"{if $productsNotHaveVariants != '1'} style="display: none"{/if}>

                        </ul>
                        <div class="col-xs-6 col-sm-2 col-md-2 xs-hide product-price mini-products-item-price col-md-no-pd">
                            <span></span>
                        </div>
                        <div class="col-xs-6 col-sm-2 col-md-1 xs-hide product-qty mini-products-item-quantity">
                            <button class="increase-button" type="button">+</button>
                            <input class="qty" name="" id="" value="" data-price="" type="text">
                            <button class="decrease-button" type="button">-</button>
                        </div>
                        <div class="col-xs-6 col-sm-2 col-md-2 xs-hide product-price product-price-sum">
                            <span></span>
                        </div>

                    </div>
                </li>
                {if $cart->item_count > 0}
                    {foreach from=$cart->items item="item"}
                        <li class="mini-products-item cart-product col-xs-12" id="cart-item-{$item->id}" data-variant-id="{$item->variant->id}" data-product-id="{$item->product->id}" data-qty="{$item->quantity}" data-price="{$item->price|money}">
                            <div class="row">
                                <div class="col-xs-12{if $productsNotHaveVariants == '1'} col-sm-4 col-md-5{else} col-sm-6 col-md-7{/if} product-data">
                                    <div class="delete-item">
                                        <button type="button" class="delete-item-button">
                                            <i class="icon icon-close"></i>
                                        </button>
                                    </div>
                                    <div class="product-image">
                                        <a href="{reverse_url name='shop_product' product_name=$item->product->url}"><img src="{$item->variant->main_image|product_img_url:th100}" alt="{$item->product->name}" /></a>
                                    </div>
                                    <div class="product-info">
                                        <p class="product-vendor">{$item->product->vendor->title}</p>
                                        <h2><a href="{reverse_url name='shop_product' product_name=$item->product->url}">{$item->product->name|truncate:25}</a></h2>
                                        <div class="xs-show">
                                            {if $productsNotHaveVariants == '1'}
                                                <ul class="product-variants mini-products-item-properties">
                                                    {foreach from=$item->variant->properties key="name" item="value" name="variantList"}
                                                        <li>{$name}: {$value}</li>
                                                    {/foreach}
                                                    {if $settings->show_cart_products_properties}
                                                        {foreach from=$item->properties key="name" item="value" name="variantList"}
                                                            <li>{$value->title}:
                                                                {if $value->value|strstr:"/storeuploads"}
                                                                    <a href="{$value->value}" target="_blank">{trans}store_theme_translations.uploaded_file{/trans}</a>
                                                                {else}
                                                                    {$value->value}
                                                                {/if}</li>
                                                        {/foreach}
                                                    {/if}
                                                </ul>
                                            {/if}
                                            <div class="product-qty mini-products-item-quantity">
                                                <button class="decrease-button" type="button">-</button>
                                                <input class="qty" name="updates[{$item->id}]" id="updates_{$item->id}" value="{$item->quantity}" data-price="{$item->price|money_without_currency}" type="text">
                                                <button class="increase-button" type="button">+</button>
                                            </div>
                                            <div class="product-price mini-products-item-price" data-price="{$item->price|money_without_currency}">
                                                <span>{$item->price|money}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {if $productsNotHaveVariants == '1'}
                                    <ul class="col-xs-12 col-sm-2 col-md-2 xs-hide product-variants mini-products-item-properties">
                                        {foreach from=$item->variant->properties key="name" item="value" name="variantList"}
                                            <li>{$name}: {$value}</li>
                                        {/foreach}
                                        {if $settings->show_cart_products_properties}
                                            {foreach from=$item->properties key="name" item="value" name="variantList"}
                                                <li>{$value->title}:
                                                    {if $value->value|strstr:"/storeuploads"}
                                                        <a href="{$value->value}" target="_blank">{trans}store_theme_translations.uploaded_file{/trans}</a>
                                                    {else}
                                                        {$value->value}
                                                    {/if}</li>
                                            {/foreach}
                                        {/if}
                                    </ul>
                                {/if}
                                <div class="col-xs-6 col-sm-2 col-md-2 xs-hide product-price mini-products-item-price col-md-no-pd">
                                    <span>{$item->price|money}</span>
                                </div>
                                <div class="col-xs-6 col-sm-2 col-md-1 xs-hide product-qty mini-products-item-quantity">
                                    <button class="increase-button" type="button">+</button>
                                    <input class="qty" name="updates[{$item->id}]" id="updates_{$item->id}" value="{$item->quantity}" data-price="{$item->price|money_without_currency}" type="text">
                                    <button class="decrease-button" type="button">-</button>
                                </div>
                                <div class="col-xs-6 col-sm-2 col-md-2 xs-hide product-price product-price-sum">
                                    <span>{$item->price|money}</span>
                                </div>

                            </div>
                        </li>
                    {/foreach}
                {/if}
            </ol>
            {if $settings->show_cart_default_delivery_cost || $settings->show_cart_default_delivery_info}
                <div class="cart-delivery">
                    <div class="row">
                        {if $settings->show_cart_default_delivery_info}
                            <div class="col-xs-12{if $settings->show_cart_default_delivery_cost} col-md-5 col-lg-7{else} col-md-12{/if} align-left cart-delivery-date-info">
                                <p>{trans}store_theme_translations.cart_delivery_info{/trans}</p>
                            </div>
                        {/if}
                        {if $settings->show_cart_default_delivery_cost}
                            <div class="col-xs-7{if !$settings->show_cart_default_delivery_info} col-md-offset-4 col-lg-offset-5{/if} col-md-3 col-lg-3 align-right">
                                <p>{trans}store_theme_translations.cart_delivery_label{/trans}: {$settings->cart_delivery_info}</p>
                            </div>
                            <div class="col-xs-5 col-md-4 col-lg-2 cart-delivery-cost align-left">
                                {assign defaultDeliveryCost $settings->cart_default_delivery_cost|floatval*100}
                                <span>{$defaultDeliveryCost|money}</span>
                            </div>
                        {/if}
                    </div>
                </div>
            {/if}
            <div id="sumCartPrice" class="cart-sum">
                <div class="row">
                    <div class="col-xs-7 col-md-8 col-lg-offset-7 col-lg-3">
                        <p>{trans}store_theme_translations.order_summary_label{/trans}</p>
                    </div>
                    <div id="sumPrice" class="col-xs-5 col-md-4 col-lg-2 align-left mini-products-list-total-price" data-sum="{$cart->total_price|money_without_currency}">
                        <span class="mini-products-list-total-price">{$cart->total_price|money_without_currency}</span> {$shop->currency}
                    </div>
                </div>
            </div>
            <div id="cartActions" class="row">
                <div class="col-sm-6 col-md-6 align-right">
                    <a href="{reverse_url name='shop_category_list'}" class="return btn-large">
                        {trans}store_theme_translations.continue_shopping_label{/trans}</a>
                </div>
                <div class="col-sm-6 col-md-6 align-left">
                    <button id="toCheckout" class="btn btn-black btn-large push-right" type="submit" name="order" value="Order">{trans}store_theme_translations.puchase_button_label{/trans}</button>
                    <p class="align-left">{trans}store_theme_translations.cart_next_step_info{/trans}</p>
                </div>
            </div>
        </form>

        <div class="mini-products-list-empty align-center{if $cart->item_count != 0} hidden{/if}">
            <p>{trans}store_theme_translations.empty_cart_text{/trans}</p>
            <a href="{reverse_url name='shop_category_list'}">{trans}store_theme_translations.prompt_text{/trans}</a>
        </div>
    </div>
</div>