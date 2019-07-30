const webpack = require('webpack')
const HtmlWebpackPlugin = require("html-webpack-plugin");
const dotenv = require('dotenv').config();

console.log(dotenv.parsed)

const config = isDev => ({
  entry: "./src/index.js",
  output: {
    path: `${__dirname}/build`,
    filename: "[name].[hash].js"
  },
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: [
          {
            loader: "elm-webpack-loader",
            options: {
              debug: isDev
            }
          }
        ]
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "src/index.ejs"
    }),
    new webpack.DefinePlugin({
      "process.env": JSON.stringify(dotenv.parsed)
    })
  ]
});

module.exports = (_, argv) => config(argv.mode !== "production");
