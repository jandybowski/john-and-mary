{$pallete = [
'sand'=> '#ebd4bb',
'black'=> '#414644',
'mint'=> '#c4e6da',
'grey'=> '#e8e8e8',
'pink'=> '#dabdcb',
'green'=> '#c2d8b7',
'blue'=> '#e8f8f8'
]}


{if $smarty.server.REQUEST_URI|strstr:'properties' || $smarty.server.REQUEST_URI|strstr:'sort' || $settings->category_1_show_sidebar_on_load}
    {assign filters_active 1}
{else}
    {assign filters_active 0}
{/if}
{if isset($category)}
    {assign min_price $category->price_min|money_without_currency}
    {assign max_price $category->price_max|money_without_currency}
{elseif isset($collection)}
    {assign min_price $collection->price_min|money_without_currency}
    {assign max_price $collection->price_max|money_without_currency}
{elseif isset($vendor)}
    {assign min_price $vendor->price_min|money_without_currency}
    {assign max_price $vendor->price_max|money_without_currency}
{/if}
{if $template == 'category'}
    <div class="sidebar col-md-3">
        <div class="categories-section{if $settings->category_1_show_sidebar_subcategories} show-subcategories{/if}">
            <h4>{trans}store_theme_translations.categories{/trans}</h4>
            {$categories->createListView($category->url, 'categories', 'active')}
            {if $settings->category_1_show_collections_nav}
                <h4>{trans}store_theme_translations.collections{/trans}</h4>
                <ul class="categories">
                    {foreach from=$collections->all item="collection"}
                        <li>
                            <a href="{reverse_url name='shop_collection' collection_name=$collection->url}">{$collection->title}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
            {if $settings->category_1_show_vendors_nav}
                <h4>{trans}store_theme_translations.vendor{/trans}</h4>
                <ul class="categories">
                    {foreach from=$shop->vendors item="vendor" name="foo"}
                        <li>
                            <a href="{reverse_url name=shop_vendor vendor_name=$vendor->url}">{$vendor->title}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </div>
        {if $settings->category_1_show_sidebar_filters}
            <div class="filters">
                <a data-toggle="collapse" href="#filtersContent"
                   aria-expanded="{if $filters_active == 1}true{else}false{/if}" aria-controls="filtersContent"
                   id="showFilters"
                   class="btn-gray btn-block {if $filters_active == 0} collapsed{/if}">{trans}store_theme_translations.filter{/trans}
                    <i class="icon-caret-down"></i></a>
                <div id="filtersContent" class="filters-content collapse {if $filters_active == 1}in{/if}">
                    {if $settings->category_1_show_sidebar_filters_properties}
                        {if $template == 'category'}
                            {foreach from=$category->properties key=name item=props}
                                {assign var="foo" value=sort($props)}
                                {if $settings->filters_handle != 'select'}
                                    <div data-filter-type="filter-property"
                                         class="section filter-section filter-property {if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}colour-mode{/if}">
                                        <h4>{$name|lower}: <span class="icon icon-plus-bold"></span></h4>
                                        <div class="content">
                                            {foreach from=$props item=p}
                                                {if $p == ""}{continue}{/if}
                                                <div class="control checkbox">
                                                    <input id="{$p|replace:' ':''}" type="checkbox"
                                                           name="{$name|replace:' ':''}" value="{$p}"
                                                           data-name="{$name|escape:'url'}"
                                                           data-val="{$p|lower|replace:' ':'_'}">
                                                    <label for="{$p|replace:' ':''}">{if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}
                                                        <span
                                                                style="background: {$pallete[$p|lower|replace:' ':'_']};"
                                                                title="{$p}"></span>{else}{$p}{/if}</label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                {else}
                                    <div class="section filter-section filter-property"
                                         data-filter-type="filter-property">
                                        <h4>{$name|lower}:</h4>
                                        <div class="content">
                                            <select name="{$name|replace:' ':''}" id="" data-name="{$name|escape:'url'}"
                                                    class="select">
                                                {foreach from=$props item=p name=list}
                                                    {if $smarty.foreach.list.first}
                                                        <option value="0">{trans}store_theme_translations.filter{/trans}</option>
                                                    {/if}
                                                    {if $p == ""}{continue}{/if}
                                                    <option value="{$p}"
                                                            data-val="{$p|lower|replace:' ':'_'}">{$p}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        {elseif $template == 'collection'}
                            {foreach from=$collection->properties key=name item=props}
                                {assign var="foo" value=sort($props)}
                                <div class="section filter-section filter-property" data-filter-type="filter-property">
                                    <h4>{$name|lower}:<span class="icon-plus"></span></h4>
                                    <div class="content">
                                        {foreach from=$props item=p}
                                            {if $p == ""}{continue}{/if}
                                            <div class="control checkbox">
                                                <input id="{$p|replace:' ':''}" type="checkbox"
                                                       name="{$name|replace:' ':''}" value="{$p}"
                                                       data-name="{$name|escape:'url'}">
                                                <label for="{$p|replace:' ':''}">{$p}</label>
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                            {/foreach}
                        {/if}
                    {/if}
                    <!-- vendor filter -->
                    {if $shop->vendors|count != 0 && $settings->category_1_show_sidebar_filters_vendor}
                        <div class="section filter-section filter-vendor" data-filter-type="filter-vendor">
                            <h4>{trans}store_theme_translations.vendor{/trans}:</h4>
                            {if $settings->filters_handle != 'select'}
                                {foreach from=$shop->vendors item="vendor"}
                                    <div class="control checkbox">
                                        <input id="{$vendor->title|replace:' ':''}" type="checkbox" name="vendor"
                                               value="{$vendor->url}">
                                        <label for="{$vendor->title|replace:' ':''}">{$vendor->title}</label>
                                    </div>
                                {/foreach}
                            {else}
                                <select name="vendor" id="" class="select">
                                    {foreach from=$shop->vendors item="vendor" name="list"}
                                        {if $smarty.foreach.list.first}
                                            <option value="0">{trans}store_theme_translations.vendor{/trans}</option>
                                        {/if}
                                        <option value="{$vendor->url}">{$vendor->title}</option>
                                    {/foreach}
                                </select>
                            {/if}
                        </div>
                    {/if}
                    <!-- end vendor filter -->

                    <!-- Tags filter -->
                    {if $category->all_tags|count != 0 && $settings->category_1_show_sidebar_filters_tags}
                        <div class="section filter-section filter-tags" data-filter-type="filter-tags">
                            <h4>{trans}store_theme_translations.tags{/trans}:</h4>
                            {foreach from=$category->all_tags item=tag}
                                <div class="control checkbox">
                                    <input id="{$tag|handle}" type="checkbox" name="{$tag|handle}" value="{$tag|handle}"
                                           data-name="" {if $tag|in_array:$category->active_tags} checked="checked"{/if}>
                                    <label for="{$tag|handle}">{$tag}</label>
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                    <!-- end tags filter -->

                    <!-- sort filter -->
                    {if $settings->category_1_show_sidebar_filters_sort}
                        <section class="section filter-section filter-sort" data-filter-type="filter-sort">
                            <h4>{trans}store_theme_translations.sort{/trans}:</h4>
                            <div class="control checkbox">
                                <input id="sort=price" type="checkbox" name="sort=price" value=""
                                       data-name="sort=price">
                                <label for="sort=price">{trans}store_theme_translations.from_cheapest{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=price&order=desc" type="checkbox" name="sort=price&order=desc"
                                       value="sort=price&order=desc" data-name="sort=price&order=desc">
                                <label for="sort=price&order=desc">{trans}store_theme_translations.from_most_expensive{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=title" type="checkbox" name="sort=title" value="sort=title"
                                       data-name="sort=title">
                                <label for="sort=title">{trans}store_theme_translations.filter_by_name{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=title&order=desc" type="checkbox" name="sort=title&order=desc"
                                       value="sort=title&order=desc" data-name="sort=title&order=desc">
                                <label for="sort=title&order=desc">{trans}store_theme_translations.filter_by_name_reverse{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=created_at" type="checkbox" name="sort=created_at"
                                       value="sort=created_at" data-name="sort=created_at">
                                <label for="sort=created_at">{trans}store_theme_translations.filter_newest{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=created_at&order=desc" type="checkbox" name="sort=created_at&order=desc"
                                       value="sort=created_at&order=desc" data-name="sort=created_at&order=desc">
                                <label for="sort=created_at&order=desc">{trans}store_theme_translations.filter_oldest{/trans}</label>
                            </div>
                        </section>
                    {/if}
                    <!-- end sort filter -->

                    <!-- price filter -->
                    {if $settings->category_1_show_sidebar_filters_price}
                        <div class="section col-xs-12 col-sm-12 col-md-12 col-sm-no-pd filter-section filter-price widget_pricefilter">
                            <h4>{trans}store_theme_translations.price{/trans}:</h4>
                            <div class="priceRange" class="content">
                                <div class="padding-range">
                                    <div class="slider-range"></div>
                                </div>
                                <label for="amount-min"></label>
                                <input type="text" class="amount-min push-left"
                                       data-currency="{$shop->currency|replace:'PLN':'zł'}" data-min="{$min_price}"
                                       readonly/>
                                <label for="amount-max"></label>
                                <input type="text" class="amount-max push-right" data-max="{$max_price}" readonly/>
                                <button class="subFilter button btn btn-black push-left" type="submit">OK</button>
                            </div>
                        </div>
                    {/if}
                    <!-- end price filter -->

                    <div class="clear-section section col-xs-12 col-sm-12 col-md-12 col-sm-no-pd">
                        <a href="#"
                           class="clear-all-filters">{trans}store_theme_translations.clear_all_filters{/trans}</a>
                    </div>
                </div>
            </div>
        {/if}
    </div>
{elseif $template == 'collection'}
    <div class="sidebar col-md-3">
        <div class="categories-section{if $settings->collection_1_show_sidebar_subcategories} show-subcategories{/if}">
            {if $settings->collection_1_show_categories_nav}
                <h4>{trans}store_theme_translations.categories{/trans}</h4>
                {$categories->createListView($category->url, 'categories', 'active')}
            {/if}
            {if $settings->collection_1_show_collections_nav}
                <h4>{trans}store_theme_translations.collections{/trans}</h4>
                <ul class="categories">
                    {foreach from=$collections->all item="collection"}
                        <li>
                            <a href="{reverse_url name='shop_collection' collection_name=$collection->url}">{$collection->title}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
            {if $settings->collection_1_show_vendors_nav}
                <h4>{trans}store_theme_translations.vendor{/trans}</h4>
                <ul class="categories">
                    {foreach from=$shop->vendors item="vendor" name="foo"}
                        <li>
                            <a href="{reverse_url name=shop_vendor vendor_name=$vendor->url}">{$vendor->title}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </div>
        {if $settings->collection_1_show_sidebar_filters}
            <div class="filters">
                <a data-toggle="collapse" href="#filtersContent"
                   aria-expanded="{if $filters_active == 1}true{else}false{/if}" aria-controls="filtersContent"
                   id="showFilters"
                   class="btn-gray btn-block {if $filters_active == 0} collapsed{/if}">{trans}store_theme_translations.filter{/trans}
                    <i class="icon-caret-down"></i></a>
                <div id="filtersContent" class="filters-content collapse {if $filters_active == 1}in{/if}">
                    {if $settings->collection_1_show_sidebar_filters_properties}
                        {if $template == 'category'}
                            {foreach from=$category->properties key=name item=props}
                                {assign var="foo" value=sort($props)}
                                {if $settings->filters_handle != 'select'}
                                    <div data-filter-type="filter-property"
                                         class="section filter-section filter-property {if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}colour-mode{/if}">
                                        <h4>{$name|lower}: <span class="icon icon-plus-bold"></span></h4>
                                        <div class="content">
                                            {foreach from=$props item=p}
                                                {if $p == ""}{continue}{/if}
                                                <div class="control checkbox">
                                                    <input id="{$p|replace:' ':''}" type="checkbox"
                                                           name="{$name|replace:' ':''}" value="{$p}"
                                                           data-name="{$name|escape:'url'}"
                                                           data-val="{$p|lower|replace:' ':'_'}">
                                                    <label for="{$p|replace:' ':''}">{if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}
                                                        <span
                                                                style="background: {$pallete[$p|lower|replace:' ':'_']};"
                                                                title="{$p}"></span>{else}{$p}{/if}</label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                {else}
                                    <div class="section filter-section filter-property"
                                         data-filter-type="filter-property">
                                        <h4>{$name|lower}:</h4>
                                        <div class="content">
                                            <select name="{$name|replace:' ':''}" id="" data-name="{$name|escape:'url'}"
                                                    class="select">
                                                {foreach from=$props item=p name=list}
                                                    {if $smarty.foreach.list.first}
                                                        <option value="0">{trans}store_theme_translations.filter{/trans}</option>
                                                    {/if}
                                                    {if $p == ""}{continue}{/if}
                                                    <option value="{$p}"
                                                            data-val="{$p|lower|replace:' ':'_'}">{$p}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        {elseif $template == 'collection'}
                            {foreach from=$collection->properties key=name item=props}
                                {assign var="foo" value=sort($props)}
                                <div class="section filter-section filter-property" data-filter-type="filter-property">
                                    <h4>{$name|lower}:<span class="icon-plus"></span></h4>
                                    <div class="content">
                                        {foreach from=$props item=p}
                                            {if $p == ""}{continue}{/if}
                                            <div class="control checkbox">
                                                <input id="{$p|replace:' ':''}" type="checkbox"
                                                       name="{$name|replace:' ':''}" value="{$p}"
                                                       data-name="{$name|escape:'url'}">
                                                <label for="{$p|replace:' ':''}">{$p}</label>
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                            {/foreach}
                        {/if}
                    {/if}
                    <!-- vendor filter -->
                    {if $shop->vendors|count != 0 && $settings->collection_1_show_sidebar_filters_vendor}
                        <div class="section filter-section filter-vendor" data-filter-type="filter-vendor">
                            <h4>{trans}store_theme_translations.vendor{/trans}:</h4>
                            {if $settings->filters_handle != 'select'}
                                {foreach from=$shop->vendors item="vendor"}
                                    <div class="control checkbox">
                                        <input id="{$vendor->title|replace:' ':''}" type="checkbox" name="vendor"
                                               value="{$vendor->url}">
                                        <label for="{$vendor->title|replace:' ':''}">{$vendor->title}</label>
                                    </div>
                                {/foreach}
                            {else}
                                <select name="vendor" id="" class="select">
                                    {foreach from=$shop->vendors item="vendor" name="list"}
                                        {if $smarty.foreach.list.first}
                                            <option value="0">{trans}store_theme_translations.vendor{/trans}</option>
                                        {/if}
                                        <option value="{$vendor->url}">{$vendor->title}</option>
                                    {/foreach}
                                </select>
                            {/if}
                        </div>
                    {/if}
                    <!-- end vendor filter -->

                    <!-- Tags filter -->
                    {if $category->all_tags|count != 0 && $settings->collection_1_show_sidebar_filters_tags}
                        <div class="section filter-section filter-tags" data-filter-type="filter-tags">
                            <h4>{trans}store_theme_translations.tags{/trans}:</h4>
                            {foreach from=$category->all_tags item=tag}
                                <div class="control checkbox">
                                    <input id="{$tag|handle}" type="checkbox" name="{$tag|handle}" value="{$tag|handle}"
                                           data-name="" {if $tag|in_array:$category->active_tags} checked="checked"{/if}>
                                    <label for="{$tag|handle}">{$tag}</label>
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                    <!-- end tags filter -->

                    <!-- sort filter -->
                    {if $settings->collection_1_show_sidebar_filters_sort}
                        <section class="section filter-section filter-sort" data-filter-type="filter-sort">
                            <h4>{trans}store_theme_translations.sort{/trans}:</h4>
                            <div class="control checkbox">
                                <input id="sort=price" type="checkbox" name="sort=price" value=""
                                       data-name="sort=price">
                                <label for="sort=price">{trans}store_theme_translations.from_cheapest{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=price&order=desc" type="checkbox" name="sort=price&order=desc"
                                       value="sort=price&order=desc" data-name="sort=price&order=desc">
                                <label for="sort=price&order=desc">{trans}store_theme_translations.from_most_expensive{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=title" type="checkbox" name="sort=title" value="sort=title"
                                       data-name="sort=title">
                                <label for="sort=title">{trans}store_theme_translations.filter_by_name{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=title&order=desc" type="checkbox" name="sort=title&order=desc"
                                       value="sort=title&order=desc" data-name="sort=title&order=desc">
                                <label for="sort=title&order=desc">{trans}store_theme_translations.filter_by_name_reverse{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=created_at" type="checkbox" name="sort=created_at"
                                       value="sort=created_at" data-name="sort=created_at">
                                <label for="sort=created_at">{trans}store_theme_translations.filter_newest{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=created_at&order=desc" type="checkbox" name="sort=created_at&order=desc"
                                       value="sort=created_at&order=desc" data-name="sort=created_at&order=desc">
                                <label for="sort=created_at&order=desc">{trans}store_theme_translations.filter_oldest{/trans}</label>
                            </div>
                        </section>
                    {/if}
                    <!-- end sort filter -->

                    <!-- price filter -->
                    {if $settings->collection_1_show_sidebar_filters_price}
                        <div class="section col-xs-12 col-sm-12 col-md-12 col-sm-no-pd filter-section filter-price widget_pricefilter">
                            <h4>{trans}store_theme_translations.price{/trans}:</h4>
                            <div class="priceRange" class="content">
                                <div class="padding-range">
                                    <div class="slider-range"></div>
                                </div>
                                <label for="amount-min"></label>
                                <input type="text" class="amount-min push-left"
                                       data-currency="{$shop->currency|replace:'PLN':'zł'}" data-min="{$min_price}"
                                       readonly/>
                                <label for="amount-max"></label>
                                <input type="text" class="amount-max push-right" data-max="{$max_price}" readonly/>
                                <button class="subFilter button btn btn-black push-left" type="submit">OK</button>
                            </div>
                        </div>
                    {/if}
                    <!-- end price filter -->

                    <div class="clear-section section col-xs-12 col-sm-12 col-md-12 col-sm-no-pd">
                        <a href="#"
                           class="clear-all-filters">{trans}store_theme_translations.clear_all_filters{/trans}</a>
                    </div>
                </div>
            </div>
        {/if}
    </div>
{elseif $template == 'vendor'}
    <div class="sidebar col-md-3">
        <div class="categories-section{if $settings->vendor_1_show_sidebar_subcategories} show-subcategories{/if}">
            {if $settings->vendor_1_show_categories_nav}
                <h4>{trans}store_theme_translations.categories{/trans}</h4>
                {$categories->createListView($vendor->url, 'categories', 'active')}
            {/if}
            {if $settings->vendor_1_show_collections_nav}
                <h4>{trans}store_theme_translations.collections{/trans}</h4>
                <ul class="categories">
                    {foreach from=$collections->all item="collection"}
                        <li>
                            <a href="{reverse_url name='shop_collection' collection_name=$collection->url}">{$collection->title}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
            {if $settings->vendor_1_show_vendors_nav}
                <h4>{trans}store_theme_translations.vendor{/trans}</h4>
                <ul class="categories">
                    {foreach from=$shop->vendors item="vendor" name="foo"}
                        <li>
                            <a href="{reverse_url name=shop_vendor vendor_name=$vendor->url}">{$vendor->title}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </div>
        {if $settings->vendor_1_show_sidebar_filters}
            <div class="filters">
                <a data-toggle="collapse" href="#filtersContent"
                   aria-expanded="{if $filters_active == 1}true{else}false{/if}" aria-controls="filtersContent"
                   id="showFilters"
                   class="btn-gray btn-block {if $filters_active == 0} collapsed{/if}">{trans}store_theme_translations.filter{/trans}
                    <i class="icon-caret-down"></i></a>
                <div id="filtersContent" class="filters-content collapse {if $filters_active == 1}in{/if}">
                    {if $settings->vendor_1_show_sidebar_filters_properties}
                        {if $template == 'category'}
                            {foreach from=$category->properties key=name item=props}
                                {assign var="foo" value=sort($props)}
                                {if $settings->filters_handle != 'select'}
                                    <div data-filter-type="filter-property"
                                         class="section filter-section filter-property {if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}colour-mode{/if}">
                                        <h4>{$name|lower}: <span class="icon icon-plus-bold"></span></h4>
                                        <div class="content">
                                            {foreach from=$props item=p}
                                                {if $p == ""}{continue}{/if}
                                                <div class="control checkbox">
                                                    <input id="{$p|replace:' ':''}" type="checkbox"
                                                           name="{$name|replace:' ':''}" value="{$p}"
                                                           data-name="{$name|escape:'url'}"
                                                           data-val="{$p|lower|replace:' ':'_'}">
                                                    <label for="{$p|replace:' ':''}">{if $name|escape:'url'|lower == 'kolor' || $name|escape:'url'|lower == 'color' || $name|escape:'url'|lower == 'colour'}
                                                        <span
                                                                style="background: {$pallete[$p|lower|replace:' ':'_']};"
                                                                title="{$p}"></span>{else}{$p}{/if}</label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                {else}
                                    <div class="section filter-section filter-property"
                                         data-filter-type="filter-property">
                                        <h4>{$name|lower}:</h4>
                                        <div class="content">
                                            <select name="{$name|replace:' ':''}" id="" data-name="{$name|escape:'url'}"
                                                    class="select">
                                                {foreach from=$props item=p name=list}
                                                    {if $smarty.foreach.list.first}
                                                        <option value="0">{trans}store_theme_translations.filter{/trans}</option>
                                                    {/if}
                                                    {if $p == ""}{continue}{/if}
                                                    <option value="{$p}"
                                                            data-val="{$p|lower|replace:' ':'_'}">{$p}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        {elseif $template == 'collection'}
                            {foreach from=$collection->properties key=name item=props}
                                {assign var="foo" value=sort($props)}
                                <div class="section filter-section filter-property" data-filter-type="filter-property">
                                    <h4>{$name|lower}:<span class="icon-plus"></span></h4>
                                    <div class="content">
                                        {foreach from=$props item=p}
                                            {if $p == ""}{continue}{/if}
                                            <div class="control checkbox">
                                                <input id="{$p|replace:' ':''}" type="checkbox"
                                                       name="{$name|replace:' ':''}" value="{$p}"
                                                       data-name="{$name|escape:'url'}">
                                                <label for="{$p|replace:' ':''}">{$p}</label>
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                            {/foreach}
                        {/if}
                    {/if}
                    <!-- vendor filter -->
                    {if $shop->vendors|count != 0 && $settings->vendor_1_show_sidebar_filters_vendor}
                        <div class="section filter-section filter-vendor" data-filter-type="filter-vendor">
                            <h4>{trans}store_theme_translations.vendor{/trans}:</h4>
                            {if $settings->filters_handle != 'select'}
                                {foreach from=$shop->vendors item="vendor"}
                                    <div class="control checkbox">
                                        <input id="{$vendor->title|replace:' ':''}" type="checkbox" name="vendor"
                                               value="{$vendor->url}">
                                        <label for="{$vendor->title|replace:' ':''}">{$vendor->title}</label>
                                    </div>
                                {/foreach}
                            {else}
                                <select name="vendor" id="" class="select">
                                    {foreach from=$shop->vendors item="vendor" name="list"}
                                        {if $smarty.foreach.list.first}
                                            <option value="0">{trans}store_theme_translations.vendor{/trans}</option>
                                        {/if}
                                        <option value="{$vendor->url}">{$vendor->title}</option>
                                    {/foreach}
                                </select>
                            {/if}
                        </div>
                    {/if}
                    <!-- end vendor filter -->

                    <!-- Tags filter -->
                    {if $category->all_tags|count != 0 && $settings->vendor_1_show_sidebar_filters_tags}
                        <div class="section filter-section filter-tags" data-filter-type="filter-tags">
                            <h4>{trans}store_theme_translations.tags{/trans}:</h4>
                            {foreach from=$category->all_tags item=tag}
                                <div class="control checkbox">
                                    <input id="{$tag|handle}" type="checkbox" name="{$tag|handle}" value="{$tag|handle}"
                                           data-name="" {if $tag|in_array:$category->active_tags} checked="checked"{/if}>
                                    <label for="{$tag|handle}">{$tag}</label>
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                    <!-- end tags filter -->

                    <!-- sort filter -->
                    {if $settings->vendor_1_show_sidebar_filters_sort}
                        <section class="section filter-section filter-sort" data-filter-type="filter-sort">
                            <h4>{trans}store_theme_translations.sort{/trans}:</h4>
                            <div class="control checkbox">
                                <input id="sort=price" type="checkbox" name="sort=price" value=""
                                       data-name="sort=price">
                                <label for="sort=price">{trans}store_theme_translations.from_cheapest{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=price&order=desc" type="checkbox" name="sort=price&order=desc"
                                       value="sort=price&order=desc" data-name="sort=price&order=desc">
                                <label for="sort=price&order=desc">{trans}store_theme_translations.from_most_expensive{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=title" type="checkbox" name="sort=title" value="sort=title"
                                       data-name="sort=title">
                                <label for="sort=title">{trans}store_theme_translations.filter_by_name{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=title&order=desc" type="checkbox" name="sort=title&order=desc"
                                       value="sort=title&order=desc" data-name="sort=title&order=desc">
                                <label for="sort=title&order=desc">{trans}store_theme_translations.filter_by_name_reverse{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=created_at" type="checkbox" name="sort=created_at"
                                       value="sort=created_at" data-name="sort=created_at">
                                <label for="sort=created_at">{trans}store_theme_translations.filter_newest{/trans}</label>
                            </div>
                            <div class="control checkbox">
                                <input id="sort=created_at&order=desc" type="checkbox" name="sort=created_at&order=desc"
                                       value="sort=created_at&order=desc" data-name="sort=created_at&order=desc">
                                <label for="sort=created_at&order=desc">{trans}store_theme_translations.filter_oldest{/trans}</label>
                            </div>
                        </section>
                    {/if}
                    <!-- end sort filter -->

                    <!-- price filter -->
                    {if $settings->vendor_1_show_sidebar_filters_price}
                        <div class="section col-xs-12 col-sm-12 col-md-12 col-sm-no-pd filter-section filter-price widget_pricefilter">
                            <h4>{trans}store_theme_translations.price{/trans}:</h4>
                            <div class="priceRange" class="content">
                                <div class="padding-range">
                                    <div class="slider-range"></div>
                                </div>
                                <label for="amount-min"></label>
                                <input type="text" class="amount-min push-left"
                                       data-currency="{$shop->currency|replace:'PLN':'zł'}" data-min="{$min_price}"
                                       readonly/>
                                <label for="amount-max"></label>
                                <input type="text" class="amount-max push-right" data-max="{$max_price}" readonly/>
                                <button class="subFilter button btn btn-black push-left" type="submit">OK</button>
                            </div>
                        </div>
                    {/if}
                    <!-- end price filter -->

                    <div class="clear-section section col-xs-12 col-sm-12 col-md-12 col-sm-no-pd">
                        <a href="#"
                           class="clear-all-filters">{trans}store_theme_translations.clear_all_filters{/trans}</a>
                    </div>
                </div>
            </div>
        {/if}
    </div>
{elseif $template == 'home'}
    <div class="sidebar col-md-3">
        <div class="categories-section{if $home_show_sidebar_subcategories} show-subcategories{/if}">
            {if home_show_categories_nav}
                <h4>{trans}store_theme_translations.categories{/trans}</h4>
                {$categories->createListView($categories->url, 'categories', 'active')}
            {/if}
            {if $home_show_collections_nav}
                <h4>{trans}store_theme_translations.collections{/trans}</h4>
                <ul class="categories">
                    {foreach from=$collections->all item="collection"}
                        <li>
                            <a href="{reverse_url name='shop_collection' collection_name=$collection->url}">{$collection->title}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
            {if $home_show_vendors_nav}
                <h4>{trans}store_theme_translations.vendor{/trans}</h4>
                <ul class="categories">
                    {foreach from=$shop->vendors item="vendor" name="foo"}
                        <li>
                            <a href="{reverse_url name=shop_vendor vendor_name=$vendor->url}">{$vendor->title}</a>
                        </li>
                    {/foreach}
                </ul>
            {/if}
        </div>
    </div>
{/if}