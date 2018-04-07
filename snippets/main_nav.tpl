{assign "langletters" array('ą', 'ć', 'ę', 'ł', 'ś', 'ó', 'ż', 'ź', 'ń', ' ')}
{assign "letters" array('a', 'c', 'e', 'l', 's', 'o', 'z', 'z', 'n', '_')}
<div id="mobileNav" class="sm-show row">
  <div class="{if !$shop->customer_accounts_enabled}col-xs-6{else}col-xs-3 col-xs-offset-1{/if} align-center">
    <a href="#mobileMenu" id="navToggle"><i class="icon icon-bars"></i></a>
  </div>
  {if $shop->customer_accounts_enabled}
  <div class="col-xs-4 align-center">
    <a href="{reverse_url name=shop_client_login}"><i class="icon-account"></i></a>
  </div>
  {/if}
  <div class="{if !$shop->customer_accounts_enabled}col-xs-6{else}col-xs-3{/if} align-center cart-widget-mobile">
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
</div>
<nav id="mainNav" class="sm-hide">
  <ul class="col-xs-12 nav nav-inline nav-centered">
    {foreach from=$menulists->main_menu->links item="menu"}
      <li class="nav-item{if $template == 'category' && $category->title == $menu->title} active
      {elseif $template == 'collection' && ($menu->url|strpos:$collection->url !== false)} active
      {elseif $template == 'list_categories' && 'Kategorie' == $menu->title} active
      {elseif isset($page) and $page->url == $menu->url} active
      {elseif isset($product) and $product_url == $menu->url} active
      {elseif $template == 'home'}{if $menu->url == '/'} active{/if}{/if}">
      <a href="{$menu->url}">{$menu->title}</a>
        {if $menulists->{$menu->title|lower|replace:$langletters:$letters}->links|count > 0}
          <ul class="submenu">
            {foreach $menulists->{$menu->title|lower|replace:$langletters:$letters}->links item="submenu"}
              <li><a href="{$submenu->url}">{$submenu->title}</a></li>
            {/foreach}
          </ul>
        {/if}
    </li>
    {/foreach}
  </ul>
</nav>
