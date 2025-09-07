const esbuild = require("esbuild")
const sassPlugin = require("esbuild-plugin-sass")

esbuild.build({
  entryPoints: ["app/javascript/application.js"],
  bundle: true,
  outdir: "app/assets/builds",
  sourcemap: true,
  plugins: [sassPlugin({
    includePaths: ["node_modules"]  // <-- this allows @import "bootstrap/scss/bootstrap";
  })],
  publicPath: "/assets",
  watch: process.argv.includes("--watch"),
}).catch(() => process.exit(1))
