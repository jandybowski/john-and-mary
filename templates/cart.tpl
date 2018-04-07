<div class="container cart-1">

	<div class="row">
		<header class="col-sm-12 cart-title">
            <div class="row">
                <h2 class="col-xs-12 col-md-6">{trans}store_theme_translations.cart_header{/trans}</h2>
            </div>
		</header>

		{if $cart->item_count > 0}
            {assign productsNotHaveVariants 0}
            {foreach from=$cart->items item="item"}
                {if $item->variant->properties|count > 0 && $item->properties|count > 0}
                    {assign productsNotHaveVariants 1}
                {/if}
            {/foreach}
			<form id="cartSummary" class="col-sm-12" action="{reverse_url name=shop_cart}" method="post">
                <div id="tableHead" class="xs-hide">
                    <div class="row">
                       <div class="col-xs-5{if $productsNotHaveVariants == '1'} col-sm-5{else} col-sm-7{/if} cart-head-product">{trans}store_theme_translations.cart_head_product{/trans}</div>
                        <div class="col-xs-2 col-md-2 cart-head-variants"{if $productsNotHaveVariants != '1'} style="display: none;"{/if}>{trans}store_theme_translations.cart_head_variants{/trans}</div>
                        <div class="col-xs-2 col-md-2 quantity align-center">{trans}store_theme_translations.cart_head_quantity{/trans}</div>
                        <div class="col-xs-2 col-md-2 align-center">{trans}store_theme_translations.cart_head_amount{/trans}</div>
                    </div>
                </div>
				{foreach from=$cart->items item="item"}
					<div class="cart-product" data-variant-id="{$item->variant->id}" data-product-id="{$item->product->id}">
                        <div class="row">
                            <div class="col-xs-12{if $productsNotHaveVariants == '1'} col-sm-5{else} col-sm-7{/if} product-data">
                                <div class="product-img">
                                    <a href="{reverse_url name='shop_product' product_name=$item->product->url}"><img src="{$item->variant->main_image|product_img_url:th100}" alt="{$item->product->name}" /></a>
                                </div>
                                <div class="product-info">
                                    <p>{$item->product->vendor->title}</p>
                                    <h2><a href="{reverse_url name='shop_product' product_name=$item->product->url}">{$item->product->name|truncate:25}</a></h2>
                                    <div class="xs-show">
                                        <div class="product-variants"{if $productsNotHaveVariants != '1'} style="display: none"{/if}>
                                            {foreach from=$item->variant->properties key="name" item="value" name="variantList"}
                                                <p>{$name}: {$value}</p>
                                            {/foreach}
                                            {if $settings->show_cart_products_properties}
                                                {foreach from=$item->properties key="name" item="value" name="variantList"}
                                                    <p>{$value->title}: 
                                                        {if $value->value|strstr:"/storeuploads"}
                                                            <a href="{$value->value}" target="_blank">{trans}store_theme_translations.uploaded_file{/trans}</a>
                                                        {else}
                                                            {$value->value}
                                                        {/if}</p>
                                                {/foreach}
                                            {/if}
                                        </div>
                                        <div class="product-qty">
                                            <button class="decrease-button" type="button">-</button>
                                            <input class="qty" name="updates[{$item->id}]" id="updates_{$item->id}" value="{$item->quantity}" data-price="{$item->price|money_without_currency}" type="text">
                                            <button class="increase-button" type="button">+</button>
                                        </div>
                                        <div class="product-price">
                                            <span>{$item->price|money}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                           
                            <div class="col-xs-12 col-sm-2 col-md-2 xs-hide product-variants"{if $productsNotHaveVariants != '1'} style="display: none"{/if}>
                                {foreach from=$item->variant->properties key="name" item="value" name="variantList"}
                                    <p>{$name}: {$value}</p>
                                {/foreach}
                                {if $settings->show_cart_products_properties}
                                    {foreach from=$item->properties key="name" item="value" name="variantList"}
                                        <p>{$value->title}: 
                                            {if $value->value|strstr:"/storeuploads"}
                                                <a href="{$value->value}" target="_blank">{trans}store_theme_translations.uploaded_file{/trans}</a>
                                            {else}
                                                {$value->value}
                                            {/if}</p>
                                    {/foreach}
                                {/if}
                            </div>
                            
                            <div class="col-xs-6 col-sm-2 col-md-2 xs-hide product-qty">
                                <button class="increase-button" type="button">+</button>
                                <input class="qty" name="updates[{$item->id}]" id="updates_{$item->id}" value="{$item->quantity}" data-price="{$item->price|money_without_currency}" type="text">
                                <button class="decrease-button" type="button">-</button>
                            </div>
                            <div class="col-xs-6 col-sm-2 col-md-2 xs-hide product-price">
                                <span>{$item->price|money}</span>
                            </div>
                            <div class="col-xs-2 col-sm-1 col-md-1 delete-item">
                                <button type="button" class="delete-item-button">
                                    <i class="icon icon-close"></i>
                                </button>
                            </div>
                        </div>
					</div>
				{/foreach}
                {if $settings->show_cart_default_delivery_cost || $settings->show_cart_default_delivery_info}
                <div class="cart-delivery">
                    <div class="row">
                        {if $settings->show_cart_default_delivery_info}
                        <div class="col-xs-12{if $settings->show_cart_default_delivery_cost} col-md-5 col-lg-5{else} col-md-12{/if} align-left cart-delivery-date-info">
                            <p>{trans}store_theme_translations.cart_delivery_info{/trans}</p>
                        </div>
                        {/if}
                        {if $settings->show_cart_default_delivery_cost}
                        <div class="col-xs-6{if !$settings->show_cart_default_delivery_info} col-md-offset-4 col-lg-offset-5{/if} col-md-3 col-lg-4 align-right">
                            <p>{trans}store_theme_translations.cart_delivery_label{/trans}: {$settings->cart_delivery_info}</p>
                        </div>
                        <div class="col-xs-6 col-md-4 col-lg-2 cart-delivery-cost align-center">
                            {assign defaultDeliveryCost $settings->cart_default_delivery_cost|floatval*100}
                            <span>{$defaultDeliveryCost|money}</span>
                        </div>
                        {/if}
                    </div>
                </div>
                {/if}
                <div id="sumCartPrice" class="cart-sum">
                    <div class="row">
                        <div class="col-xs-6 col-sm-6 col-md-8 col-lg-9">
                            <p>{trans}store_theme_translations.order_summary_label{/trans}</p>
                        </div>
                        <div id="sumPrice" class="col-xs-6 col-md-4 col-lg-2 align-center" data-sum="{$cart->total_price|money_without_currency}">
                            <span>{$cart->total_price|money}</span>
                        </div>
                    </div>
                </div>
        
                <div id="cartActions" class="row">
                    <div class="col-sm-6 col-md-6">
                        <a href="{reverse_url name='shop_category_list'}" class="return">
                            {trans}store_theme_translations.continue_shopping_label{/trans}</a>
                    </div>
                    <div class="col-sm-6 col-md-6 align-right">
                        <button id="toCheckout" class="btn btn-black btn-large push-right" type="submit" name="order" value="Order">{trans}store_theme_translations.puchase_button_label{/trans}</button>
                        <p class="align-right">{trans}store_theme_translations.cart_next_step_info{/trans}</p>
                    </div>
                </div>
				
			</form>
        {/if}
        <div class="col-sm-12 empty-cart align-center {if $cart->item_count != 0}hidden{/if}">
            <p class="msg align-center">{trans}store_theme_translations.empty_cart_text{/trans}</p>
            <a href="{$return_to}" class="btn btn-black btn-large push-right">{trans}store_theme_translations.prompt_text{/trans}</a>
        </div>
		
	</div>
</div>


