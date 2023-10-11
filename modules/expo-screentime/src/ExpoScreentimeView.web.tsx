import * as React from 'react';

import { ExpoScreentimeViewProps } from './ExpoScreentime.types';

export default function ExpoScreentimeView(props: ExpoScreentimeViewProps) {
  return (
    <div>
      <span>{props.name}</span>
    </div>
  );
}
