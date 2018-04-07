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
</figure>
