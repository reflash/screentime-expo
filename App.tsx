import { StatusBar } from 'expo-status-bar';
import { Button, SafeAreaView, StyleSheet, Text, View } from 'react-native';
import { getTheme, setTheme, getApps, addThemeListener, ExpoScreentimeView } from './modules/expo-screentime';
import { useState, useEffect } from 'react';

export default function App() {
  const [themeName, setThemeName] = useState<string>(getTheme());
  const [apps, setApps] = useState<string>("");

  useEffect(() => {
    const subscription = addThemeListener(({ theme: newTheme }) => {
      setThemeName(newTheme);
    });

    return () => subscription.remove();
  }, [setThemeName]);

  useEffect(() => {
    const fetchApps = async () => {
      const res = await getApps();
      setApps(res);
    }

    fetchApps();
  }, []);
  
  // Toggle between dark and light theme
  const nextTheme = themeName === 'dark' ? 'light' : 'dark';
  
  return (
    <SafeAreaView style={styles.container}>
      <Text>Open up App.tsx to start working on your app!</Text>
      <Text>Theme: {themeName}</Text>
      <Text>Apps: {apps}</Text>
      <ExpoScreentimeView 
        style={{ height: 50, width: "100%" }} 
        name="123" 
      />
      <Button title={`Set theme to ${nextTheme}`} onPress={() => setTheme(nextTheme)} />
      <StatusBar style="auto" />
    </SafeAreaView>
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
