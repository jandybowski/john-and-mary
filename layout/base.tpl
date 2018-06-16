<!DOCTYPE html>
<html lang="pl" xmlns="http://www.w3.org/1999/xhtml">
<head itemscope itemtype="http://schema.org/WebSite">
	<!-- META DATA -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Language" content="pl" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
	<title>{if isset($meta)}{$meta->title}{else}{$shop->name}{/if}</title>
	{if isset($meta)}<meta name="description" content="{$meta->description}" />{/if}
	{if isset($meta)}<meta name="keywords" content="{$meta->keywords}" />{/if}
	<!-- END META DATA -->

	<!-- FACEBOOK OG DATA -->
	{if $template == 'home'}
		<meta property="og:title" itemprop='name' content="{$shop->name}" />
		<meta property="og:type" content="website" />
		<meta property="og:url" itemprop="url" content="{$shop->domain}" />
		<meta property="og:image" content="{"logo.png"|asset_url}" alt="{$shop->name}" />
		<meta property="og:site_name" content="{$shop->name}" />
	{/if}
	{if $template == 'product'}
		<meta property="og:title" itemprop='name' content="{$product->name}" />
		<meta property="og:type" content="website" />
		<meta property="og:url" itemprop="url" content="{reverse_url name='shop_product' product_name=$product->url}" />
		<meta property="og:image" content="{$product->main_image|product_img_url:th160}" alt="{$product->name}" />
		<meta property="og:description" content="{$product->short_description}" />
		<meta property="og:site_name" content="{$shop->name}" />
		{if isset($category) || isset($collection)}
			<link rel="canonical" href="{reverse_url name=shop_product product_name=$product->url}" />
		{/if}
	{/if}
	{if $template == 'collection'}
		{assign prod $collection->products[0]}
		<meta property="og:title" itemprop='name' content="{$collection->title}" />
		<meta property="og:type" content="website" />
		<meta property="og:url" itemprop="url" content="{reverse_url name='shop_collection' collection_name=$collection->url}" />
		<meta property="og:image" content="{$collection->image|collection_img_url:th640}" />
		<meta property="og:description" content="{$collection->description|strip_tags|escape}" />
		<meta property="og:site_name" content="{$shop->name}" />
	{/if}
	{if $template == 'category'}
		<meta property="og:title" itemprop='name' content="{$category->title}" />
		<meta property="og:type" content="website" />
		<meta property="og:url" itemprop="url" content="{reverse_url name='shop_category' category_name=$category->url}" />
		<meta property="og:image" content="{$category->image|category_img_url:th640}" />
		<meta property="og:description" content="{$category->description|strip_tags|escape}" />
		<meta property="og:site_name" content="{$shop->name}" />
	{/if}
	<!-- END FACEBOOK OG DATA -->

	<link rel="shortcut icon" type="image/png" href='{"favicon.png"|asset_url}' />
	
	<link href="https://fonts.googleapis.com/css?family=Cormorant+Garamond:400,400i&amp;subset=latin-ext" rel="stylesheet">

	{if $settings->font_headers == "'Lato', Helvetica, Arial, sans-serif" || $settings->font_default == "'Lato', Helvetica, Arial, sans-serif"}
	<link href='https://fonts.googleapis.com/css?family=Lato:400,300,700&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
	{/if}
	{if $settings->font_headers == "'Roboto', Helvetica, Arial, sans-serif" || $settings->font_default == "'Roboto', Helvetica, Arial, sans-serif"}
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,300,500,700&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
	{/if}
	{if $settings->font_headers == "'Open Sans', Helvetica, Arial, sans-serif" || $settings->font_default == "'Open Sans', Helvetica, Arial, sans-serif"}
	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
	{/if}
	{if $settings->font_headers == "'Slabo 13px', Helvetica, Arial, sans-serif" || $settings->font_default == "'Slabo 13px', Helvetica, Arial, sans-serif"}
	<link href='https://fonts.googleapis.com/css?family=Slabo+13px&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
	{/if}
	{"layout.css"|asset_url:stylesheet_tag}
	{"style.css"|asset_url:stylesheet_tag}
	{"jm-shoplo-theme.css"|asset_url:stylesheet_tag}
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
	{head_content}
</head>
<body id="page-{$template}" class="{if isset($collection)}{$collection->url}{/if}{if isset($category)}{$category->url}{/if} {if $settings->use_bg_image} bg-img{/if}">
{if $template != 'cart' && $settings->show_sliding_cart_widget}
	<div class="curtain"></div>
{/if}
{if $settings->use_sliding_mobile_menu == '1'}
<div id="page">
{/if}
<div id="shopNotyfication" class="{if $messages.success} success{elseif $messages.error} error{/if}">
	<div class="container">
		<div class="row">
			<div id="shopMessage" class="col-sm-12 col-sm-no-pd">
				{if isset($messages) && $messages.success || isset($messages) && $messages.error}
					{if $messages.success}
						<p class="success">{$messages.success}</p>
					{elseif $messages.error}
						<p class="error">{$messages.error}</p>
					{/if}
				{/if}
			</div>
		</div>
	</div>
</div>

<header class="header-10 {if $settings->use_banner_only_on_homepage && $template != 'home'}not-absolute{/if} {if $settings->fixed_header == 1} sticky-bar sticky-after-this{/if}">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                {snippet file="main_nav"}
            </div>
            <!--
			<div class="header_right col-xs-12 col-sm-12 col-md-12 col-xl-3 sm-hide">
                <div class="cartWidget">
                    {if $template != 'cart'}
                    {if $settings->show_sliding_cart_widget}
                    <a href="#" class="cart-widget-trigger">
                        {else}
                        <a href="{reverse_url name='shop_cart'}">
                            {/if}
                            {else}
                            <span class="cart-widget-icon">
					{/if}
                                <span class="cart-widget-total-count">{$cart->item_count}</span>
						<i class="icon-cart"></i>
                                {if $template != 'cart'}
                        </a>
                        {else}
                        </span>
                        {/if}
                </div>
                {if $shop->customer_accounts_enabled}
                    <div class="userWidget">
                        {if $customer}
                            <a href="{reverse_url name=shop_client_orders}"><i class="icon-account"></i></a>
                        {else}
                            <a href="{reverse_url name=shop_client_login}"><i class="icon-account"></i></a>
                        {/if}
                    </div>
                {/if}
                {if $settings->lang_switcher}
                    <div class="langWidget">
                        <select class="select select-small" name="lang" tabindex="0">
                            <option value="{$settings->lang_switcher_1_url}">{$settings->lang_switcher_1_title}</option>
                            <option value="{$settings->lang_switcher_2_url}">{$settings->lang_switcher_2_title}</option>
                        </select>
                    </div>
                {/if}
                {if $shop->currencies && ($shop->currencies|count > 1)}
                    <div class="currencyWidget">
                        <select class="select select-small" name="currency" tabindex="0">
                            {foreach from=$shop->currencies item=currency}
                                <option value="{$currency->currency_code}"{if $currency->currency_code == $shop->currency_code}selected="selected"{/if}>{$currency->currency_code}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
            </div>-->
        </div>
    </div>
</header>
{if $settings->use_banner_only_on_homepage}
    {if $template == "home"}
        <div class="banner-27 section-slider">
            <div class="container-full">
                <div class="row">
                    {if $banners->{$settings->banner_choose_banner_27}->items|count > 0}
                        <div class="slider-loader dots-loader">
                            <div class="dot"></div>
                            <div class="dot"></div>
                            <div class="dot"></div>
                        </div>
                        <div class="col-xs-12 slider-wrapper">
                            <div class="slider">
                                <ul class="slides" data-auto="{$settings->banner_choose_banner_27}">
                                    {foreach from=$banners->{$settings->banner_choose_banner_27}->items item="banner" name="banner_list"}
                                        <li data-duration="{$banner->duration}">
											{if {$banner->text} != 'nolink'}
                                            	<a href="{$banner->url}">
											{/if}
													<figure>
														<img src="{$banner->image}?{$banner->id}" alt="{$banner->title}" />
													</figure>
                                            {if {$banner->text} != 'nolink'}
												</a>
											{/if}
                                        </li>
                                    {/foreach}
                                </ul>
                            </div>
                        </div>
                    {else}
                        <div class="col-xs-12 slider-wrapper blankslate-banner">
                            <a href="/admin/layout/banner">
                                <figure>
                                    <img src="https://placeholdit.imgix.net/~text?txtsize=33&txt=1920%C3%97950&w=1920&h=950"
                                         alt=""/>
                                </figure>
                            </a>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    {/if}

{/if}


{$page_content}


{if $settings->use_sliding_mobile_menu == '1'}
</div>
{/if}

{if $template != 'cart' && $settings->show_sliding_cart_widget}
	{if $settings->cart_widget_type == 'right'}
		{snippet file="cart_widget_right"}
	{elseif $settings->cart_widget_type == 'top'}
		{snippet file="cart_widget_top"}
	{elseif $settings->cart_widget_type == 'bottom'}
		{snippet file="cart_widget_bottom"}
	{/if}
{/if}
{if $settings->use_sliding_mobile_menu == '1'}
	{"mmenu.js"|asset_url:script_tag}
	{snippet file="mobile_menu"}
{/if}

<script type="text/javascript">
	/*<![CDATA[*/
	{if !$is_https}
	var ROOT = "{$ROOT}";
	{else}
	var ROOT = "{$ROOT|replace:'http':'https'}";
	{/if}
	var AUTH = "{$token}";
	/*]]>*/
</script>
<script type="text/javascript" src="/js/storefront!currency-4363199.js"></script>

<script>
var useDynamicCart = '{$settings->show_sliding_cart_widget}',
	dynamicCartType = '{$settings->cart_widget_type}',
	cart_free_delivery_info = '{trans}store_theme_translations.cart_free_delivery_info{/trans}',
    cart_free_delivery_price = '{$settings->cart_free_delivery_price_form}',
	{if $settings->show_cart_free_delivery}
    cart_free_delivery_show = true,
	{else}
	cart_free_delivery_show = false,
	{/if}
	{if $settings->show_cart_default_delivery_cost}
    cart_delivery_cost_show = true,
	{else}
	cart_delivery_cost_show = false,
	{/if}
    cart_delivery_info_show = '{$settings->show_cart_default_delivery_info}',
    cart_delivery_cost = '{$settings->cart_default_delivery_cost|floatval}';
</script>
<script>
	window.REMODAL_GLOBALS = {
	  NAMESPACE: 'theme-modal',
	  DEFAULTS: {
	    hashTracking: true
	  }
	};
</script>
{"plugins.js"|asset_url:script_tag}
{"bootstrap.js"|asset_url:script_tag}
{"main.js"|asset_url:script_tag}
{"cart.js"|asset_url:script_tag}
{"shoploAJAX.js"|asset_url:script_tag}

{if $template == 'product'}
	{"variants.js"|asset_url:script_tag}
{elseif $template == 'category' || $template == 'collection' || $template == 'vendor'}
	{"filters.js"|asset_url:script_tag}
{/if}

<!--modern-layout-->

<!-- Place this tag in your head or just before your close body tag. -->

{"header_10.js"|asset_url:script_tag}
{"product_2.js"|asset_url:script_tag}
</body>
</html>
