if defined? Refinery::Snippets
  require 'refinery/snippet'

  featured_image_snippet = Refinery::Snippet.where(
    title: 'Featured Image',
    snippet_type: 'template'
  ).first_or_initialize

  featured_image_snippet.update_attributes(body: '/refinery/snippets/featured_image') if featured_image_snippet.body.blank?
end
