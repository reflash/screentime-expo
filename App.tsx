import { StatusBar } from 'expo-status-bar';
import { SafeAreaView, StyleSheet, Text } from 'react-native';
import { ExpoScreentimeView, authorize, selectedAppsData } from './modules/expo-screentime';
import { useState, useEffect } from 'react';

export default function App() {
  const [authorized, setAuthorized] = useState<boolean>(false);
  const [appsData, setAppsData] = useState<string>("");

  useEffect(() => {
    const screentimeAuth = async () => {
      const res = await authorize();
      setAppsData(selectedAppsData());
      setAuthorized(res);
    }

    screentimeAuth();
  }, []);
  
  return (
    <SafeAreaView style={styles.container}>
      <Text>Apps: {appsData}</Text>
      {authorized && 
        <ExpoScreentimeView 
          style={{ height: 50, width: "100%" }} 
          name="123"
          onSelectEvent={({ nativeEvent: { } }) => {
            setAppsData(selectedAppsData());
          }}
        />
      }
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
