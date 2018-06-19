<footer class="footer-2">
	<div class="container">
		<div class="row">
			{if $settings->footer_show_social}
			<div class="col-xs-12 col-md-3">
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
			<div class="col-xs-12 col-md-9">
        {if $settings->show_ft_menu_1 && $settings->ft_menu_1 != ""}
          <ul class="footer-nav">
            {foreach from=$menulists->{$settings->ft_menu_1}->links item="menu"}
              <li><a href="{$menu->url}">{$menu->title}</a></li>
            {/foreach}
          </ul>
        {/if}
      </div>
		</div>
	</div>
</footer>
