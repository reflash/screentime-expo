import { EventEmitter, Subscription } from 'expo-modules-core';

// Import the native module. On web, it will be resolved to ExpoScreentime.web.ts
// and on native platforms to ExpoScreentime.ts
import ExpoScreentimeModule from './src/ExpoScreentimeModule';
import ExpoScreentimeView from './src/ExpoScreentimeView';
import { ChangeEventPayload, ExpoScreentimeViewProps } from './src/ExpoScreentime.types';

const emitter = new EventEmitter(ExpoScreentimeModule);

export type ThemeChangeEvent = {
  theme: string;
};

export function addThemeListener(listener: (event: ThemeChangeEvent) => void): Subscription {
  return emitter.addListener<ThemeChangeEvent>('onChangeTheme', listener);
}

export function getTheme(): string {
  return ExpoScreentimeModule.getTheme();
}

export function setTheme(theme: string): void {
  return ExpoScreentimeModule.setTheme(theme);
}

export function getApps(): Promise<string> {
  return ExpoScreentimeModule.getApps();
}

export { ExpoScreentimeView, ExpoScreentimeViewProps, ChangeEventPayload };
