import { EventEmitter, Subscription } from 'expo-modules-core';
import ExpoSettingsModule from './ExpoSettingsModule';

const emitter = new EventEmitter(ExpoSettingsModule);

export type ThemeChangeEvent = {
  theme: string;
};

export function addThemeListener(listener: (event: ThemeChangeEvent) => void): Subscription {
  return emitter.addListener<ThemeChangeEvent>('onChangeTheme', listener);
}

export function getTheme(): string {
  return ExpoSettingsModule.getTheme();
}

export function setTheme(theme: string): void {
  return ExpoSettingsModule.setTheme(theme);
}
