<div class="container {$grid_class}">
    <div class="row">
        {if $home_show_sidebar}
            {snippet file="sidebar" home_show_sidebar_subcategories=$home_show_sidebar_subcategories home_show_categories_nav=$home_show_categories_nav home_show_collections_nav=$home_show_collections_nav home_show_vendors_nav=$home_show_vendors_nav}
        {/if}
        <div class="{if $home_show_sidebar}col-md-9 col-sm-no-pd{/if} clearfix product-list">
            {if $collections->{$settings->frontpage_collection}}
                {assign frontpage_collection $collections->{$settings->frontpage_collection}}
            {/if}
            {if $frontpage_collection}
                {assign var="products" value=$frontpage_collection->getProducts($settings_frontpage_collection_products_count)}
            {/if}
            {if !$products && $frontpage_collection}
                <p class="align-center">{trans}store_theme_translations.no_products{/trans}</p>
            {else}
                {foreach from=$products item="p" name="list"}
                    <div class="{$product_col_class}">
                        {assign var=productUrl value={reverse_url name=shop_product_within_collection collection_name=$frontpage_collection->url product_name=$p->url}}
                        {snippet file="product_view_$product_view" img_with_sidebar=$home_show_sidebar}
                    </div>
                {/foreach}
            {/if}
        </div>
    </div>
</div>