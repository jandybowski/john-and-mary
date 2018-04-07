<div class="container">
    <div class="row">
        <header class="page-header">
            <div class="row">
                <div class="col-xs-12 align-center">
                    <h1 {if !$settings->show_breadcrumbs}class="without-breadcrumbs"{/if}>{$blog->title}</h1>
                </div>
            </div>
        </header>
        {if $settings->show_breadcrumbs}
            {snippet file="breadcrumbs"}
        {/if}
        <div class="col-xs-12">
            {paginate set=$blog items=$blog->getArticles() per_page={$settings->bloglist_posts_count}}
            {assign var="articles" value=$items}
            {if !$articles}
                <p>
                    {trans}store_theme_translations.blog_no_articles_in_blog{/trans}
                </p>
            {else}
                {foreach from=$articles item="article"}
                    <div class="article align-center col-xs-12 col-sm-12 col-md-6 col-lg-4">
                        <a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}">
                            <div class="img">
                                {if $article->image}
                                    <img src="{$article->image|article_img_url}"/>
                                {else}
                                    <img src="https://placeholdit.imgix.net/~text?txtsize=33&txt=340%C3%97200&w=340&h=200"/>
                                {/if}
                            </div>
                        </a>
                        <h3><a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}">{$article->title}</a></h3>
                        {if $article->excerpt}
                            <div class="article-excerpt wysiwyg-content">
                                {$article->excerpt}
                            </div>
                        {/if}
                        <a href="{reverse_url name=shop_blog_article blog_url=$blog->url article_url=$article->url}" class="btn btn-black">{trans}store_theme_translations.blog_read_more{/trans}</a>
                    </div>
                {/foreach}
                {if $pager->is_pagination_need}
                    <div class="col-xs-12">
                        {$pager|default_pagination}
                    </div>
                {/if}
            {/if}
            {/paginate}
        </div>
    </div>
</div>
