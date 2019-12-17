# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://farmally.jp"
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(Settings.sitemap.bucket,
  aws_access_key_id: Rails.application.credentials[:aws][:access_key_id],
  aws_secret_access_key: Rails.application.credentials[:aws][:secret_access_key],
  aws_region: 'ap-northeast-1'
)

SitemapGenerator::Sitemap.create do
  Category.all.each do |category|
    add items_categories_path(category)
  end

  add sell_index_path
  add sell_call_click_path

  add inquiry_index_path
  SaleItem.all.each do | sale_item |
    add buy_path(sale_item)
  end
  
  add specified_commercial_path
  add guide_path

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
