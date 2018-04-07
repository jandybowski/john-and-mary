<div class="container">
	{snippet file="breadcrumbs"}
	<div class="row">
		<div class="col-xs-12">
			<header class="article-title align-center">
				<h4><a href="{reverse_url name=shop_blog blog_url=$blog->url}">{$blog->title}</a></h4>
				<h3>{$article->title}</h3>
				<span class="article-date">{$article->user_first_name} {$article->user_last_name} {$article->published_at|nicedate}</span>
			</header>
		</div>
		<div class="article col-xs-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2 wysiwyg-content">
			{$article->content}
		</div>
		<div class="col-xs-12">
			{if $article->tags|@count != 0}
				<div class="blog-tags col-xs-12 col-sm-12 col-md-6 col-no-pd">
					<h5>{trans}store_theme_translations.blog_tags{/trans}:</h5>
					<ul>
						{foreach from=$article->tags item=tag}
							<li>{$tag|link_to_tag:$tag}</li>
						{/foreach}
					</ul>
				</div>
			{/if}
			<div class="col-xs-12 col-sm-12 col-md-6 {if $article->tags|@count == 0}col-md-offset-6{/if} align-right col-no-pd">
				<div class="article-share">
					<ul>
						<li><a href="https://www.facebook.com/sharer/sharer.php?u={reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}" target="_blank"><i class="icon-facebook"></i></a></li>
						<li><a href="http://twitter.com/share?url={reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}" target="_blank"><i class="icon-twitter"></i></a></li>
						<li><a href="http://pinterest.com/pin/create/button/?url={reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}" target="_blank"><i class="icon-pinterest"></i></a></li>
						<li><a href="https://plus.google.com/share?url={reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}" target="_blank"><i class="icon-google-plus"></i></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="article-nav col-xs-12">
			<div class="article-nav-controler">
				{if $article->previous_article}
					<a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->previous_article->url}" class="align-left prev-article">« {trans}store_theme_translations.blog_previous_article{/trans}</a>
				{/if}
				{if $article->next_article}
					<a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->next_article->url}" class="align-right next-article">{trans}store_theme_translations.blog_next_article{/trans} »</a>
				{/if}
			</div>
		</div>
		<div id="comments" class="col-xs-12">
			{$article->getBlog()->comment_script}
		</div>

	</div>
</div>
