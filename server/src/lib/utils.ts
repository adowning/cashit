// Common utility functions can be exported from here

export const noop = () => {};

// Add any other utility functions as needed
export * from './validation';

type Primitive = string | number | boolean | bigint | symbol | undefined | null;

export type DeepReadonly<T> = T extends Primitive
  ? T
  : T extends Array<infer U>
  ? DeepReadonlyArray<U>
  : T extends Map<infer K, infer V>
  ? DeepReadonlyMap<K, V>
  : T extends Set<infer M>
  ? DeepReadonlySet<M>
  : DeepReadonlyObject<T>;

interface DeepReadonlyArray<T> extends ReadonlyArray<DeepReadonly<T>> {}

interface DeepReadonlyMap<K, V> extends ReadonlyMap<DeepReadonly<K>, DeepReadonly<V>> {}

interface DeepReadonlySet<T> extends ReadonlySet<DeepReadonly<T>> {}

type DeepReadonlyObject<T> = {
  readonly [P in keyof T]: DeepReadonly<T[P]>;
};
