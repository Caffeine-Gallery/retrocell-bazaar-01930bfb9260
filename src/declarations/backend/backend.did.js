export const idlFactory = ({ IDL }) => {
  const Phone = IDL.Record({
    'id' : IDL.Nat,
    'name' : IDL.Text,
    'description' : IDL.Text,
    'imageUrl' : IDL.Text,
    'brand' : IDL.Text,
    'price' : IDL.Nat,
  });
  return IDL.Service({
    'getAllPhones' : IDL.Func([], [IDL.Vec(Phone)], ['query']),
    'getPhone' : IDL.Func([IDL.Nat], [IDL.Opt(Phone)], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
