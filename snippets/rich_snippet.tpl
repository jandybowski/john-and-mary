<div itemscope itemtype="http://schema.org/Product">
    <meta itemprop="name" content="{$product->title}" />
    <meta itemprop="image" content="{$product->main_image|product_img_url:th160}" />
    <meta itemprop="description" content="{$product->description|strip_tags|escape}" />
    {if isset($category)}
        <meta itemprop="url" content="{reverse_url name=shop_product_within_category category_name=$category->url product_name=$product->url}" />
        <meta itemprop="category" content="{$category->title}" />
    {elseif isset($collection)}
        <meta itemprop="url" content="{reverse_url name=shop_product_within_collection collection_name=$collection->url product_name=$product->url}" />
        <meta itemprop="category" content="{$collection->title}" />
    {elseif isset($vendor)}
        <meta itemprop="url" content="{reverse_url name=shop_product_within_vendor vendor_name=$vendor->url product_name=$product->url}" />
        <meta itemprop="category" content="{$vendor->title}" />
    {else}
        <meta itemprop="url" content="{reverse_url name=shop_product product_name=$product->url}" />
    {/if}
    <div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
        <meta itemprop="priceCurrency" content="{$shop->currency}" />
        <meta itemprop="price" content="{$product->price_min|money_without_currency}" />
        {if $product->available}
            <link itemprop="availability" href="http://schema.org/InStock" />
        {else}
            <link itemprop="availability" href="http://schema.org/OutOfStock" />
        {/if}
    </div>
</div>