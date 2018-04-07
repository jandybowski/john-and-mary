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
'grey'=> '#e8e8e8',
'pink'=> '#dabdcb',
'green'=> '#c2d8b7',
'blue'=> '#e8f8f8'
]}


{if $smarty.server.REQUEST_URI|strstr:'properties' || $smarty.server.REQUEST_URI|strstr:'sort' || $settings->show_sidebar_on_load}
    {assign filters_active 1}
{else}
    {assign filters_active 0}
{/if}
{if isset($page_set) && $page_type != 'search'}
    {assign min_price $page_set->price_min|money_without_currency}
	{assign max_price $page_set->price_max|money_without_currency}
{/if}
<div class="category_1">
    <div class="container">
        <div class="row">
            <header class="page-header">
                <div class="row">
                    <div class="col-xs-12 align-center">
                        <h1 {if !$settings->show_breadcrumbs}class="without-breadcrumbs"{/if}>
                            {if $page_type == 'search'}
                                {trans}store_theme_translations.search_title{/trans}
                            {else}
                                {$page_set->title}
                            {/if}
                        </h1>
                        {if $page_type == 'category'}
                            {if $settings->category_show_description}
                                <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 col-sm-12 col-xs-12">
                                    {if $category->description}
                                        {$category->description}
                                    {/if}
                                </div>
                            {/if}
                        {elseif $page_type == 'vendor'}
                            {if $settings->vendor_show_description}
                                <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 col-sm-12 col-xs-12">
                                    {if $vendor->description}
                                        {$vendor->description}
                                    {/if}
                                </div>
                            {/if}
                        {elseif $page_type == 'collection'}
                            {if $settings->collection_show_description}
                                <div class="col-lg-6 col-lg-offset-3 col-md-8 col-md-offset-2 col-sm-12 col-xs-12">
                                    {if $collection->description}
                                        {$collection->description}
                                    {/if}
                                </div>
                            {/if}
                        {/if}
                    </div>
                </div>
            </header>
            {if $settings->show_breadcrumbs}
                {snippet file="breadcrumbs"}
            {/if}
        </div>

        <div class="row">
            {if $page_type == 'search'}
            	{assign paginateItems ''}
            {else}
				{assign paginateItems $page_set->getProducts()}
			{/if}
            {paginate set=$page_set items=$paginateItems per_page=$settings->category_1_list_products_count}
            {if $settings->category_1_show_sidebar && $page_type != 'search'}
                {snippet file="sidebar"}
            {/if}
            <div class="col-xs-12 {if $settings->category_1_show_sidebar && $page_type != 'search'}col-md-9{else}col-md-12{/if}">
                <div class="{$grid_class}">
                    <div class="row">
                        <div class="clearfix product-list">
                            {assign var="products" value=$items}
                            {if !$products}
                                <p class="align-center">{trans}store_theme_translations.no_products{/trans}</p>
                            {else}
                                {foreach from=$products item="p" name="list"}
                                    <div class="{$product_col_class}">
                                        {assign var=productUrlName value="shop_product_within_$page_type"}
                                        {if $page_type == 'search'}
                                            {assign var=productUrl value={reverse_url name=shop_product product_name=$p->url}}
                                        {elseif $page_type == 'category'}
                                            {assign var=productUrl value={reverse_url name=$productUrlName category_name=$page_set->url product_name=$p->url}}
                                        {elseif $page_type == 'vendor'}
                                            {assign var=productUrl value={reverse_url name=$productUrlName vendor_name=$page_set->url product_name=$p->url}}
                                        {elseif $page_type == 'collection'}
                                            {assign var=productUrl value={reverse_url name=$productUrlName collection_name=$page_set->url product_name=$p->url}}
                                        {/if}
                                        {snippet file="product_view_$product_view" img_with_sidebar=$settings->category_1_show_sidebar}
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                </div>
            </div>

            {if $pager->is_pagination_need}
            <div class="col-xs-12 col-md-no-pd">
                {$pager|default_pagination}
            </div>
            {/if}
            {/paginate}
        </div>
    </div>
</div>
