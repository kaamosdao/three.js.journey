/** @type {import('next').NextConfig} */
const path = require('path');

const nextConfig = {
  reactStrictMode: false,
  sassOptions: {
    includePaths: [path.join(__dirname, 'styles')],
    prependData: `@use "styles/_helpers.scss" as *;`,
  },
};

module.exports = (_phase, { defaultConfig: _ }) => {
  const plugins = [];
  return plugins.reduce((acc, plugin) => plugin(acc), { ...nextConfig });
};
