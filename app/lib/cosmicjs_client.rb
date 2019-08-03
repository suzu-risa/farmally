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
      limit: 5,
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

      Rails.cache.write("#{slug}", result)

      return result
    end
  end

  def self.fetch_category slug
    Rails.cache.fetch("#{slug}", expires_in: 12.hours) do

      result = Client.query(ObjectQuery, variables: { slug: slug })

      Rails.cache.write("#{slug}", result)

      return result
    end
  end


  def self.fetch_latest_sell_cases
    Rails.cache.fetch("fetch_latest_sell_cases", expires_in: 12.hours) do
      result = Client.query(FetchSellCaseQuery)

      Rails.cache.write("fetch_latest_sell_cases", result.original_hash["data"]["getObjects"])

      return result.original_hash["data"]["getObjects"]
    end
  end

end
