if defined? Refinery::Snippets
  require 'refinery/snippet'

  featured_image_snippet = Refinery::Snippet.where(
    title: 'Featured Image',
    snippet_type: 'template',
    canonical_friendly_id: 'featured-image'
  ).first_or_initialize

  Globalize.with_locales(Refinery::I18n.frontend_locales) do |locale|
    featured_image_snippet.update_attributes(
      body: '/refinery/snippets/featured_image',
      title: featured_image_snippet.title
    )
  end
end
