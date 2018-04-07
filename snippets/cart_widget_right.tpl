<div id="cartWidgetRight" class="sliding-cart-widget">
    <button id="closeTriggerTop" class="cart-widget-trigger"><i class="icon icon-close"></i></button>
    <h4 class="align-center">{trans}store_theme_translations.cart_widget_heading{/trans}</h4>
    <form id="minicartSummary" action="{reverse_url name=shop_cart}" class="col-xs-12 col-xs-no-pde{if $cart->item_count == 0} hidden{/if}" method="post" >
        <ol class="mini-products-list">
            <li class="mini-products-item item-template cart-product" data-variant-id="" data-product-id="" data-qty="" data-price="">
                <div class="mini-products-item-top">
                    <div class="mini-products-item-top-left">
                        <a href="" title="" class="product-image">
                            <img src="" alt="">
                        </a>
                    </div>
                    <div class="mini-products-item-top-right">
                        <span class="mini-products-item-quantity">x <input class="" type="number" min="0" value="1" data-price=""></span>
                        <span class="mini-products-item-remove"><a href="#" class="delete-item-button"><i class="icon-close"></i></a></span>
                        <span class="mini-products-item-price"></span>
                        <a href="" class="mini-product-title"></a>
                        <ul class="mini-products-item-properties">
                        </ul>
                    </div>
                </div>
            </li>
            {foreach from=$cart->items item="item"}
                <li class="mini-products-item cart-product" id="cart-item-{$item->id}" data-variant-id="{$item->variant->id}" data-product-id="{$item->product->id}" data-qty="{$item->quantity}" data-price="{$item->price|money}">
                    <div class="mini-products-item-top">
                        <div class="mini-products-item-top-left">
                            <a href="{reverse_url name='shop_product' product_name=$item->product->url}" title="{$item->title}" class="product-image">
                                <img src="{$item->variant->main_image|product_img_url:th100}" alt="{$item->title}">
                            </a>
                        </div>
                        <div class="mini-products-item-top-right">
                            <span class="mini-products-item-quantity">x <input class="" name="updates[{$item->id}]" id="updates_{$item->id}" value="{$item->quantity}" data-price="{$item->price|money_without_currency}" data-value="{$item->quantity}" data-max="{$item->variant->quantity}" data-available="{$item->variant->available}" min="1" type="number"  data-price="{$item->price|money_without_currency}"></span>
                            <span class="mini-products-item-remove"><a href="#" class="delete-item-button"><i class="icon-close"></i></a></span>
                            <span class="mini-products-item-price" data-price="{$item->price|money_without_currency}">{$item->price|money}</span>
                            <a href="{reverse_url name='shop_product' product_name=$item->product->url}" class="mini-product-title">{$item->product->name}</a>
                            <ul class="mini-products-item-properties">
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
                        </div>
                    </div>
                </li>
            {/foreach}
        </ol>
        {if $settings->show_cart_default_delivery_cost}
            <div class="cart-delivery-cost col-xs-12">
                <div class="row">
                    <div class="col-xs-5 col-xs-offset-1">
                        {trans}store_theme_translations.cart_delivery_label{/trans}:
                    </div>
                    <div class="col-xs-5 align-right">
                        {assign defaultDeliveryCost $settings->cart_default_delivery_cost|floatval*100}
                        <span>{$defaultDeliveryCost|money}</span>
                    </div>
                </div>
            </div>
        {/if}
        <p class="mini-products-list-total align-center">
            <span>{trans}store_theme_translations.order_summary_label{/trans}</span>
            <span id="sumPrice" class="mini-products-list-total-price" data-sum="{$cart->total_price|money_without_currency}">{$cart->total_price|money}</span>
        </p>
        <div class="actions align-center">
            <div class="col-xs-12">
                <button class="btn btn-black btn-large" type="submit" name="order">{trans}store_theme_translations.puchase_button_label{/trans}</button>
            </div>
            <div class="col-xs-12">
                <a href="{reverse_url name='shop_cart'}" class="go-to-cart">{trans}store_theme_translations.go_to_cart{/trans}</a>
            </div>
        </div>
    </form>

    <div class="mini-products-list-empty align-center{if $cart->item_count != 0} hidden{/if}">
        <p>{trans}store_theme_translations.empty_cart_text{/trans}</p>
        <a href="{reverse_url name='shop_category_list'}">{trans}store_theme_translations.prompt_text{/trans}</a>
    </div>
</div>
