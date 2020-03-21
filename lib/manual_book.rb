require 'active_support/inflector'

class ManualBook
  extend ActiveSupport::Inflector

  def initialize(settings)
    @date = Time.new
    @settings = settings
  end

  def filename
    "#{date_param}-#{title_param}-#{author_param}.html.markdown"
  end

  def date_param
    @date.strftime('%Y-%m-%d')
  end

  def title
    @settings.title
  end

  def author
    @settings.author
  end

  def editor
    @settings.editor
  end

  def publisher
    @settings.publisher
  end

  def url
    @settings.purchase_url
  end

  def image
    "https://images-na.ssl-images-amazon.com/images/I/#{@settings.image_id}._SL75_.jpg"
  end

  private

  def title_param
    title.parameterize
  end

  def author_param
    if author
      author.parameterize
    elsif editor
      editor.parameterize
    end
  end
end
