import { requireNativeViewManager } from 'expo-modules-core';
import * as React from 'react';

import { ExpoScreentimeViewProps } from './ExpoScreentime.types';

const NativeView: React.ComponentType<ExpoScreentimeViewProps> =
  requireNativeViewManager('ExpoScreentime');

export default function ExpoScreentimeView(props: ExpoScreentimeViewProps) {
  return <NativeView {...props} />;
}
