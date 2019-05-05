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

  def self.fetch_maker slug
    result = Client.query(ObjectQuery, variables: { slug: slug })
    result
  end

  def self.fetch_category slug
    result = Client.query(ObjectQuery, variables: { slug: slug })
    result
  end

end