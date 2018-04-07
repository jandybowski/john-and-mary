<div id="searchFormWrapper" class="theme-modal theme-modal-top align-left" data-remodal-id="search-modal" >
	<div id="searchForm" class="col-xs-12 col-sm-no-pd">
		<form  action="{reverse_url name='shop_search'}" method="get">
			<input type="search" placeholder="{trans}store_theme_translations.search_placeholder{/trans}" name="q" {if isset($query)}value="{$query}"{/if} />
			<button type="submit"><span class="icon icon-search"></span></button>
		</form>
	</div>
</div>