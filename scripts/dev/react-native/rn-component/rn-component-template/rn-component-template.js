// @ts-check

/** ---------------- React ---------------- */
import React from "react";
import { View, Text } from "react-native";

/** ---------------- Styles ---------------- */
import createGlobalStyles from "@/styles/GlobalStyles";
import create__COMPONENT_NAME__Styles from "./rn-component-template.styles";

/** ---------------- Types ---------------- */
/** @typedef {import('react').ReactElement} JSXElement */

/**
 * @returns {JSXElement}
 */
const __COMPONENT_NAME__ = () => {

  /** @type {any} */
  const GlobalStyles = createGlobalStyles();

  /** @type {any} */
  const styles = create__COMPONENT_NAME__Styles();

  return (
    <View style={GlobalStyles.container}>
      <Text style={styles.header}>__COMPONENT_NAME__</Text>
    </View>
  );
}

export default __COMPONENT_NAME__;
