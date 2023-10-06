module.exports = ({ config }) => ({
  ...config,
    slug: "screentime-expo",
    extra: {
      eas: {
        projectId: ""
      }
    },
    ios: {
        bundleIdentifier: "com.test.screentime.expo",
        buildNumber: "1",
        entitlements: ["com.apple.developer.family-controls"]
    },
    android: {
        package: "com.test.screentime.expo",
        versionCode: 1
    }
  });