{assign "langletters" array('ą', 'ć', 'ę', 'ł', 'ś', 'ó', 'ż', 'ź', 'ń', ' ')}
{assign "letters" array('a', 'c', 'e', 'l', 's', 'o', 'z', 'z', 'n', '_')}
<nav id="mobileMenu" class="hidden">
    <ul>
        {foreach from=$menulists->main_menu->links item="menu"}
            {assign menu_has_dropdown 0}
            {foreach from=$categories->all() item="cat"}
                {if $cat->url == $menu->url|replace:'/kategoria/':''}
                    {if $cat->has_children}
                        {assign "childs" $cat->childs}
                        {assign  menu_has_dropdown 1}
                    {/if}
                {/if}
            {/foreach}
            <li class="nav-item{if $template == 'category' && $category->title == $menu->title} active
                        {elseif $template == 'collection' && ($menu->url|strpos:$collection->url !== false)} active
                        {elseif $template == 'list_categories' && 'Kategorie' == $menu->title} active
                        {elseif isset($page) and $page->url == $menu->url} active
                        {elseif isset($product) and $product_url == $menu->url} active
                        {elseif $template == 'home'}{if $menu->url == '/'} active{/if}{/if}{if $menu_has_dropdown} has-dropdown{/if}">
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
<script>
    var searchActionUrl = "{reverse_url name='shop_search'}",
        searchPlaceholder = '{trans preview-trans=0}store_theme_translations.search_placeholder{/trans}',
        searchQuery = '{$query}',
        showSearchBox = '{$settings->show_searchbox_in_mobile_menu}',
        langPlaceholder = '{trans preview-trans=0}store_theme_translations.lang_placeholder{/trans}',
        showLangSwitcher = '{$settings->show_language_switcher}',
        langSwitcherFirstUrl = "{$settings->lang_switcher_1_url}",
        langSwitcherFirstTitle = "{$settings->lang_switcher_1_title}",
        langSwitcherSecondUrl = "{$settings->lang_switcher_2_url}",
        langSwitcherSecondTitle = "{$settings->lang_switcher_2_title}",
        showSocialIcons = '{$settings->show_social_icons}',
        socialIconsShowFacebook = "{$settings->show_facebook}",
        socialIconsFacebookUrl = "{$settings->facebook_url}",
        socialIconsShowTwitter = "{$settings->show_twitter}",
        socialIconsTwitterUrl = "{$settings->twitter_url}",
        socialIconsShowPinterest = "{$settings->show_pinterest}",
        socialIconsPinterestUrl = "{$settings->pinterest_url}",
        socialIconsShowInstagram = "{$settings->show_instagram}",
        socialIconsInstagramUrl = "{$settings->instagram_url}",
        mobileMenuTheme = "{$settings->choose_mobile_menu_theme}";
</script>