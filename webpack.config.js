const path = require("path");
const VueLoaderPlugin = require("vue-loader/lib/plugin");
const ManifestPlugin = require("webpack-manifest-plugin");

module.exports = (env, argv) => {
  const isProduction = argv.mode === "production";
  return {
    entry: {
      application: path.resolve(
        __dirname,
        "app",
        "javascript",
        "application.js"
      )
    },
    output: {
      path: path.resolve(__dirname, "public", "dist"),
      filename: "[name].[hash].js",
      chunkFilename: "[name].[hash].chunk.js",
      publicPath: "/dist/"
    },
    module: {
      rules: [
        {
          test: /\.vue$/,
          use: ["vue-loader"]
        },
        {
          test: /\.js$/,
          use: ["babel-loader"],
          exclude: /node_modules/
        },
        {
          test: /\.json$/,
          use: ["json-loader"]
        },
        {
          test: /\.(sass|scss)$/,
          use: ["sass-loader"]
        },
        {
          test: /\.css$/,
          use: ["style-loader", "css-loader"]
        },
        {
          test: /\.(png|jpg|jpeg|gif|svg)$/,
          loader: "file-loader",
          options: {
            name: isProduction ? "[name].[hash].[ext]" : "[name].[ext]"
          }
        }
      ]
    },
    plugins: [
      new VueLoaderPlugin(),
      new ManifestPlugin({
        fileName: "manifest.json",
        publicPath: "/dist/",
        writeToFileEmit: true
      })
    ],
    devServer: {
      publicPath: "/dist/",
      contentBase: path.resolve(__dirname, "public", "dist"),
      host: "0.0.0.0",
      port: 8080,
      disableHostCheck: true,
      headers: {
        "Access-Control-Allow-Origin": "*"
      },
      watchOptions: {
        poll: true
      }
    }
  };
};
