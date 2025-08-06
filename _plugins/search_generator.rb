# _plugins/search_generator.rb
require 'json'
module Jekyll
  class SearchIndex < Generator
    priority :lowest

    def generate(site)
      items = []

      site.posts.docs.each do |post|
        items << {
          "title" => post.data['title'],
          "url" => post.url,
          "date" => post.date.strftime('%Y-%m-%d'),
          "categories" => post.data['categories'],
          "content" => post.content.gsub(/<\/?[^>]*>/, "") # Remove HTML
        }
      end

      File.open(File.join(site.dest, 'search.json'), 'w') do |f|
        f.write(JSON.pretty_generate(items))
      end
    end
  end
end
