require "jekyll"
require_relative "./transliterate_bengali"  # Make sure the path is correct

module Jekyll
  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      site.categories.each do |category, posts|
        ascii = BengaliTransliterator.transliterate(category)
        category_slug = ascii.gsub(' ', '-').downcase

        puts "Generating category_slug: #{category_slug}"
        dir = File.join("categories", category_slug)
        category_page = CategoryPage.new(site, site.source, dir, category, category_slug)

        site.pages << category_page
      end
    end
  end

  class CategoryPage < Page
    def initialize(site, base, dir, category, category_slug)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"

      self.process(@name)
      self.read_yaml(File.join(base, "_layouts"), "category.html")
      self.data["category"] = category
      self.data["category_slug"] = category_slug
      self.data["title"] = "#{category} ক্যাটাগরি"
    end
  end
end
