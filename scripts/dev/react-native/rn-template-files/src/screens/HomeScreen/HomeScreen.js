// @ts-check

/** ---------------- React ---------------- */
import React, { useState } from 'react';
import { Text, View } from 'react-native';

/** ---------------- Components ---------------- */

/** ---------------- Data ---------------- */

/** ---------------- Styles ---------------- */
import { createHomeStyles } from './HomeScreen.styles';

/** ---------------- Types ---------------- */
/** @typedef {import("@/types/react").JSXElement} JSXElement */

/** @returns {JSXElement} */
export default function PlayerScreen() {

  /** @type {any} */
  const styles = createHomeStyles();

  return (
    <View style={styles.container}>
      <Text>Hello!</Text>
    </View>
  );
}
