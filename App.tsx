/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {
  SafeAreaView,
  StatusBar,
  useColorScheme,
  NativeModules,
  TouchableOpacity,
  Text,
  Linking,
} from 'react-native';

import {Colors} from 'react-native/Libraries/NewAppScreen';

const {JwtRs} = NativeModules;

function App(): JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar
        barStyle={isDarkMode ? 'light-content' : 'dark-content'}
        backgroundColor={backgroundStyle.backgroundColor}
      />
      <TouchableOpacity
        onPress={() => {
          // const userdata = {
          //   exp: new Date().getTime() + 1000 * 60 * 60 * 24 * 30,
          //   user: {
          //     store_id: '33369',
          //     data: {
          //       store_id: '33369',
          //       name: '7NOW',
          //     },
          //   },
          //   iss: '7now-auth-33369',
          //   admin: true,
          //   sub: '33369',
          //   aud: 'storeapp-realm-xpidl',
          // };
          JwtRs.generateJWT(
            // '7now-auth-33369',
            // '33369',
            // new Date().getTime() + 1000 * 60 * 60 * 24 * 30,
            // true,
            // 'storeapp-realm-xpidl',
            // '33369',
            // '7NOW',
            // (resp: string) => {
            //   JwtRs.verifyJwt(resp, (resp1: boolean) => {
            //     console.log('verified', resp1);
            //     console.log('JWT', resp);
            //   });
            // },
          );
          // Linking.openURL('app-settings://odaque');
        }}>
        <Text>Hello</Text>
      </TouchableOpacity>
    </SafeAreaView>
  );
}

export default App;
