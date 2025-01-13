/** @type {import('next').NextConfig} */
const path = require('path');

const nextConfig = {
  reactStrictMode: false,
  sassOptions: {
    includePaths: [path.join(__dirname, 'styles')],
    prependData: `@use "styles/_helpers.scss" as *;`,
  },
  webpack(config) {
    config.module.rules.push({
      test: /\.glsl$/,
      type: 'asset/source',
    });

    return config;
  },
};

module.exports = (_phase, { defaultConfig: _ }) => {
  const plugins = [];
  return plugins.reduce((acc, plugin) => plugin(acc), { ...nextConfig });
};
