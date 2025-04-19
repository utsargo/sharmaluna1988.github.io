require "jekyll"
require_relative "./transliterate_bengali"  # Your custom Bengali transliterator

module Jekyll
  class CategoryPaginationGenerator < Generator
    safe true

    POSTS_PER_PAGE = 8
    OFFSET = 4  # Skip first 4 posts

    def generate(site)
      site.categories.each do |category, posts|
        ascii = BengaliTransliterator.transliterate(category)
        category_slug = ascii.gsub(' ', '-').downcase

        # Sort and skip first 4 posts
        posts = posts.sort_by { |post| -post.date.to_f }[OFFSET..] || []

        total_pages = (posts.size.to_f / POSTS_PER_PAGE).ceil
        (1..total_pages).each do |current_page|
          paginated_posts = posts.slice((current_page - 1) * POSTS_PER_PAGE, POSTS_PER_PAGE)
          path = current_page == 1 ? File.join("categories", category_slug) : File.join("categories", category_slug, "page#{current_page}")

          puts "Generating #{path} with #{paginated_posts.size} posts (Page #{current_page}/#{total_pages})"
          page = PaginatedCategoryPage.new(site, site.source, '', path, category, category_slug, current_page, total_pages, paginated_posts)
          site.pages << page
        end
      end
    end
  end

  class PaginatedCategoryPage < Page
    def initialize(site, base, dir, path, category, category_slug, current_page, total_pages, posts)
      @site = site
      @base = base
      @dir  = path
      @name = "index.html"

      self.process(@name)
      self.read_yaml(File.join(base, "_layouts"), "category.html")

      self.data["category"] = category
      self.data["category_slug"] = category_slug
      self.data["posts"] = posts
      self.data["pagination"] = {
        "current_page" => current_page,
        "total_pages"  => total_pages,
        "category_slug" => category_slug,
        "base_url" => File.join("/categories", category_slug)
      }

      self.data["title"] = "#{category} ক্যাটাগরি - পৃষ্ঠা #{current_page}" if current_page > 1
    end
  end
end
