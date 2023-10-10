import { StatusBar } from 'expo-status-bar';
import { Button, StyleSheet, Text, View } from 'react-native';
import { getTheme, setTheme, getApps, addThemeListener } from './modules/expo-screentime';
import { useState, useEffect } from 'react';

export default function App() {
  const [themeName, setThemeName] = useState<string>(getTheme());

  useEffect(() => {
    const subscription = addThemeListener(({ theme: newTheme }) => {
      setThemeName(newTheme);
    });

    return () => subscription.remove();
  }, [setThemeName]);
  
  // Toggle between dark and light theme
  const nextTheme = themeName === 'dark' ? 'light' : 'dark';

  return (
    <View style={styles.container}>
      <Text>Open up App.tsx to start working on your app!</Text>
      <Text>Theme: {themeName}</Text>
      <Text>Apps: {JSON.stringify(getApps())}</Text>
      <Button title={`Set theme to ${nextTheme}`} onPress={() => setTheme(nextTheme)} />
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
