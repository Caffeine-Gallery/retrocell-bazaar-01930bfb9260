import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Phone {
  'id' : bigint,
  'storage' : string,
  'name' : string,
  'color' : string,
  'description' : string,
  'specs' : string,
  'imageUrl' : string,
  'brand' : string,
  'price' : bigint,
}
export interface _SERVICE {
  'getAllPhones' : ActorMethod<[], Array<Phone>>,
  'getPhone' : ActorMethod<[bigint], [] | [Phone]>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
