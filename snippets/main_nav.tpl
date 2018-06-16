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
  <ul class="row list-unstyled">
    <li class="col-md-4 jm-nav__group">
      <ul class="nav nav-inline nav-centered jm-nav">
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
    </li>
    <li class="col-md-4 nav-item jm-nav__logo-item">
      <a href="{$ROOT}/">
        <svg class="jm-nav__logo-image">
          <use href="#logotype" />
        </svg>
      </a>
    </li>
    <li class="col-md-4 jm-nav__group">
      <ul class="nav nav-inline nav-centered jm-nav jm-nav_right">
        {foreach from=$menulists->secondary_menu->links item="menu"}
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
        <li class="nav-item">
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
        </li>
      </ul>
    </li>
  </ul>
</nav>

<div hidden>
	<svg xmlns="http://www.w3.org/2000/svg">
		<defs>
			<symbol id="logotype" viewBox="0 10 222 36.75">
				<title>John &amp; Mary</title>
				<path d="M17.16,20.94a9.45,9.45,0,0,1-.37,2.76,5.8,5.8,0,0,1-1.13,2.11,5,5,0,0,1-1.89,1.36,6.84,6.84,0,0,1-2.65.47,11.32,11.32,0,0,1-1.36-.08,12.75,12.75,0,0,1-1.41-.26l.1-1.1.1-1.1a.75.75,0,0,1,.24-.48.82.82,0,0,1,.57-.18,2.59,2.59,0,0,1,.54.08,3.79,3.79,0,0,0,.82.08,3.34,3.34,0,0,0,1.17-.19,1.91,1.91,0,0,0,.84-.61,2.86,2.86,0,0,0,.51-1.11A7,7,0,0,0,13.41,21V9.31h3.75Z"/>
				<path d="M43.31,18.37a10,10,0,0,1-.67,3.69A8.63,8.63,0,0,1,40.75,25a8.73,8.73,0,0,1-2.93,1.94,10.58,10.58,0,0,1-7.6,0A8.8,8.8,0,0,1,27.28,25a8.58,8.58,0,0,1-1.89-2.94,10,10,0,0,1-.67-3.69,9.94,9.94,0,0,1,.67-3.68,8.61,8.61,0,0,1,1.89-2.93,8.8,8.8,0,0,1,2.94-1.94,10.58,10.58,0,0,1,7.6,0,8.56,8.56,0,0,1,4.82,4.89A9.9,9.9,0,0,1,43.31,18.37Zm-3.84,0a8.1,8.1,0,0,0-.37-2.56A5.42,5.42,0,0,0,38,13.89a4.66,4.66,0,0,0-1.71-1.21,6.44,6.44,0,0,0-4.57,0A4.64,4.64,0,0,0,30,13.89a5.42,5.42,0,0,0-1.08,1.92,8.1,8.1,0,0,0-.37,2.56,8.15,8.15,0,0,0,.38,2.57A5.36,5.36,0,0,0,30,22.86a4.68,4.68,0,0,0,1.72,1.21,6.44,6.44,0,0,0,4.57,0A4.7,4.7,0,0,0,38,22.86a5.36,5.36,0,0,0,1.08-1.92A8.15,8.15,0,0,0,39.47,18.37Z"/>
				<path d="M66.59,9.31V27.44H62.82V19.63h-8v7.81H51.06V9.31h3.77V17h8V9.31Z"/>
				<path d="M90.93,9.31V27.44H89a1.7,1.7,0,0,1-.74-.14,1.78,1.78,0,0,1-.59-.49l-9-11.5c0,.29,0,.58.06.86s0,.55,0,.79V27.44H75.39V9.31h2l.41,0a.9.9,0,0,1,.31.09,1.2,1.2,0,0,1,.26.18,2.48,2.48,0,0,1,.28.3l9.1,11.55q0-.47-.07-.92c0-.3,0-.58,0-.84V9.31Z"/>
				<path d="M117.39,27.44h-1.11a1.15,1.15,0,0,1-.37,0,1,1,0,0,1-.33-.22L113,24.66a9,9,0,0,1-1.22,1.19,8.36,8.36,0,0,1-1.46.94,8,8,0,0,1-1.69.63,7.78,7.78,0,0,1-1.89.22,5.68,5.68,0,0,1-1.85-.31,5,5,0,0,1-1.63-.92,4.67,4.67,0,0,1-1.16-1.49,4.4,4.4,0,0,1-.44-2A4.61,4.61,0,0,1,102,21.2a5.57,5.57,0,0,1,.89-1.5,6.6,6.6,0,0,1,1.34-1.22,7.63,7.63,0,0,1,1.67-.87,8.28,8.28,0,0,1-1.34-2,4.71,4.71,0,0,1-.44-2,4.06,4.06,0,0,1,.32-1.62,3.8,3.8,0,0,1,.91-1.29,4.25,4.25,0,0,1,1.41-.86,5.11,5.11,0,0,1,1.83-.31,4.4,4.4,0,0,1,1.59.29,4.3,4.3,0,0,1,1.31.77,3.81,3.81,0,0,1,.89,1.13,3.15,3.15,0,0,1,.36,1.34l-.67.14a.3.3,0,0,1-.23,0,.46.46,0,0,1-.17-.24,3.07,3.07,0,0,0-.27-.76,3,3,0,0,0-.58-.8,3.21,3.21,0,0,0-.93-.63,3,3,0,0,0-1.29-.26,3.83,3.83,0,0,0-1.36.23,3.06,3.06,0,0,0-1,.65,3,3,0,0,0-.68,1,3.21,3.21,0,0,0-.24,1.26,4,4,0,0,0,.53,2,9.23,9.23,0,0,0,1.63,2L113,23.09a8.8,8.8,0,0,0,.89-1.87,9,9,0,0,0,.43-1.88.54.54,0,0,1,.1-.26.27.27,0,0,1,.22-.09h.69a8.2,8.2,0,0,1-.44,2.42,9.56,9.56,0,0,1-1.19,2.38Zm-10.92-9.22A7.08,7.08,0,0,0,105,19a5.51,5.51,0,0,0-1.13,1.09,4.77,4.77,0,0,0-.71,1.29,4.13,4.13,0,0,0-.25,1.42,3.59,3.59,0,0,0,.37,1.67,3.74,3.74,0,0,0,1,1.19,4,4,0,0,0,1.31.72,4.47,4.47,0,0,0,1.42.24,6.73,6.73,0,0,0,1.67-.2,6.64,6.64,0,0,0,2.71-1.41,8.06,8.06,0,0,0,1-1.07l-5.74-5.64Z"/>
				<path d="M147.19,9.31V27.44h-3.31V16.31q0-.35,0-.75t.07-.81l-5.19,9.84a1.39,1.39,0,0,1-1.31.81h-.52a1.4,1.4,0,0,1-1.31-.81l-5.21-9.87q0,.44.06.84c0,.27,0,.52,0,.76V27.44h-3.31V9.31h3.27a1.1,1.1,0,0,1,.33.07.77.77,0,0,1,.26.17,1.4,1.4,0,0,1,.23.33l5.08,9.67q.24.44.44.9t.39,1c.13-.33.26-.66.39-1s.29-.62.44-.91l5-9.64a1.28,1.28,0,0,1,.24-.33.83.83,0,0,1,.27-.17,1.09,1.09,0,0,1,.33-.07h3.28Z"/>
				<path d="M171.86,27.44h-2.91a1.28,1.28,0,0,1-.79-.23,1.4,1.4,0,0,1-.46-.59l-1.22-3.46h-7.23L158,26.62a1.42,1.42,0,0,1-.44.57,1.2,1.2,0,0,1-.79.26h-2.94l7.09-18.14h3.84Zm-6.3-6.89-2-5.55q-.18-.44-.37-1t-.37-1.27q-.18.7-.37,1.29t-.37,1l-1.95,5.52Z"/>
				<path d="M193,27.44h-3.39a1.47,1.47,0,0,1-1.37-.72l-3.45-5.56a1.48,1.48,0,0,0-.47-.48,1.53,1.53,0,0,0-.76-.15h-1.27v6.91h-3.75V9.31h5.7a11.7,11.7,0,0,1,3.25.39,6.24,6.24,0,0,1,2.21,1.09A4.19,4.19,0,0,1,191,12.46a5.53,5.53,0,0,1,.4,2.13,5.6,5.6,0,0,1-.26,1.71,5,5,0,0,1-.74,1.47,5.36,5.36,0,0,1-1.2,1.17,6.23,6.23,0,0,1-1.62.83,3.65,3.65,0,0,1,.67.48,3.32,3.32,0,0,1,.56.67Zm-8.79-9.55a4.79,4.79,0,0,0,1.58-.23,3,3,0,0,0,1.09-.64,2.47,2.47,0,0,0,.63-1,3.48,3.48,0,0,0,.2-1.2,2.46,2.46,0,0,0-.86-2,4,4,0,0,0-2.61-.71h-1.95v5.74Z"/>
				<path d="M207.07,20.47v7h-3.75v-7L196.73,9.31H200a1.23,1.23,0,0,1,.78.23,1.67,1.67,0,0,1,.47.59l3,5.71q.3.57.54,1.08t.43,1q.17-.5.41-1t.52-1.07l3-5.71a1.85,1.85,0,0,1,.45-.56,1.13,1.13,0,0,1,.77-.26h3.33Z"/>
			</symbol>
		</defs>
	</svg>
</div>