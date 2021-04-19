/** @type {import("snowpack").SnowpackUserConfig } */
const path = require("path");

module.exports = {
  mount: {
    // public: { url: "/js/", static: true },
    // src: { url: path.resolve(__dirname, "../priv/static/js") },
    src: { url: "/dist/" },
    [path.resolve(__dirname, "../priv/static/js")]: { url: "/js/" },
  },
  plugins: [
    /* ... */
  ],
  routes: [
    /* Enable an SPA Fallback in development: */
    // {"match": "routes", "src": ".*", "dest": "/index.html"},
  ],
  optimize: {
    /* Example: Bundle your final build: */
    // "bundle": true,
  },
  packageOptions: {
    /* ... */
  },
  devOptions: {
    /* ... */
    port: 4001,
    open: "none",
  },
  buildOptions: {
    /* ... */
  },
};
