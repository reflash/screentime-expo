module.exports = function(api) {
  api.cache(true);
  return {
    presets: ['babel-preset-expo'],
    // plugins: [
    //   [
    //     'module-resolver',
    //     {
    //       extensions: ['.tsx', '.ts', '.js', '.json'],
    //       alias: {
    //         // For development, we want to alias the library to the source
    //         'expo-settings': path.join(__dirname, 'modules', 'expo-settings', 'src', 'index.ts'),
    //       },
    //     },
    //   ],
    // ],
  };
};
