<footer class="footer-2">
	<div class="container">
		<div class="row">
			{if $settings->footer_show_social}
			<div class="col-xs-12 col-md-6 col-lg-4">
				<div class="footer-social">
					{if $settings->show_facebook}
						<a href="{$settings->facebook_url}" target="_blank" class="icon icon-facebook"></a>
					{/if}
					{if $settings->show_twitter}
						<a href="{$settings->twitter_url}" target="_blank" class="icon icon-twitter"></a>
					{/if}
					{if $settings->show_instagram}
						<a href="{$settings->instagram_url}" target="_blank" class="icon icon-instagram"></a>
					{/if}
					{if $settings->show_pinterest}
						<a href="{$settings->pinterest_url}" target="_blank" class="icon icon-pinterest"></a>
					{/if}
				</div>
      </div>
			{/if}
			<div class="col-xs-12 col-md-6{if $settings->footer_show_social} col-lg-4{/if} col-md-no-pd align-center">
        {if $settings->show_ft_menu_1 && $settings->ft_menu_1 != ""}
          <ul class="footer-nav">
            {foreach from=$menulists->{$settings->ft_menu_1}->links item="menu"}
              <li><a href="{$menu->url}">{$menu->title}</a></li>
            {/foreach}
          </ul>
        {/if}
      </div>
			<div class="col-xs-12{if $settings->footer_show_social} col-lg-4{else} col-md-6{/if}">
					<p class="footer-copyright">Copyright &copy; {$smarty.now|date_format:"%Y"} {$shop->name}.<a id="shoplo" title="Sprawdź najprostszy sposób sprzedaży w internecie" href="http://shoplo.com" class="push-right">{trans}store_theme_translations.internet_shops{/trans} Shoplo</a></p>
			</div>
		</div>
	</div>
</footer>
