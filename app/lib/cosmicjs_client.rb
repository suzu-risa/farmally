require "graphql/client"
require "graphql/client/http"

module CosmicjsClient

  HTTP = GraphQL::Client::HTTP.new("https://graphql.cosmicjs.com/v1") do
    def headers(context)
      # Optionally set any HTTP headers
      { "User-Agent" => "Farmally Server" }
    end
  end

  Schema = GraphQL::Client.load_schema(HTTP)

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)


  ObjectQuery = Client.parse <<-'GRAPHQL'
  query($slug: String!) {
    object(bucket_slug: "farmally-inc", slug: $slug) {
      title
      metadata
    }
  }
  GRAPHQL


  FetchSellCaseQuery = Client.parse <<-'GRAPHQL'
  {
    getObjects(bucket_slug: "farmally-inc", input: {
      type: "sell-cases",
      limit: 3,
      read_key: ""
    }) {
      title
      metadata
    }
  }
  GRAPHQL

  FetchSellCaseQueryByCategory = Client.parse <<-'GRAPHQL'
  query($category_key: String!) {
    getObjects(bucket_slug: "farmally-inc", input: {
      type: "sell-cases",
      limit: 5,
      metafield_key: "category",
      metafield_value: $category_key,
      read_key: ""
    }) {
      title
      metadata
    }
  }
  GRAPHQL

  FetchSellCaseQueryByMaker = Client.parse <<-'GRAPHQL'
  query($maker_key: String!) {
    getObjects(bucket_slug: "farmally-inc", input: {
      type: "sell-cases",
      limit: 5,
      metafield_key: "maker",
      metafield_value: $maker_key,
      read_key: ""
    }) {
      title
      metadata
    }
  }
  GRAPHQL


  FetchCategories = Client.parse <<-'GRAPHQL'
{
  getObjects(bucket_slug: "farmally-inc", input: {
    type: "categories",
    limit: 20,
    read_key: ""
  }) {
    title
    metadata
  }
}
  GRAPHQL

  def self.fetch_maker slug
    Rails.cache.fetch("#{slug}", expires_in: 12.hours) do
      result = Client.query(ObjectQuery, variables: { slug: slug })

      Rails.cache.write("#{slug}", result.original_hash["data"])

      return result.original_hash["data"]
    end
  end

  def self.fetch_category slug
    Rails.cache.fetch("#{slug}", expires_in: 12.hours) do

      result = Client.query(ObjectQuery, variables: { slug: slug })

      Rails.cache.write("#{slug}", result.original_hash["data"])

      return result.original_hash["data"]
    end
  end


  def self.fetch_latest_sell_cases
    Rails.cache.fetch("fetch_latest_sell_cases", expires_in: 12.hours) do
      result = Client.query(FetchSellCaseQuery)

      Rails.cache.write("fetch_latest_sell_cases", result.original_hash["data"]["getObjects"])

      return result.original_hash["data"]["getObjects"]
    end
  end

  def self.fetch_latest_sell_cases_by_category_slug(category_slug)
    key = Category::SellCategories.find {|c| c[:slug] == category_slug}
    unless key
      return nil
    end

    cache_key = "fetch_latest_sell_cases_#{category_slug}"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      result = Client.query(FetchSellCaseQueryByCategory, variables: {category_key: key[:id]})
      Rails.cache.write(cache_key, result.original_hash["data"]["getObjects"])
      return result.original_hash["data"]["getObjects"]
    end
  end

  def self.fetch_latest_sell_cases_by_maker_slug(maker_slug)
    key = Maker::SellMakers.find {|c| c[:slug] == maker_slug}
    unless key
      return nil
    end

    cache_key = "fetch_latest_sell_cases_#{maker_slug}"
    Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      result = Client.query(FetchSellCaseQueryByMaker, variables: {maker_key: key[:id]})
      Rails.cache.write(cache_key, result.original_hash["data"]["getObjects"])
      return result.original_hash["data"]["getObjects"]
    end
  end

end
