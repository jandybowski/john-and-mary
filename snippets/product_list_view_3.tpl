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

<div class="category_3">
    <div class="container">
        {if $page_type == 'category'}
            {if $settings->category_show_description}
                <div class="row">
                    <div class="col-sm-12 col-xs-12">
                        {if $category->description}
                            {$category->description}
                        {/if}
                    </div>
                </div>
            {/if}
        {elseif $page_type == 'vendor'}
            {if $settings->vendor_show_description}
                <div class="row">
                    <div class="col-sm-12 col-xs-12">
                        {if $vendor->description}
                            {$vendor->description}
                        {/if}
                    </div>
                </div>
            {/if}
        {elseif $page_type == 'collection'}
            {if $settings->collection_show_description}
                <div class="row">
                    <div class="col-sm-12 col-xs-12">
                        {if $collection->description}
                            {$collection->description}
                        {/if}
                    </div>
                </div>
            {/if}
        {/if}
        <div class="row filters">
            {if $settings->category_3_show_categories_nav}
                <div class="col-xs-12 col-md-6 col-lg-3">
                    <div class="categories-section">
                        <select name="categories" class="select transparent-label select-url" id="">
                            {foreach from=$categories->all item="cat"}
                                <option value="{reverse_url name=shop_category category_name=$cat->url}" {if $category->title == $cat->title}selected="selected"{/if}>{$cat->title}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            {/if}
            {if $settings->category_3_show_filters_sort}
                <div class="col-xs-12 col-md-6 col-lg-2 col-lg-offset-7">
                    <section class="filter-section filter-sort">
                        <select class="select transparent-label" data-placeholder="Kolejność">
                            <option value="">{trans}store_theme_translations.sort{/trans}</option>
                            <option value="0">{trans}store_theme_translations.clear_filters{/trans}</option>
                            <option value="sort=price">{trans}store_theme_translations.from_cheapest{/trans}</option>
                            <option value="sort=price&order=desc">{trans}store_theme_translations.from_most_expensive{/trans}</option>
                            <option value="sort=title">{trans}store_theme_translations.filter_by_name{/trans}</option>
                            <option value="sort=title&order=desc">{trans}store_theme_translations.filter_by_name_reverse{/trans}</option>
                        </select>
                    </section>
                </div>
            {/if}
            {if $template == 'category' && $settings->category_3_show_filters_properties}
                {foreach from=$page_set->properties key=name item=props name="filter_props"}
                    {if $smarty.foreach.filter_props.index < 15}
                        {assign var="foo" value=sort($props)}
                        <div id="property{$name|escape:'url'}" data-filter-type="filter-property" class="col-xs-12 col-md-12 col-lg-6 section filter-section filter-property {if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}colour-mode{/if}" >
                            <div class="content">
                                <h4>{$name|lower}:</h4>
                                {foreach from=$props item=p}
                                    {if $p == ""}{continue}{/if}
                                    <div class="control checkbox">
                                        <input id="{$p|replace:' ':''}" type="checkbox" name="{$name|replace:' ':''}" value="{$p}" data-name="{$name|escape:'url'}" data-val="{$p|lower|replace:' ':'_'}">
                                        <label for="{$p|replace:' ':''}">{if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}<span style="background: {$pallete[$p|lower|replace:' ':'_']};" title="{$p}"></span>{else}{$p}{/if}</label>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                {/foreach}
            {/if}
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
            {paginate set=$page_set items=$paginateItems per_page=$settings->category_3_list_products_count}
                <div class="col-md-12 ">
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
                                            {snippet file="product_view_$product_view" }
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
