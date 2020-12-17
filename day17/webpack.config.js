const nodeExternals = require("webpack-node-externals");
const path = require("path");

module.exports = {
  entry: {
    part1: "./src/part1.ts",
    part2: "./src/part2.ts"
  },
  target: "node",
  externals: [nodeExternals()],
  mode: "production",
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        use: "ts-loader",
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    modules: ["src"],
    extensions: [".ts", ".js"]
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, "dist")
  }
};