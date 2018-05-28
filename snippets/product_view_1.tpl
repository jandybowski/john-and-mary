<figure>
    {if $settings->product_image_after_hover == 'opacity'}
        <div class="img img-opacity">
            <a href="{$productUrl}" class="{if $settings->cropped_product_photos} crop-photo{/if}{if $img_with_sidebar} img-with-sidebar{/if}" title="{$p->title}">
                <img src="{$p->main_image|product_img_url:th640}" {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if}  />
            </a>
        </div>
    {elseif $settings->product_image_after_hover == 'next'}
        <div class="img">
            <a href="{$productUrl}" class="jm-d-flex {if $settings->cropped_product_photos} crop-photo{/if}{if $img_with_sidebar} img-with-sidebar{/if}" title="{$p->title}">
                {assign var="photos" value=$p->getImages()}
                {if $photos|@count > 1}
                    {foreach from=$photos item="photo" name="list"}
                        {if $photo->url|product_img_url:th640 != $p->main_image|product_img_url:th640}
                            {assign indexHoverImg $smarty.foreach.list.index}
                            {break}
                        {else}
                            {continue}
                        {/if}
                    {/foreach}
                    <img class="main-photo jm-obj-fit__cover flex-1" src="{$p->main_image|product_img_url:th640}" {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if}>
                    <img class="hovered-photo  jm-obj-fit__cover flex-1" src="{$photos[{$indexHoverImg}]->url|product_img_url:th640}" {if $photos[{$indexHoverImg}]->alt}alt="{$photos[{$indexHoverImg}]->alt}"{else}alt="{$p->name|escape}"{/if}>
                {else}
                    <img src="{$p->main_image|product_img_url:th640}" {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if}  />
                {/if}
            </a>
        </div>
    {else}
        <div class="img">
            <a href="{$productUrl}" class="{if $settings->cropped_product_photos} crop-photo{/if}{if $img_with_sidebar} img-with-sidebar{/if}" title="{$p->title}">
                <img src="{$p->main_image|product_img_url:th640}" {if $p->main_image->alt}alt="{$p->main_image->alt}"{else}alt="{$p->name|escape}"{/if}  />
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
            <p>{if $p->price_differ}{trans}store_theme_translations.price_differ{/trans}{/if} {if $p->on_sale}<span class="old-price">{$p->price_regular|money}</span><span class="new-price">{$p->price_min|money}</span>{else}{$p->price_min|money}{/if}</p>
        </div>
    </figcaption>
</figure>
