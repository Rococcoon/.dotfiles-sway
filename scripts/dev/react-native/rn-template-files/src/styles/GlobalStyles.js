// @ts-check

/** ---------------- React ---------------- */
import { StyleSheet } from 'react-native';

export function createGlobalStyles() {
  return StyleSheet.create({

    /** ---------------- Layout / Containers ---------------- */
    container: {
      alignItems: 'center',
      backgroundColor: '#fff',
      flex: 1,
      justifyContent: 'center',
    },
  })
}
