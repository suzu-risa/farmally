const path = require("path");
const VueLoaderPlugin = require("vue-loader/lib/plugin");
const ManifestPlugin = require("webpack-manifest-plugin");

module.exports = (_env, argv) => {
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
          loader: "vue-loader"
        },
        {
          test: /\.js$/,
          use: ["babel-loader"],
          exclude: /node_modules/
        },
        {
          test: /\.(sass|scss)$/,
          use: [
            "vue-style-loader",
            "css-loader",
            {
              loader: "sass-loader",
              options: {
                indentedSyntax: true
              }
            }
          ]
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
    resolve: {
      alias: {
        vue$: "vue/dist/vue.esm.js"
      },
      extensions: [".js", ".vue"]
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
