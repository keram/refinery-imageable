module Refinery
  class ImageableImagesPresenter
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::AssetTagHelper

    attr_reader :id, :fallback_html, :hidden
    alias_method :hidden?, :hidden
    attr_accessor :override_html

    def initialize(obj, options={})
      @obj = obj
      @hidden = obj.images.empty?
      @position = options[:position] || :before_body
      @image_geometry = options[:geometry] || '100x100'
      @show_caption = options[:caption]
    end

    def id
      @id ||= "images-#{@position}"
    end

    def not_present_css_class
      'no_images'
    end

    def visible?
      !hidden?
    end

    def hidden?
      @hidden
    end

    def has_content?(can_use_fallback = true)
      visible?
    end

    def show_caption? caption=nil
      @show_caption && caption.present?
    end

    def content_html(can_use_fallback = true)
      buffer = ActiveSupport::SafeBuffer.new
      @obj.images.each do |image|
        img_buffer = ActiveSupport::SafeBuffer.new
        img_buffer << image_tag(
          image.thumbnail(geometry: @geometry).url, {
          alt: image.alt
        })

        img_buffer << content_tag(:figcaption, image.caption) if show_caption?(image.caption)
        buffer << content_tag(:figure, img_buffer)
      end

      buffer
    end

    def wrapped_html(can_use_fallback = true)
      return if hidden?

      content = content_html(can_use_fallback)
      if content.present?
        wrap_content_in_tag(content)
      end
    end

    def wrap_content_in_tag(content)
      content_tag(:div, content, id: id)
    end
  end
end
