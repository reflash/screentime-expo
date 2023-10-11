import { ViewProps } from "react-native";

export type ChangeEventPayload = {
  value: string;
};

export type ExpoScreentimeViewProps = {
  name: string;
} & ViewProps;
