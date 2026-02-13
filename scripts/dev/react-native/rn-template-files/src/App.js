// @ts-check

/** ---------------- React ---------------- */
import { View } from 'react-native';

/** ---------------- Comopnents ---------------- */
import HomeScreen from '@/screens/HomeScreen/HomeScreen';

/** ---------------- Styles ---------------- */
import { createGlobalStyles } from '@/styles/GlobalStyles';

export default function App() {

  /** @type {any} */
  const GlobalStyles = createGlobalStyles();

  return (
    <View style={GlobalStyles.container}>
      <HomeScreen />
    </View>
  );
}
