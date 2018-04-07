<!-- BREADCRUMB -->
{if isset($collection) || isset($category) || isset($vendor)}
<div class="">
        <div class="col-xs-12">
        {if isset($collection)}
            <ul class="breadcrumbs" vocab="http://schema.org/" typeof="BreadcrumbList">
                <li property="itemListElement" typeof="ListItem">
                    <a property="item" typeof="WebPage" href="{reverse_url name=shop_home}">{trans}store_theme_translations.shop{/trans}</a><span class="break">&raquo;</span>
                    <meta property="position" content="1">
                </li>
                <li property="itemListElement" typeof="ListItem">
                    <a property="item" typeof="WebPage" href="{reverse_url name=shop_collection collection_name=$collection->url}">{$collection->title|ucfirst}</a>
                    <meta property="position" content="2">
                </li>
                {if $template=='product'}
                <li>
                    <span class="break">&raquo;</span><span>{$product->name|truncate:40}</span>
                </li>
                {/if}
            </ul>
        {elseif isset($category)}
            <ul class="breadcrumbs" {if $template != 'list_categories'}vocab="http://schema.org/" typeof="BreadcrumbList"{/if}>
                <li property="itemListElement" typeof="ListItem">
                    <a property="item" typeof="WebPage" href="{reverse_url name=shop_home}">{trans}store_theme_translations.shop{/trans}</a><span class="break">&raquo;</span>
                    <meta property="position" content="1">
                </li>
                <li property="itemListElement" typeof="ListItem">
                    <a property="item" typeof="WebPage" href="{reverse_url name=shop_category category_name=$category->url}">{$category->title|ucfirst}</a>
                    <meta property="position" content="2">
                </li>
                {if $template=='product'}
                <li>
                    <span class="break">&raquo;</span><span>{$product->name|truncate:40}</span>
                </li>
                {/if}
            </ul>
        {elseif isset($vendor)}
            <ul class="breadcrumbs" vocab="http://schema.org/" typeof="BreadcrumbList">
                <li property="itemListElement" typeof="ListItem">
                    <a property="item" typeof="WebPage" href="{reverse_url name=shop_home}">{trans}store_theme_translations.shop{/trans}</a><span class="break">&raquo;</span>
                    <meta property="position" content="1">
                </li>
                <li property="itemListElement" typeof="ListItem">
                    <a property="item" typeof="WebPage" href="{reverse_url name=shop_vendor vendor_name=$vendor->url}">{$vendor->title|ucfirst}</a>
                    <meta property="position" content="2">
                </li>
                {if $template=='product'}
                <li>
                    <span class="break">&raquo;</span><span>{$product->name|truncate:40}</span>
                </li>
                {/if}
            </ul>
        {else}
            <ul class="breadcrumbs" vocab="http://schema.org/" typeof="BreadcrumbList">
                <li property="itemListElement" typeof="ListItem">
                    <a property="item" typeof="WebPage" href="{reverse_url name=shop_home}">{trans}store_theme_translations.shop{/trans}</a><span class="break">&raquo;</span>
                    <meta property="position" content="1">
                </li>
                <li>
                    <span>{$product->name|truncate:40}</span>
                </li>
            </ul>
        {/if}
    </div>
</div>
{/if}
{if $template == 'article'}
<div class="row">
    <div class="col-xs-12">
        <ul class="breadcrumbs" vocab="http://schema.org/" typeof="BreadcrumbList">
            <li property="itemListElement" typeof="ListItem">
                <a property="item" typeof="WebPage" href="{reverse_url name=shop_home}">{trans}store_theme_translations.shop{/trans}</a><span class="break">&raquo;</span>
                <meta property="position" content="1">
            </li>
            <li property="itemListElement" typeof="ListItem">
                <a property="item" typeof="WebPage" href="{reverse_url name=shop_blog blog_url=$blog->url}">{$blog->title|ucfirst}</a>
                <meta property="position" content="2">
            </li>
            <li>
                <span class="break">&raquo;</span><span>{$article->title}</span>
            </li>
        </ul>
    </div>
</div>
{elseif $template == 'blog'}
<div class="row">
    <div class="col-xs-12">
        <ul class="breadcrumbs" vocab="http://schema.org/" typeof="BreadcrumbList">
            <li property="itemListElement" typeof="ListItem">
                <a property="item" typeof="WebPage" href="{reverse_url name=shop_home}">{trans}store_theme_translations.shop{/trans}</a><span class="break">&raquo;</span>
                <meta property="position" content="1">
            </li>
            <li property="itemListElement" typeof="ListItem">
                <a property="item" typeof="WebPage" href="{reverse_url name=shop_blog blog_url=$blog->url}">{$blog->title|ucfirst}</a>
                <meta property="position" content="2">
            </li>
        </ul>
    </div>
</div>
{/if}
