import { StatusBar } from 'expo-status-bar';
import { Button, SafeAreaView, StyleSheet, NativeModules } from 'react-native';
import { ExpoScreentimeView, authorize, blockApps, unblockApps, selectedAppsData, addIsBlockedListener, isBlocked } from './modules/expo-screentime';
import { useState, useEffect } from 'react';
import SharedGroupPreferences from 'react-native-shared-group-preferences';

// const group = 'group.screentime.expo';
// const SharedStorage = NativeModules.SharedStorage;

export default function App() {
  const [authorized, setAuthorized] = useState<boolean>(false);
  const [appsData, setAppsData] = useState<string>("");
  const [blocked, setBlocked] = useState<boolean>(false);
  
  const changeBlockedState = async (b: boolean) => {
    setBlocked(b);

    // try {
    //   // iOS
    //   await SharedGroupPreferences.setItem('widgetKey', { isBlocked: b }, group);
    // } catch (error) {
    //   console.log({error});
    // }
    // // Android
    // SharedStorage.set(JSON.stringify({ isBlocked: b }));
  }
  useEffect(() => {
    const screentimeAuth = async () => {
      const res = await authorize();
      setAppsData(selectedAppsData());
      setAuthorized(res);
      changeBlockedState(isBlocked());
    }

    screentimeAuth();
  }, []);

  useEffect(() => {
    const subscription = addIsBlockedListener(({ isBlocked }) => {
      changeBlockedState(isBlocked);
    });

    return () => subscription.remove();
  }, [setBlocked]);

  const handleBlock = () => {
    blockApps();
  }

  const handleUnblock = () => {
    unblockApps();
  }
  
  return (
    <SafeAreaView style={styles.container}>
      {/* <Text>Apps: {appsData}</Text> */}
      {authorized && 
        <>
          <ExpoScreentimeView 
            style={{ height: 100, width: "100%" }} 
            name="123"
            onSelectEvent={({ nativeEvent: { } }) => {
              setAppsData(selectedAppsData());
            }}
          />
          <Button title={blocked ? 'Unblock' : 'Block'} onPress={blocked ? handleUnblock : handleBlock} />
        </>
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
