require 'active_support/inflector'
require 'vacuum'

class Book
  extend ActiveSupport::Inflector

  def initialize(asin)
    @date = Time.new
    @details = find_book_by_asin(asin)
  end

  def filename
    "#{date_param}-#{title_param}-#{author_param}.html.markdown"
  end

  def date_param
    @date.strftime('%Y-%m-%d')
  end

  def title
    @details['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Title']
  end

  def author
    author_string = @details['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Author']
    if author_string.is_a? Array
      author_string = author_string.join(', ')
    end
    author_string
  end

  def editor
    @details['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Editor']
  end

  def publisher
    @details['ItemLookupResponse']['Items']['Item']['ItemAttributes']['Publisher']
  end

  def url
    @details['ItemLookupResponse']['Items']['Item']['DetailPageURL']
  end

  def image
    @details['ItemLookupResponse']['Items']['Item']['SmallImage']['URL']
  end

  private

  def find_book_by_asin(asin)
    # TODO: Error handling
    begin
      request = Vacuum.new
      request.associate_tag = 'everrail-20'
      query = {
        query: {
          'ItemId' => asin,
          'ResponseGroup' => 'ItemAttributes,Images',
        }
      }
      response = request.item_lookup(query)
      response.to_h
    rescue Excon::Error::ServiceUnavailable
      puts "Amazon API blocked due to low revenue 😭"
      exit
    end
  end

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
