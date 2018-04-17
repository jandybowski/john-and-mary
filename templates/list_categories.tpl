<div class="container">
	{assign category_list $categories->all()}
	{if $category_list}
		{foreach from=$category_list item="category"}
			{if !$category->top_category && $category->products_count != 0}
				<div class="row">
					<header class="page-header">
						<div class="row">
							<div class="col-xs-12 align-center">
								<h1><a href="{reverse_url name='shop_category' category_name=$category->url}">{$category->title}</a></h1>
							</div>
						</div>
						{snippet file="breadcrumbs"}
					</header>
				</div>
				{snippet file="list_categories_grid" grid_class="grid-col3-1" product_col_class="col-md-4 col-sm-6 col-xs-12" product_view=1 grid_columns=6}


			{/if}
		{/foreach}
	{else}
		<div class="row">
			<div class="col-xs-12">
				<h4>{trans}store_theme_translations.msg_no_categories{/trans}</h4>
			</div>
		</div>
	{/if}
</div>
