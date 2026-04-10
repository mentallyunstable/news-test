final class SemanticsIdentifiers {
  const SemanticsIdentifiers._();

  static const String shellNewsTabButton = 'shell_news_tab_button';
  static const String shellFavoritesTabButton = 'shell_favorites_tab_button';

  static const String newsSearchField = 'news_search_field';
  static const String newsLoadingIndicator = 'news_loading_indicator';
  static const String newsEmptyStateText = 'news_empty_state_text';
  static const String newsErrorMessageText = 'news_error_message_text';
  static const String favoritesEmptyStateText = 'favorites_empty_state_text';

  static const String articleDetailsTitleText = 'article_details_title_text';
  static const String articleDetailsSourceText = 'article_details_source_text';
  static const String articleDetailsContentText = 'article_details_content_text';
  static const String articleDetailsFavoriteButton = 'article_details_favorite_button';

  static String newsCategoryChip(final String category) => 'news_category_${category}_chip';

  static String newsListItem(final int index) => 'news_list_item_$index';

  static String newsListItemTitle(final int index) => 'news_list_item_${index}_title';
}
