<div class="container {$grid_class}">
  <div class="row">
    <div class="clearfix product-list">
      {if isset($category)}
        {assign var="products" value=$category->getProducts($settings->product_page_similar_count+1)}
      {elseif isset($collection)}
        {assign var="products" value=$collection->getProducts($settings->product_page_similar_count+1)}
      {elseif isset($vendor)}
        {assign var="products" value=$vendor->getProducts($settings->product_page_similar_count+1)}
      {/if}
      {if !$products}
        <p class="align-center">{trans}store_theme_translations.no_products{/trans}</p>
      {else}
        {assign found_product 0}
        {foreach from=$products item="p" name="list"}
        {if $p->url == $product->url}
            {assign found_product 1}
            {continue}
        {/if}
        {if $smarty.foreach.list.iteration < $settings->product_page_similar_count+1 || $found_product}
            <div class="{$product_col_class}">
                {if isset($category)}
                        {assign var=productUrl value={reverse_url name=shop_product_within_category category_name=$category->url product_name=$p->url}}
                    {elseif isset($collection)}
                        {assign var=productUrl value={reverse_url name=shop_product_within_collection collection_name=$collection->url product_name=$p->url}}
                    {else}
                        {assign var=productUrl value={reverse_url name=shop_product_within_collection collection_name=$collections->bestsellery->url product_name=$p->url}}
                    {/if}
                {snippet file="product_view_$product_view"}
            </div>
        {/if}
        {/foreach}
      {/if}
    </div>
  </div>
</div>
