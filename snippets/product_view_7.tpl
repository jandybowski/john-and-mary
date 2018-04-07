<figure>
    {if $settings->product_image_after_hover == 'opacity'}
        <div class="img img-opacity">
            <a href="{$productUrl}" class="{if $settings->cropped_product_photos} crop-photo{/if}{if $img_with_sidebar} img-with-sidebar{/if}" title="{$p->title}">
                <img src="{$p->main_image|product_img_url:th480}" {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if} />
            </a>
        </div>
    {elseif $settings->product_image_after_hover == 'next'}
        <div class="img">
            <a href="{$productUrl}" class="{if $settings->cropped_product_photos} crop-photo{/if}{if $img_with_sidebar} img-with-sidebar{/if}" title="{$p->title}">
                {assign var="photos" value=$p->getImages()}
                {if $photos|@count > 1}
                    {foreach from=$photos item="photo" name="list"}
                        {if $photo->url|product_img_url:th480 != $p->main_image|product_img_url:th480}
                            {assign indexHoverImg $smarty.foreach.list.index}
                            {break}
                        {else}
                            {continue}
                        {/if}
                    {/foreach}
                    <img class="main-photo" src="{$p->main_image|product_img_url:th640}" {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if}>
                    <img class="hovered-photo" src="{$photos[{$indexHoverImg}]->url|product_img_url:th640}" {if $photos[{$indexHoverImg}]->alt}alt="{$photos[{$indexHoverImg}]->alt}"{else}alt="{$p->name|escape}"{/if}>
                {else}
                    <img src="{$p->main_image|product_img_url:th480}" {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if} />
                {/if}
            </a>
        </div>
    {else}
        <div class="img">
            <a href="{$productUrl}" class="{if $settings->cropped_product_photos} crop-photo{/if}{if $img_with_sidebar} img-with-sidebar{/if}" title="{$p->title}">
                <img src="{$p->main_image|product_img_url:th480}" {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if} />
            </a>
        </div>
    {/if}
    <figcaption class="{if $settings->product_name_align == 'left'}align-left{elseif $settings->product_name_align == 'right'}align-right{else}align-center{/if}">
        <h3 class="list-product-title">
            <a href="{$productUrl}" title="{$p->title}">
                {$p->name}
            </a>
        </h3>
        <div  class="product-price">
            <p>{if $p->price_differ}{trans}store_theme_translations.price_differ{/trans}{/if}  {if $p->on_sale}<span class="old-price">{$p->price_regular|money}</span><span class="new-price">{$p->price_min|money}</span>{else}{$p->price_min|money}{/if}</p>
        </div>
        <form action="{reverse_url name='shop_cart_add'}" method="post" class="clearfix">
            <input type="hidden" name="id" value="{$p->first_available_variant->id}" data-price="{$p->first_available_variant->price|money_without_currency}" data-property1="{$p->first_available_variant->property1}" data-property2="{$p->first_available_variant->property2}" data-property3="{$p->first_available_variant->property3}" data-product-id="{$p->id}"/>
            <button type="submit" class="btn btn-black">{trans}store_theme_translations.add_to_cart_button_label{/trans}</button>
        </form>
    </figcaption>
</figure>
