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

export type BlockedChangeEvent = {
  isBlocked: boolean;
};

export function addIsBlockedListener(listener: (event: BlockedChangeEvent) => void): Subscription {
  return emitter.addListener<BlockedChangeEvent>('onChangeBlocked', listener);
}

export function getTheme(): string {
  return ExpoScreentimeModule.getTheme();
}

export function setTheme(theme: string): void {
  return ExpoScreentimeModule.setTheme(theme);
}

export function authorize(): Promise<boolean> {
  return ExpoScreentimeModule.authorize();
}

export function selectedAppsData(): string {
  return ExpoScreentimeModule.selectedAppsData();
}

export function blockApps(): void {
  return ExpoScreentimeModule.blockApps();
}

export function unblockApps(): void {
  return ExpoScreentimeModule.unblockApps();
}

export function isBlocked(): boolean {
  return ExpoScreentimeModule.isBlocked();
}

export { ExpoScreentimeView, ExpoScreentimeViewProps, ChangeEventPayload };
