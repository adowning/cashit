/**
 * WARNING: This is an internal file that is subject to change!
 *
 * 🛑 Under no circumstances should you import this file directly! 🛑
 *
 * All exports from this file are wrapped under a `Prisma` namespace object in the client.ts file.
 * While this enables partial backward compatibility, it is not part of the stable public API.
 *
 * If you are looking for your Models, Enums, and Input Types, please import them from the respective
 * model files in the `model` directory!
 */
import * as runtime from "@prisma/client/runtime/library";
import type * as Prisma from "../models.ts";
import { type PrismaClient } from "./class.ts";
export type * from '../models.ts';
export type DMMF = typeof runtime.DMMF;
export type PrismaPromise<T> = runtime.Types.Public.PrismaPromise<T>;
/**
 * Validator
 */
export declare const validator: typeof runtime.Public.validator;
/**
 * Prisma Errors
 */
export declare const PrismaClientKnownRequestError: typeof runtime.PrismaClientKnownRequestError;
export type PrismaClientKnownRequestError = runtime.PrismaClientKnownRequestError;
export declare const PrismaClientUnknownRequestError: typeof runtime.PrismaClientUnknownRequestError;
export type PrismaClientUnknownRequestError = runtime.PrismaClientUnknownRequestError;
export declare const PrismaClientRustPanicError: typeof runtime.PrismaClientRustPanicError;
export type PrismaClientRustPanicError = runtime.PrismaClientRustPanicError;
export declare const PrismaClientInitializationError: typeof runtime.PrismaClientInitializationError;
export type PrismaClientInitializationError = runtime.PrismaClientInitializationError;
export declare const PrismaClientValidationError: typeof runtime.PrismaClientValidationError;
export type PrismaClientValidationError = runtime.PrismaClientValidationError;
/**
 * Re-export of sql-template-tag
 */
export declare const sql: typeof runtime.sqltag;
export declare const empty: runtime.Sql;
export declare const join: typeof runtime.join;
export declare const raw: typeof runtime.raw;
export declare const Sql: typeof runtime.Sql;
export type Sql = runtime.Sql;
/**
 * Decimal.js
 */
export declare const Decimal: typeof runtime.Decimal;
export type Decimal = runtime.Decimal;
export type DecimalJsLike = runtime.DecimalJsLike;
/**
 * Metrics
 */
export type Metrics = runtime.Metrics;
export type Metric<T> = runtime.Metric<T>;
export type MetricHistogram = runtime.MetricHistogram;
export type MetricHistogramBucket = runtime.MetricHistogramBucket;
/**
* Extensions
*/
export type Extension = runtime.Types.Extensions.UserArgs;
export declare const getExtensionContext: typeof runtime.Extensions.getExtensionContext;
export type Args<T, F extends runtime.Operation> = runtime.Types.Public.Args<T, F>;
export type Payload<T, F extends runtime.Operation = never> = runtime.Types.Public.Payload<T, F>;
export type Result<T, A, F extends runtime.Operation> = runtime.Types.Public.Result<T, A, F>;
export type Exact<A, W> = runtime.Types.Public.Exact<A, W>;
export type PrismaVersion = {
    client: string;
    engine: string;
};
/**
 * Prisma Client JS version: 6.8.2
 * Query Engine version: 2060c79ba17c6bb9f5823312b6f6b7f4a845738e
 */
export declare const prismaVersion: PrismaVersion;
/**
 * Utility Types
 */
export type JsonObject = runtime.JsonObject;
export type JsonArray = runtime.JsonArray;
export type JsonValue = runtime.JsonValue;
export type InputJsonObject = runtime.InputJsonObject;
export type InputJsonArray = runtime.InputJsonArray;
export type InputJsonValue = runtime.InputJsonValue;
export declare const NullTypes: {
    DbNull: (new (secret: never) => typeof runtime.objectEnumValues.instances.DbNull);
    JsonNull: (new (secret: never) => typeof runtime.objectEnumValues.instances.JsonNull);
    AnyNull: (new (secret: never) => typeof runtime.objectEnumValues.instances.AnyNull);
};
/**
 * Helper for filtering JSON entries that have `null` on the database (empty on the db)
 *
 * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
 */
export declare const DbNull: {
    "__#97@#private": any;
    _getNamespace(): string;
    _getName(): string;
    toString(): string;
};
/**
 * Helper for filtering JSON entries that have JSON `null` values (not empty on the db)
 *
 * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
 */
export declare const JsonNull: {
    "__#98@#private": any;
    _getNamespace(): string;
    _getName(): string;
    toString(): string;
};
/**
 * Helper for filtering JSON entries that are `Prisma.DbNull` or `Prisma.JsonNull`
 *
 * @see https://www.prisma.io/docs/concepts/components/prisma-client/working-with-fields/working-with-json-fields#filtering-on-a-json-field
 */
export declare const AnyNull: {
    "__#96@#private": any;
    _getNamespace(): string;
    _getName(): string;
    toString(): string;
};
type SelectAndInclude = {
    select: any;
    include: any;
};
type SelectAndOmit = {
    select: any;
    omit: any;
};
/**
 * From T, pick a set of properties whose keys are in the union K
 */
type Prisma__Pick<T, K extends keyof T> = {
    [P in K]: T[P];
};
export type Enumerable<T> = T | Array<T>;
/**
 * Subset
 * @desc From `T` pick properties that exist in `U`. Simple version of Intersection
 */
export type Subset<T, U> = {
    [key in keyof T]: key extends keyof U ? T[key] : never;
};
/**
 * SelectSubset
 * @desc From `T` pick properties that exist in `U`. Simple version of Intersection.
 * Additionally, it validates, if both select and include are present. If the case, it errors.
 */
export type SelectSubset<T, U> = {
    [key in keyof T]: key extends keyof U ? T[key] : never;
} & (T extends SelectAndInclude ? 'Please either choose `select` or `include`.' : T extends SelectAndOmit ? 'Please either choose `select` or `omit`.' : {});
/**
 * Subset + Intersection
 * @desc From `T` pick properties that exist in `U` and intersect `K`
 */
export type SubsetIntersection<T, U, K> = {
    [key in keyof T]: key extends keyof U ? T[key] : never;
} & K;
type Without<T, U> = {
    [P in Exclude<keyof T, keyof U>]?: never;
};
/**
 * XOR is needed to have a real mutually exclusive union type
 * https://stackoverflow.com/questions/42123407/does-typescript-support-mutually-exclusive-types
 */
export type XOR<T, U> = T extends object ? U extends object ? (Without<T, U> & U) | (Without<U, T> & T) : U : T;
/**
 * Is T a Record?
 */
type IsObject<T extends any> = T extends Array<any> ? False : T extends Date ? False : T extends Uint8Array ? False : T extends BigInt ? False : T extends object ? True : False;
/**
 * If it's T[], return T
 */
export type UnEnumerate<T extends unknown> = T extends Array<infer U> ? U : T;
/**
 * From ts-toolbelt
 */
type __Either<O extends object, K extends Key> = Omit<O, K> & {
    [P in K]: Prisma__Pick<O, P & keyof O>;
}[K];
type EitherStrict<O extends object, K extends Key> = Strict<__Either<O, K>>;
type EitherLoose<O extends object, K extends Key> = ComputeRaw<__Either<O, K>>;
type _Either<O extends object, K extends Key, strict extends Boolean> = {
    1: EitherStrict<O, K>;
    0: EitherLoose<O, K>;
}[strict];
export type Either<O extends object, K extends Key, strict extends Boolean = 1> = O extends unknown ? _Either<O, K, strict> : never;
export type Union = any;
export type PatchUndefined<O extends object, O1 extends object> = {
    [K in keyof O]: O[K] extends undefined ? At<O1, K> : O[K];
} & {};
/** Helper Types for "Merge" **/
export type IntersectOf<U extends Union> = (U extends unknown ? (k: U) => void : never) extends (k: infer I) => void ? I : never;
export type Overwrite<O extends object, O1 extends object> = {
    [K in keyof O]: K extends keyof O1 ? O1[K] : O[K];
} & {};
type _Merge<U extends object> = IntersectOf<Overwrite<U, {
    [K in keyof U]-?: At<U, K>;
}>>;
type Key = string | number | symbol;
type AtStrict<O extends object, K extends Key> = O[K & keyof O];
type AtLoose<O extends object, K extends Key> = O extends unknown ? AtStrict<O, K> : never;
export type At<O extends object, K extends Key, strict extends Boolean = 1> = {
    1: AtStrict<O, K>;
    0: AtLoose<O, K>;
}[strict];
export type ComputeRaw<A extends any> = A extends Function ? A : {
    [K in keyof A]: A[K];
} & {};
export type OptionalFlat<O> = {
    [K in keyof O]?: O[K];
} & {};
type _Record<K extends keyof any, T> = {
    [P in K]: T;
};
type NoExpand<T> = T extends unknown ? T : never;
export type AtLeast<O extends object, K extends string> = NoExpand<O extends unknown ? (K extends keyof O ? {
    [P in K]: O[P];
} & O : O) | {
    [P in keyof O as P extends K ? P : never]-?: O[P];
} & O : never>;
type _Strict<U, _U = U> = U extends unknown ? U & OptionalFlat<_Record<Exclude<Keys<_U>, keyof U>, never>> : never;
export type Strict<U extends object> = ComputeRaw<_Strict<U>>;
/** End Helper Types for "Merge" **/
export type Merge<U extends object> = ComputeRaw<_Merge<Strict<U>>>;
export type Boolean = True | False;
export type True = 1;
export type False = 0;
export type Not<B extends Boolean> = {
    0: 1;
    1: 0;
}[B];
export type Extends<A1 extends any, A2 extends any> = [A1] extends [never] ? 0 : A1 extends A2 ? 1 : 0;
export type Has<U extends Union, U1 extends Union> = Not<Extends<Exclude<U1, U>, U1>>;
export type Or<B1 extends Boolean, B2 extends Boolean> = {
    0: {
        0: 0;
        1: 1;
    };
    1: {
        0: 1;
        1: 1;
    };
}[B1][B2];
export type Keys<U extends Union> = U extends unknown ? keyof U : never;
export type GetScalarType<T, O> = O extends object ? {
    [P in keyof T]: P extends keyof O ? O[P] : never;
} : never;
type FieldPaths<T, U = Omit<T, '_avg' | '_sum' | '_count' | '_min' | '_max'>> = IsObject<T> extends True ? U : T;
export type GetHavingFields<T> = {
    [K in keyof T]: Or<Or<Extends<'OR', K>, Extends<'AND', K>>, Extends<'NOT', K>> extends True ? T[K] extends infer TK ? GetHavingFields<UnEnumerate<TK> extends object ? Merge<UnEnumerate<TK>> : never> : never : {} extends FieldPaths<T[K]> ? never : K;
}[keyof T];
/**
 * Convert tuple to union
 */
type _TupleToUnion<T> = T extends (infer E)[] ? E : never;
type TupleToUnion<K extends readonly any[]> = _TupleToUnion<K>;
export type MaybeTupleToUnion<T> = T extends any[] ? TupleToUnion<T> : T;
/**
 * Like `Pick`, but additionally can also accept an array of keys
 */
export type PickEnumerable<T, K extends Enumerable<keyof T> | keyof T> = Prisma__Pick<T, MaybeTupleToUnion<K>>;
/**
 * Exclude all keys with underscores
 */
export type ExcludeUnderscoreKeys<T extends string> = T extends `_${string}` ? never : T;
export type FieldRef<Model, FieldType> = runtime.FieldRef<Model, FieldType>;
type FieldRefInputType<Model, FieldType> = Model extends never ? never : FieldRef<Model, FieldType>;
export declare const ModelName: {
    readonly User: "User";
    readonly Session: "Session";
    readonly Account: "Account";
    readonly Verification: "Verification";
    readonly Game: "Game";
    readonly GameSession: "GameSession";
    readonly GameSpin: "GameSpin";
    readonly GameProvider: "GameProvider";
    readonly GameLaunchLink: "GameLaunchLink";
    readonly Operator: "Operator";
    readonly OperatorInvitation: "OperatorInvitation";
    readonly Product: "Product";
    readonly Todo: "Todo";
    readonly Tournament: "Tournament";
    readonly TournamentGame: "TournamentGame";
    readonly TournamentParticipant: "TournamentParticipant";
    readonly TournamentGamePlay: "TournamentGamePlay";
    readonly TournamentReward: "TournamentReward";
    readonly Transaction: "Transaction";
    readonly RebateTransaction: "RebateTransaction";
    readonly Wallet: "Wallet";
    readonly UserProfile: "UserProfile";
};
export type ModelName = (typeof ModelName)[keyof typeof ModelName];
export interface TypeMapCb<ClientOptions = {}> extends runtime.Types.Utils.Fn<{
    extArgs: runtime.Types.Extensions.InternalArgs;
}, runtime.Types.Utils.Record<string, any>> {
    returns: TypeMap<this['params']['extArgs'], ClientOptions extends {
        omit: infer OmitOptions;
    } ? OmitOptions : {}>;
}
export type TypeMap<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> = {
    globalOmitOptions: {
        omit: GlobalOmitOptions;
    };
    meta: {
        modelProps: "user" | "session" | "account" | "verification" | "game" | "gameSession" | "gameSpin" | "gameProvider" | "gameLaunchLink" | "operator" | "operatorInvitation" | "product" | "todo" | "tournament" | "tournamentGame" | "tournamentParticipant" | "tournamentGamePlay" | "tournamentReward" | "transaction" | "rebateTransaction" | "wallet" | "userProfile";
        txIsolationLevel: TransactionIsolationLevel;
    };
    model: {
        User: {
            payload: Prisma.$UserPayload<ExtArgs>;
            fields: Prisma.UserFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.UserFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.UserFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>;
                };
                findFirst: {
                    args: Prisma.UserFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.UserFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>;
                };
                findMany: {
                    args: Prisma.UserFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>[];
                };
                create: {
                    args: Prisma.UserCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>;
                };
                createMany: {
                    args: Prisma.UserCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.UserCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>[];
                };
                delete: {
                    args: Prisma.UserDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>;
                };
                update: {
                    args: Prisma.UserUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>;
                };
                deleteMany: {
                    args: Prisma.UserDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.UserUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.UserUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>[];
                };
                upsert: {
                    args: Prisma.UserUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserPayload>;
                };
                aggregate: {
                    args: Prisma.UserAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateUser>;
                };
                groupBy: {
                    args: Prisma.UserGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.UserGroupByOutputType>[];
                };
                count: {
                    args: Prisma.UserCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.UserCountAggregateOutputType> | number;
                };
            };
        };
        Session: {
            payload: Prisma.$SessionPayload<ExtArgs>;
            fields: Prisma.SessionFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.SessionFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.SessionFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>;
                };
                findFirst: {
                    args: Prisma.SessionFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.SessionFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>;
                };
                findMany: {
                    args: Prisma.SessionFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>[];
                };
                create: {
                    args: Prisma.SessionCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>;
                };
                createMany: {
                    args: Prisma.SessionCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.SessionCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>[];
                };
                delete: {
                    args: Prisma.SessionDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>;
                };
                update: {
                    args: Prisma.SessionUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>;
                };
                deleteMany: {
                    args: Prisma.SessionDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.SessionUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.SessionUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>[];
                };
                upsert: {
                    args: Prisma.SessionUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$SessionPayload>;
                };
                aggregate: {
                    args: Prisma.SessionAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateSession>;
                };
                groupBy: {
                    args: Prisma.SessionGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.SessionGroupByOutputType>[];
                };
                count: {
                    args: Prisma.SessionCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.SessionCountAggregateOutputType> | number;
                };
            };
        };
        Account: {
            payload: Prisma.$AccountPayload<ExtArgs>;
            fields: Prisma.AccountFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.AccountFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.AccountFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>;
                };
                findFirst: {
                    args: Prisma.AccountFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.AccountFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>;
                };
                findMany: {
                    args: Prisma.AccountFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>[];
                };
                create: {
                    args: Prisma.AccountCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>;
                };
                createMany: {
                    args: Prisma.AccountCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.AccountCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>[];
                };
                delete: {
                    args: Prisma.AccountDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>;
                };
                update: {
                    args: Prisma.AccountUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>;
                };
                deleteMany: {
                    args: Prisma.AccountDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.AccountUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.AccountUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>[];
                };
                upsert: {
                    args: Prisma.AccountUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$AccountPayload>;
                };
                aggregate: {
                    args: Prisma.AccountAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateAccount>;
                };
                groupBy: {
                    args: Prisma.AccountGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AccountGroupByOutputType>[];
                };
                count: {
                    args: Prisma.AccountCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AccountCountAggregateOutputType> | number;
                };
            };
        };
        Verification: {
            payload: Prisma.$VerificationPayload<ExtArgs>;
            fields: Prisma.VerificationFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.VerificationFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.VerificationFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>;
                };
                findFirst: {
                    args: Prisma.VerificationFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.VerificationFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>;
                };
                findMany: {
                    args: Prisma.VerificationFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>[];
                };
                create: {
                    args: Prisma.VerificationCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>;
                };
                createMany: {
                    args: Prisma.VerificationCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.VerificationCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>[];
                };
                delete: {
                    args: Prisma.VerificationDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>;
                };
                update: {
                    args: Prisma.VerificationUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>;
                };
                deleteMany: {
                    args: Prisma.VerificationDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.VerificationUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.VerificationUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>[];
                };
                upsert: {
                    args: Prisma.VerificationUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$VerificationPayload>;
                };
                aggregate: {
                    args: Prisma.VerificationAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateVerification>;
                };
                groupBy: {
                    args: Prisma.VerificationGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.VerificationGroupByOutputType>[];
                };
                count: {
                    args: Prisma.VerificationCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.VerificationCountAggregateOutputType> | number;
                };
            };
        };
        Game: {
            payload: Prisma.$GamePayload<ExtArgs>;
            fields: Prisma.GameFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.GameFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.GameFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>;
                };
                findFirst: {
                    args: Prisma.GameFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.GameFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>;
                };
                findMany: {
                    args: Prisma.GameFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>[];
                };
                create: {
                    args: Prisma.GameCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>;
                };
                createMany: {
                    args: Prisma.GameCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.GameCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>[];
                };
                delete: {
                    args: Prisma.GameDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>;
                };
                update: {
                    args: Prisma.GameUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>;
                };
                deleteMany: {
                    args: Prisma.GameDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.GameUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.GameUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>[];
                };
                upsert: {
                    args: Prisma.GameUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GamePayload>;
                };
                aggregate: {
                    args: Prisma.GameAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateGame>;
                };
                groupBy: {
                    args: Prisma.GameGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameGroupByOutputType>[];
                };
                count: {
                    args: Prisma.GameCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameCountAggregateOutputType> | number;
                };
            };
        };
        GameSession: {
            payload: Prisma.$GameSessionPayload<ExtArgs>;
            fields: Prisma.GameSessionFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.GameSessionFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.GameSessionFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>;
                };
                findFirst: {
                    args: Prisma.GameSessionFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.GameSessionFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>;
                };
                findMany: {
                    args: Prisma.GameSessionFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>[];
                };
                create: {
                    args: Prisma.GameSessionCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>;
                };
                createMany: {
                    args: Prisma.GameSessionCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.GameSessionCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>[];
                };
                delete: {
                    args: Prisma.GameSessionDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>;
                };
                update: {
                    args: Prisma.GameSessionUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>;
                };
                deleteMany: {
                    args: Prisma.GameSessionDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.GameSessionUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.GameSessionUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>[];
                };
                upsert: {
                    args: Prisma.GameSessionUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSessionPayload>;
                };
                aggregate: {
                    args: Prisma.GameSessionAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateGameSession>;
                };
                groupBy: {
                    args: Prisma.GameSessionGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameSessionGroupByOutputType>[];
                };
                count: {
                    args: Prisma.GameSessionCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameSessionCountAggregateOutputType> | number;
                };
            };
        };
        GameSpin: {
            payload: Prisma.$GameSpinPayload<ExtArgs>;
            fields: Prisma.GameSpinFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.GameSpinFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.GameSpinFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>;
                };
                findFirst: {
                    args: Prisma.GameSpinFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.GameSpinFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>;
                };
                findMany: {
                    args: Prisma.GameSpinFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>[];
                };
                create: {
                    args: Prisma.GameSpinCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>;
                };
                createMany: {
                    args: Prisma.GameSpinCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.GameSpinCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>[];
                };
                delete: {
                    args: Prisma.GameSpinDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>;
                };
                update: {
                    args: Prisma.GameSpinUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>;
                };
                deleteMany: {
                    args: Prisma.GameSpinDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.GameSpinUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.GameSpinUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>[];
                };
                upsert: {
                    args: Prisma.GameSpinUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameSpinPayload>;
                };
                aggregate: {
                    args: Prisma.GameSpinAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateGameSpin>;
                };
                groupBy: {
                    args: Prisma.GameSpinGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameSpinGroupByOutputType>[];
                };
                count: {
                    args: Prisma.GameSpinCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameSpinCountAggregateOutputType> | number;
                };
            };
        };
        GameProvider: {
            payload: Prisma.$GameProviderPayload<ExtArgs>;
            fields: Prisma.GameProviderFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.GameProviderFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.GameProviderFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>;
                };
                findFirst: {
                    args: Prisma.GameProviderFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.GameProviderFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>;
                };
                findMany: {
                    args: Prisma.GameProviderFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>[];
                };
                create: {
                    args: Prisma.GameProviderCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>;
                };
                createMany: {
                    args: Prisma.GameProviderCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.GameProviderCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>[];
                };
                delete: {
                    args: Prisma.GameProviderDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>;
                };
                update: {
                    args: Prisma.GameProviderUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>;
                };
                deleteMany: {
                    args: Prisma.GameProviderDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.GameProviderUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.GameProviderUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>[];
                };
                upsert: {
                    args: Prisma.GameProviderUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameProviderPayload>;
                };
                aggregate: {
                    args: Prisma.GameProviderAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateGameProvider>;
                };
                groupBy: {
                    args: Prisma.GameProviderGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameProviderGroupByOutputType>[];
                };
                count: {
                    args: Prisma.GameProviderCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameProviderCountAggregateOutputType> | number;
                };
            };
        };
        GameLaunchLink: {
            payload: Prisma.$GameLaunchLinkPayload<ExtArgs>;
            fields: Prisma.GameLaunchLinkFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.GameLaunchLinkFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.GameLaunchLinkFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>;
                };
                findFirst: {
                    args: Prisma.GameLaunchLinkFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.GameLaunchLinkFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>;
                };
                findMany: {
                    args: Prisma.GameLaunchLinkFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>[];
                };
                create: {
                    args: Prisma.GameLaunchLinkCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>;
                };
                createMany: {
                    args: Prisma.GameLaunchLinkCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.GameLaunchLinkCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>[];
                };
                delete: {
                    args: Prisma.GameLaunchLinkDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>;
                };
                update: {
                    args: Prisma.GameLaunchLinkUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>;
                };
                deleteMany: {
                    args: Prisma.GameLaunchLinkDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.GameLaunchLinkUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.GameLaunchLinkUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>[];
                };
                upsert: {
                    args: Prisma.GameLaunchLinkUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$GameLaunchLinkPayload>;
                };
                aggregate: {
                    args: Prisma.GameLaunchLinkAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateGameLaunchLink>;
                };
                groupBy: {
                    args: Prisma.GameLaunchLinkGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameLaunchLinkGroupByOutputType>[];
                };
                count: {
                    args: Prisma.GameLaunchLinkCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.GameLaunchLinkCountAggregateOutputType> | number;
                };
            };
        };
        Operator: {
            payload: Prisma.$OperatorPayload<ExtArgs>;
            fields: Prisma.OperatorFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.OperatorFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.OperatorFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>;
                };
                findFirst: {
                    args: Prisma.OperatorFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.OperatorFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>;
                };
                findMany: {
                    args: Prisma.OperatorFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>[];
                };
                create: {
                    args: Prisma.OperatorCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>;
                };
                createMany: {
                    args: Prisma.OperatorCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.OperatorCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>[];
                };
                delete: {
                    args: Prisma.OperatorDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>;
                };
                update: {
                    args: Prisma.OperatorUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>;
                };
                deleteMany: {
                    args: Prisma.OperatorDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.OperatorUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.OperatorUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>[];
                };
                upsert: {
                    args: Prisma.OperatorUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorPayload>;
                };
                aggregate: {
                    args: Prisma.OperatorAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateOperator>;
                };
                groupBy: {
                    args: Prisma.OperatorGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.OperatorGroupByOutputType>[];
                };
                count: {
                    args: Prisma.OperatorCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.OperatorCountAggregateOutputType> | number;
                };
            };
        };
        OperatorInvitation: {
            payload: Prisma.$OperatorInvitationPayload<ExtArgs>;
            fields: Prisma.OperatorInvitationFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.OperatorInvitationFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.OperatorInvitationFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>;
                };
                findFirst: {
                    args: Prisma.OperatorInvitationFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.OperatorInvitationFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>;
                };
                findMany: {
                    args: Prisma.OperatorInvitationFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>[];
                };
                create: {
                    args: Prisma.OperatorInvitationCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>;
                };
                createMany: {
                    args: Prisma.OperatorInvitationCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.OperatorInvitationCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>[];
                };
                delete: {
                    args: Prisma.OperatorInvitationDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>;
                };
                update: {
                    args: Prisma.OperatorInvitationUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>;
                };
                deleteMany: {
                    args: Prisma.OperatorInvitationDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.OperatorInvitationUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.OperatorInvitationUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>[];
                };
                upsert: {
                    args: Prisma.OperatorInvitationUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$OperatorInvitationPayload>;
                };
                aggregate: {
                    args: Prisma.OperatorInvitationAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateOperatorInvitation>;
                };
                groupBy: {
                    args: Prisma.OperatorInvitationGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.OperatorInvitationGroupByOutputType>[];
                };
                count: {
                    args: Prisma.OperatorInvitationCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.OperatorInvitationCountAggregateOutputType> | number;
                };
            };
        };
        Product: {
            payload: Prisma.$ProductPayload<ExtArgs>;
            fields: Prisma.ProductFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.ProductFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.ProductFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>;
                };
                findFirst: {
                    args: Prisma.ProductFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.ProductFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>;
                };
                findMany: {
                    args: Prisma.ProductFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>[];
                };
                create: {
                    args: Prisma.ProductCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>;
                };
                createMany: {
                    args: Prisma.ProductCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.ProductCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>[];
                };
                delete: {
                    args: Prisma.ProductDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>;
                };
                update: {
                    args: Prisma.ProductUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>;
                };
                deleteMany: {
                    args: Prisma.ProductDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.ProductUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.ProductUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>[];
                };
                upsert: {
                    args: Prisma.ProductUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$ProductPayload>;
                };
                aggregate: {
                    args: Prisma.ProductAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateProduct>;
                };
                groupBy: {
                    args: Prisma.ProductGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.ProductGroupByOutputType>[];
                };
                count: {
                    args: Prisma.ProductCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.ProductCountAggregateOutputType> | number;
                };
            };
        };
        Todo: {
            payload: Prisma.$TodoPayload<ExtArgs>;
            fields: Prisma.TodoFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.TodoFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.TodoFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>;
                };
                findFirst: {
                    args: Prisma.TodoFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.TodoFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>;
                };
                findMany: {
                    args: Prisma.TodoFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>[];
                };
                create: {
                    args: Prisma.TodoCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>;
                };
                createMany: {
                    args: Prisma.TodoCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.TodoCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>[];
                };
                delete: {
                    args: Prisma.TodoDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>;
                };
                update: {
                    args: Prisma.TodoUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>;
                };
                deleteMany: {
                    args: Prisma.TodoDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.TodoUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.TodoUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>[];
                };
                upsert: {
                    args: Prisma.TodoUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TodoPayload>;
                };
                aggregate: {
                    args: Prisma.TodoAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateTodo>;
                };
                groupBy: {
                    args: Prisma.TodoGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TodoGroupByOutputType>[];
                };
                count: {
                    args: Prisma.TodoCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TodoCountAggregateOutputType> | number;
                };
            };
        };
        Tournament: {
            payload: Prisma.$TournamentPayload<ExtArgs>;
            fields: Prisma.TournamentFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.TournamentFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.TournamentFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>;
                };
                findFirst: {
                    args: Prisma.TournamentFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.TournamentFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>;
                };
                findMany: {
                    args: Prisma.TournamentFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>[];
                };
                create: {
                    args: Prisma.TournamentCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>;
                };
                createMany: {
                    args: Prisma.TournamentCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.TournamentCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>[];
                };
                delete: {
                    args: Prisma.TournamentDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>;
                };
                update: {
                    args: Prisma.TournamentUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>;
                };
                deleteMany: {
                    args: Prisma.TournamentDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.TournamentUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.TournamentUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>[];
                };
                upsert: {
                    args: Prisma.TournamentUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentPayload>;
                };
                aggregate: {
                    args: Prisma.TournamentAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateTournament>;
                };
                groupBy: {
                    args: Prisma.TournamentGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentGroupByOutputType>[];
                };
                count: {
                    args: Prisma.TournamentCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentCountAggregateOutputType> | number;
                };
            };
        };
        TournamentGame: {
            payload: Prisma.$TournamentGamePayload<ExtArgs>;
            fields: Prisma.TournamentGameFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.TournamentGameFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.TournamentGameFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>;
                };
                findFirst: {
                    args: Prisma.TournamentGameFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.TournamentGameFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>;
                };
                findMany: {
                    args: Prisma.TournamentGameFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>[];
                };
                create: {
                    args: Prisma.TournamentGameCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>;
                };
                createMany: {
                    args: Prisma.TournamentGameCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.TournamentGameCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>[];
                };
                delete: {
                    args: Prisma.TournamentGameDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>;
                };
                update: {
                    args: Prisma.TournamentGameUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>;
                };
                deleteMany: {
                    args: Prisma.TournamentGameDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.TournamentGameUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.TournamentGameUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>[];
                };
                upsert: {
                    args: Prisma.TournamentGameUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePayload>;
                };
                aggregate: {
                    args: Prisma.TournamentGameAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateTournamentGame>;
                };
                groupBy: {
                    args: Prisma.TournamentGameGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentGameGroupByOutputType>[];
                };
                count: {
                    args: Prisma.TournamentGameCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentGameCountAggregateOutputType> | number;
                };
            };
        };
        TournamentParticipant: {
            payload: Prisma.$TournamentParticipantPayload<ExtArgs>;
            fields: Prisma.TournamentParticipantFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.TournamentParticipantFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.TournamentParticipantFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>;
                };
                findFirst: {
                    args: Prisma.TournamentParticipantFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.TournamentParticipantFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>;
                };
                findMany: {
                    args: Prisma.TournamentParticipantFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>[];
                };
                create: {
                    args: Prisma.TournamentParticipantCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>;
                };
                createMany: {
                    args: Prisma.TournamentParticipantCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.TournamentParticipantCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>[];
                };
                delete: {
                    args: Prisma.TournamentParticipantDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>;
                };
                update: {
                    args: Prisma.TournamentParticipantUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>;
                };
                deleteMany: {
                    args: Prisma.TournamentParticipantDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.TournamentParticipantUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.TournamentParticipantUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>[];
                };
                upsert: {
                    args: Prisma.TournamentParticipantUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentParticipantPayload>;
                };
                aggregate: {
                    args: Prisma.TournamentParticipantAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateTournamentParticipant>;
                };
                groupBy: {
                    args: Prisma.TournamentParticipantGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentParticipantGroupByOutputType>[];
                };
                count: {
                    args: Prisma.TournamentParticipantCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentParticipantCountAggregateOutputType> | number;
                };
            };
        };
        TournamentGamePlay: {
            payload: Prisma.$TournamentGamePlayPayload<ExtArgs>;
            fields: Prisma.TournamentGamePlayFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.TournamentGamePlayFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.TournamentGamePlayFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>;
                };
                findFirst: {
                    args: Prisma.TournamentGamePlayFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.TournamentGamePlayFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>;
                };
                findMany: {
                    args: Prisma.TournamentGamePlayFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>[];
                };
                create: {
                    args: Prisma.TournamentGamePlayCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>;
                };
                createMany: {
                    args: Prisma.TournamentGamePlayCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.TournamentGamePlayCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>[];
                };
                delete: {
                    args: Prisma.TournamentGamePlayDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>;
                };
                update: {
                    args: Prisma.TournamentGamePlayUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>;
                };
                deleteMany: {
                    args: Prisma.TournamentGamePlayDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.TournamentGamePlayUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.TournamentGamePlayUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>[];
                };
                upsert: {
                    args: Prisma.TournamentGamePlayUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentGamePlayPayload>;
                };
                aggregate: {
                    args: Prisma.TournamentGamePlayAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateTournamentGamePlay>;
                };
                groupBy: {
                    args: Prisma.TournamentGamePlayGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentGamePlayGroupByOutputType>[];
                };
                count: {
                    args: Prisma.TournamentGamePlayCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentGamePlayCountAggregateOutputType> | number;
                };
            };
        };
        TournamentReward: {
            payload: Prisma.$TournamentRewardPayload<ExtArgs>;
            fields: Prisma.TournamentRewardFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.TournamentRewardFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.TournamentRewardFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>;
                };
                findFirst: {
                    args: Prisma.TournamentRewardFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.TournamentRewardFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>;
                };
                findMany: {
                    args: Prisma.TournamentRewardFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>[];
                };
                create: {
                    args: Prisma.TournamentRewardCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>;
                };
                createMany: {
                    args: Prisma.TournamentRewardCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.TournamentRewardCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>[];
                };
                delete: {
                    args: Prisma.TournamentRewardDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>;
                };
                update: {
                    args: Prisma.TournamentRewardUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>;
                };
                deleteMany: {
                    args: Prisma.TournamentRewardDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.TournamentRewardUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.TournamentRewardUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>[];
                };
                upsert: {
                    args: Prisma.TournamentRewardUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TournamentRewardPayload>;
                };
                aggregate: {
                    args: Prisma.TournamentRewardAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateTournamentReward>;
                };
                groupBy: {
                    args: Prisma.TournamentRewardGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentRewardGroupByOutputType>[];
                };
                count: {
                    args: Prisma.TournamentRewardCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TournamentRewardCountAggregateOutputType> | number;
                };
            };
        };
        Transaction: {
            payload: Prisma.$TransactionPayload<ExtArgs>;
            fields: Prisma.TransactionFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.TransactionFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.TransactionFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>;
                };
                findFirst: {
                    args: Prisma.TransactionFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.TransactionFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>;
                };
                findMany: {
                    args: Prisma.TransactionFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>[];
                };
                create: {
                    args: Prisma.TransactionCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>;
                };
                createMany: {
                    args: Prisma.TransactionCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.TransactionCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>[];
                };
                delete: {
                    args: Prisma.TransactionDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>;
                };
                update: {
                    args: Prisma.TransactionUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>;
                };
                deleteMany: {
                    args: Prisma.TransactionDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.TransactionUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.TransactionUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>[];
                };
                upsert: {
                    args: Prisma.TransactionUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$TransactionPayload>;
                };
                aggregate: {
                    args: Prisma.TransactionAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateTransaction>;
                };
                groupBy: {
                    args: Prisma.TransactionGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TransactionGroupByOutputType>[];
                };
                count: {
                    args: Prisma.TransactionCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.TransactionCountAggregateOutputType> | number;
                };
            };
        };
        RebateTransaction: {
            payload: Prisma.$RebateTransactionPayload<ExtArgs>;
            fields: Prisma.RebateTransactionFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.RebateTransactionFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.RebateTransactionFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>;
                };
                findFirst: {
                    args: Prisma.RebateTransactionFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.RebateTransactionFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>;
                };
                findMany: {
                    args: Prisma.RebateTransactionFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>[];
                };
                create: {
                    args: Prisma.RebateTransactionCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>;
                };
                createMany: {
                    args: Prisma.RebateTransactionCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.RebateTransactionCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>[];
                };
                delete: {
                    args: Prisma.RebateTransactionDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>;
                };
                update: {
                    args: Prisma.RebateTransactionUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>;
                };
                deleteMany: {
                    args: Prisma.RebateTransactionDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.RebateTransactionUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.RebateTransactionUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>[];
                };
                upsert: {
                    args: Prisma.RebateTransactionUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$RebateTransactionPayload>;
                };
                aggregate: {
                    args: Prisma.RebateTransactionAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateRebateTransaction>;
                };
                groupBy: {
                    args: Prisma.RebateTransactionGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.RebateTransactionGroupByOutputType>[];
                };
                count: {
                    args: Prisma.RebateTransactionCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.RebateTransactionCountAggregateOutputType> | number;
                };
            };
        };
        Wallet: {
            payload: Prisma.$WalletPayload<ExtArgs>;
            fields: Prisma.WalletFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.WalletFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.WalletFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>;
                };
                findFirst: {
                    args: Prisma.WalletFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.WalletFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>;
                };
                findMany: {
                    args: Prisma.WalletFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>[];
                };
                create: {
                    args: Prisma.WalletCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>;
                };
                createMany: {
                    args: Prisma.WalletCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.WalletCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>[];
                };
                delete: {
                    args: Prisma.WalletDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>;
                };
                update: {
                    args: Prisma.WalletUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>;
                };
                deleteMany: {
                    args: Prisma.WalletDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.WalletUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.WalletUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>[];
                };
                upsert: {
                    args: Prisma.WalletUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$WalletPayload>;
                };
                aggregate: {
                    args: Prisma.WalletAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateWallet>;
                };
                groupBy: {
                    args: Prisma.WalletGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.WalletGroupByOutputType>[];
                };
                count: {
                    args: Prisma.WalletCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.WalletCountAggregateOutputType> | number;
                };
            };
        };
        UserProfile: {
            payload: Prisma.$UserProfilePayload<ExtArgs>;
            fields: Prisma.UserProfileFieldRefs;
            operations: {
                findUnique: {
                    args: Prisma.UserProfileFindUniqueArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload> | null;
                };
                findUniqueOrThrow: {
                    args: Prisma.UserProfileFindUniqueOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>;
                };
                findFirst: {
                    args: Prisma.UserProfileFindFirstArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload> | null;
                };
                findFirstOrThrow: {
                    args: Prisma.UserProfileFindFirstOrThrowArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>;
                };
                findMany: {
                    args: Prisma.UserProfileFindManyArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>[];
                };
                create: {
                    args: Prisma.UserProfileCreateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>;
                };
                createMany: {
                    args: Prisma.UserProfileCreateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                createManyAndReturn: {
                    args: Prisma.UserProfileCreateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>[];
                };
                delete: {
                    args: Prisma.UserProfileDeleteArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>;
                };
                update: {
                    args: Prisma.UserProfileUpdateArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>;
                };
                deleteMany: {
                    args: Prisma.UserProfileDeleteManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateMany: {
                    args: Prisma.UserProfileUpdateManyArgs<ExtArgs>;
                    result: BatchPayload;
                };
                updateManyAndReturn: {
                    args: Prisma.UserProfileUpdateManyAndReturnArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>[];
                };
                upsert: {
                    args: Prisma.UserProfileUpsertArgs<ExtArgs>;
                    result: runtime.Types.Utils.PayloadToResult<Prisma.$UserProfilePayload>;
                };
                aggregate: {
                    args: Prisma.UserProfileAggregateArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.AggregateUserProfile>;
                };
                groupBy: {
                    args: Prisma.UserProfileGroupByArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.UserProfileGroupByOutputType>[];
                };
                count: {
                    args: Prisma.UserProfileCountArgs<ExtArgs>;
                    result: runtime.Types.Utils.Optional<Prisma.UserProfileCountAggregateOutputType> | number;
                };
            };
        };
    };
} & {
    other: {
        payload: any;
        operations: {
            $executeRaw: {
                args: [query: TemplateStringsArray | Sql, ...values: any[]];
                result: any;
            };
            $executeRawUnsafe: {
                args: [query: string, ...values: any[]];
                result: any;
            };
            $queryRaw: {
                args: [query: TemplateStringsArray | Sql, ...values: any[]];
                result: any;
            };
            $queryRawUnsafe: {
                args: [query: string, ...values: any[]];
                result: any;
            };
        };
    };
};
/**
 * Enums
 */
export declare const TransactionIsolationLevel: {
    readonly ReadUncommitted: "ReadUncommitted";
    readonly ReadCommitted: "ReadCommitted";
    readonly RepeatableRead: "RepeatableRead";
    readonly Serializable: "Serializable";
};
export type TransactionIsolationLevel = (typeof TransactionIsolationLevel)[keyof typeof TransactionIsolationLevel];
export declare const UserScalarFieldEnum: {
    readonly id: "id";
    readonly name: "name";
    readonly username: "username";
    readonly displayUsername: "displayUsername";
    readonly email: "email";
    readonly emailVerified: "emailVerified";
    readonly image: "image";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
};
export type UserScalarFieldEnum = (typeof UserScalarFieldEnum)[keyof typeof UserScalarFieldEnum];
export declare const SessionScalarFieldEnum: {
    readonly id: "id";
    readonly expiresAt: "expiresAt";
    readonly token: "token";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly ipAddress: "ipAddress";
    readonly userAgent: "userAgent";
    readonly userId: "userId";
};
export type SessionScalarFieldEnum = (typeof SessionScalarFieldEnum)[keyof typeof SessionScalarFieldEnum];
export declare const AccountScalarFieldEnum: {
    readonly id: "id";
    readonly accountId: "accountId";
    readonly providerId: "providerId";
    readonly userId: "userId";
    readonly accessToken: "accessToken";
    readonly refreshToken: "refreshToken";
    readonly idToken: "idToken";
    readonly accessTokenExpiresAt: "accessTokenExpiresAt";
    readonly refreshTokenExpiresAt: "refreshTokenExpiresAt";
    readonly scope: "scope";
    readonly password: "password";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
};
export type AccountScalarFieldEnum = (typeof AccountScalarFieldEnum)[keyof typeof AccountScalarFieldEnum];
export declare const VerificationScalarFieldEnum: {
    readonly id: "id";
    readonly identifier: "identifier";
    readonly value: "value";
    readonly expiresAt: "expiresAt";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
};
export type VerificationScalarFieldEnum = (typeof VerificationScalarFieldEnum)[keyof typeof VerificationScalarFieldEnum];
export declare const GameScalarFieldEnum: {
    readonly id: "id";
    readonly name: "name";
    readonly title: "title";
    readonly goldsvetData: "goldsvetData";
    readonly description: "description";
    readonly supportedProviders: "supportedProviders";
    readonly category: "category";
    readonly tags: "tags";
    readonly isActive: "isActive";
    readonly thumbnailUrl: "thumbnailUrl";
    readonly bannerUrl: "bannerUrl";
    readonly meta: "meta";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly featured: "featured";
    readonly providerName: "providerName";
    readonly totalWagered: "totalWagered";
    readonly gameProviderId: "gameProviderId";
    readonly operatorId: "operatorId";
};
export type GameScalarFieldEnum = (typeof GameScalarFieldEnum)[keyof typeof GameScalarFieldEnum];
export declare const GameSessionScalarFieldEnum: {
    readonly id: "id";
    readonly isActive: "isActive";
    readonly sessionData: "sessionData";
    readonly authSessionId: "authSessionId";
    readonly currencyId: "currencyId";
    readonly startedAt: "startedAt";
    readonly endTime: "endTime";
    readonly startTime: "startTime";
    readonly ipAddress: "ipAddress";
    readonly startingBalance: "startingBalance";
    readonly startingTotalXp: "startingTotalXp";
    readonly userAgent: "userAgent";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly totalWagered: "totalWagered";
    readonly totalWon: "totalWon";
    readonly userId: "userId";
    readonly gameId: "gameId";
    readonly rtgToken: "rtgToken";
    readonly rtgFingerPrint: "rtgFingerPrint";
    readonly profileId: "profileId";
};
export type GameSessionScalarFieldEnum = (typeof GameSessionScalarFieldEnum)[keyof typeof GameSessionScalarFieldEnum];
export declare const GameSpinScalarFieldEnum: {
    readonly id: "id";
    readonly spinData: "spinData";
    readonly createdAt: "createdAt";
    readonly grossWinAmount: "grossWinAmount";
    readonly currencyId: "currencyId";
    readonly spinNumber: "spinNumber";
    readonly gameSessionId: "gameSessionId";
    readonly wagerAmount: "wagerAmount";
    readonly sessionId: "sessionId";
    readonly timeStamp: "timeStamp";
};
export type GameSpinScalarFieldEnum = (typeof GameSpinScalarFieldEnum)[keyof typeof GameSpinScalarFieldEnum];
export declare const GameProviderScalarFieldEnum: {
    readonly id: "id";
    readonly name: "name";
    readonly displayName: "displayName";
    readonly rgsBaseUrl: "rgsBaseUrl";
    readonly settingsPath: "settingsPath";
    readonly spinPath: "spinPath";
    readonly resolveBetPath: "resolveBetPath";
    readonly providerRoundId: "providerRoundId";
    readonly authType: "authType";
    readonly apiKey: "apiKey";
    readonly apiSecret: "apiSecret";
    readonly publicKey: "publicKey";
    readonly privateKeyRef: "privateKeyRef";
    readonly configJson: "configJson";
    readonly isActive: "isActive";
    readonly notes: "notes";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
};
export type GameProviderScalarFieldEnum = (typeof GameProviderScalarFieldEnum)[keyof typeof GameProviderScalarFieldEnum];
export declare const GameLaunchLinkScalarFieldEnum: {
    readonly id: "id";
    readonly token_internal: "token_internal";
    readonly currency: "currency";
    readonly player_operator_id: "player_operator_id";
    readonly mode: "mode";
    readonly meta: "meta";
    readonly requestIp: "requestIp";
    readonly userAgent: "userAgent";
    readonly session_url: "session_url";
    readonly state: "state";
    readonly active: "active";
    readonly expiresAt: "expiresAt";
    readonly extra_meta: "extra_meta";
    readonly token_original: "token_original";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly userId: "userId";
    readonly gameId: "gameId";
    readonly operatorId: "operatorId";
    readonly userProfileId: "userProfileId";
};
export type GameLaunchLinkScalarFieldEnum = (typeof GameLaunchLinkScalarFieldEnum)[keyof typeof GameLaunchLinkScalarFieldEnum];
export declare const OperatorScalarFieldEnum: {
    readonly id: "id";
    readonly name: "name";
    readonly operator_secret: "operator_secret";
    readonly operator_access: "operator_access";
    readonly callbackUrl: "callbackUrl";
    readonly active: "active";
    readonly permissions: "permissions";
    readonly ips: "ips";
    readonly description: "description";
    readonly lastUsedAt: "lastUsedAt";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly ownerId: "ownerId";
    readonly acceptedPayments: "acceptedPayments";
};
export type OperatorScalarFieldEnum = (typeof OperatorScalarFieldEnum)[keyof typeof OperatorScalarFieldEnum];
export declare const OperatorInvitationScalarFieldEnum: {
    readonly id: "id";
    readonly operatorId: "operatorId";
    readonly username: "username";
    readonly role: "role";
    readonly token: "token";
    readonly expiresAt: "expiresAt";
    readonly acceptedAt: "acceptedAt";
    readonly invitedById: "invitedById";
    readonly userProfileId: "userProfileId";
};
export type OperatorInvitationScalarFieldEnum = (typeof OperatorInvitationScalarFieldEnum)[keyof typeof OperatorInvitationScalarFieldEnum];
export declare const ProductScalarFieldEnum: {
    readonly id: "id";
    readonly title: "title";
    readonly description: "description";
    readonly url: "url";
    readonly iconUrl: "iconUrl";
    readonly productType: "productType";
    readonly bonusCode: "bonusCode";
    readonly bonusTotalInCredits: "bonusTotalInCredits";
    readonly isActive: "isActive";
    readonly priceInCents: "priceInCents";
    readonly amountToReceiveInCredits: "amountToReceiveInCredits";
    readonly bestValue: "bestValue";
    readonly discountInCents: "discountInCents";
    readonly bonusSpins: "bonusSpins";
    readonly isPromo: "isPromo";
    readonly totalDiscountInCents: "totalDiscountInCents";
    readonly shopId: "shopId";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly transactionId: "transactionId";
};
export type ProductScalarFieldEnum = (typeof ProductScalarFieldEnum)[keyof typeof ProductScalarFieldEnum];
export declare const TodoScalarFieldEnum: {
    readonly id: "id";
    readonly text: "text";
    readonly completed: "completed";
};
export type TodoScalarFieldEnum = (typeof TodoScalarFieldEnum)[keyof typeof TodoScalarFieldEnum];
export declare const TournamentScalarFieldEnum: {
    readonly id: "id";
    readonly name: "name";
    readonly description: "description";
    readonly startTime: "startTime";
    readonly endTime: "endTime";
    readonly targetScore: "targetScore";
    readonly status: "status";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly createdByid: "createdByid";
    readonly userId: "userId";
};
export type TournamentScalarFieldEnum = (typeof TournamentScalarFieldEnum)[keyof typeof TournamentScalarFieldEnum];
export declare const TournamentGameScalarFieldEnum: {
    readonly id: "id";
    readonly tournamentId: "tournamentId";
    readonly gameId: "gameId";
    readonly pointMultiplier: "pointMultiplier";
};
export type TournamentGameScalarFieldEnum = (typeof TournamentGameScalarFieldEnum)[keyof typeof TournamentGameScalarFieldEnum];
export declare const TournamentParticipantScalarFieldEnum: {
    readonly id: "id";
    readonly tournamentId: "tournamentId";
    readonly userId: "userId";
    readonly score: "score";
    readonly rank: "rank";
    readonly joinedAt: "joinedAt";
};
export type TournamentParticipantScalarFieldEnum = (typeof TournamentParticipantScalarFieldEnum)[keyof typeof TournamentParticipantScalarFieldEnum];
export declare const TournamentGamePlayScalarFieldEnum: {
    readonly id: "id";
    readonly tournamentParticipantId: "tournamentParticipantId";
    readonly gameId: "gameId";
    readonly pointsEarned: "pointsEarned";
    readonly playedAt: "playedAt";
    readonly gameSessionId: "gameSessionId";
};
export type TournamentGamePlayScalarFieldEnum = (typeof TournamentGamePlayScalarFieldEnum)[keyof typeof TournamentGamePlayScalarFieldEnum];
export declare const TournamentRewardScalarFieldEnum: {
    readonly id: "id";
    readonly tournamentId: "tournamentId";
    readonly rank: "rank";
    readonly description: "description";
    readonly isClaimed: "isClaimed";
    readonly winnerId: "winnerId";
};
export type TournamentRewardScalarFieldEnum = (typeof TournamentRewardScalarFieldEnum)[keyof typeof TournamentRewardScalarFieldEnum];
export declare const TransactionScalarFieldEnum: {
    readonly id: "id";
    readonly processedAt: "processedAt";
    readonly walletId: "walletId";
    readonly type: "type";
    readonly status: "status";
    readonly amount: "amount";
    readonly netAmount: "netAmount";
    readonly feeAmount: "feeAmount";
    readonly productId: "productId";
    readonly paymentMethod: "paymentMethod";
    readonly balanceBefore: "balanceBefore";
    readonly balanceAfter: "balanceAfter";
    readonly bonusBalanceBefore: "bonusBalanceBefore";
    readonly bonusBalanceAfter: "bonusBalanceAfter";
    readonly bonusAmount: "bonusAmount";
    readonly wageringRequirement: "wageringRequirement";
    readonly wageringProgress: "wageringProgress";
    readonly description: "description";
    readonly provider: "provider";
    readonly providerTxId: "providerTxId";
    readonly relatedGameId: "relatedGameId";
    readonly relatedRoundId: "relatedRoundId";
    readonly metadata: "metadata";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly userProfileId: "userProfileId";
    readonly operatorId: "operatorId";
};
export type TransactionScalarFieldEnum = (typeof TransactionScalarFieldEnum)[keyof typeof TransactionScalarFieldEnum];
export declare const RebateTransactionScalarFieldEnum: {
    readonly id: "id";
    readonly userId: "userId";
    readonly transactionId: "transactionId";
    readonly rebateAmount: "rebateAmount";
    readonly currencyId: "currencyId";
    readonly vipLevel: "vipLevel";
    readonly rebatePercentage: "rebatePercentage";
    readonly status: "status";
    readonly paidOutAt: "paidOutAt";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
};
export type RebateTransactionScalarFieldEnum = (typeof RebateTransactionScalarFieldEnum)[keyof typeof RebateTransactionScalarFieldEnum];
export declare const WalletScalarFieldEnum: {
    readonly id: "id";
    readonly balance: "balance";
    readonly isActive: "isActive";
    readonly address: "address";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly userId: "userId";
    readonly operatorId: "operatorId";
    readonly paymentMethod: "paymentMethod";
    readonly bonusBalance: "bonusBalance";
    readonly lockedBalance: "lockedBalance";
};
export type WalletScalarFieldEnum = (typeof WalletScalarFieldEnum)[keyof typeof WalletScalarFieldEnum];
export declare const UserProfileScalarFieldEnum: {
    readonly id: "id";
    readonly createdAt: "createdAt";
    readonly updatedAt: "updatedAt";
    readonly username: "username";
    readonly avatar: "avatar";
    readonly balance: "balance";
    readonly totalXpFromOperator: "totalXpFromOperator";
    readonly activeCurrencyType: "activeCurrencyType";
    readonly userId: "userId";
    readonly isActive: "isActive";
    readonly otherUserid: "otherUserid";
    readonly role: "role";
    readonly operatorId: "operatorId";
    readonly currentGameSessionid: "currentGameSessionid";
};
export type UserProfileScalarFieldEnum = (typeof UserProfileScalarFieldEnum)[keyof typeof UserProfileScalarFieldEnum];
export declare const SortOrder: {
    readonly asc: "asc";
    readonly desc: "desc";
};
export type SortOrder = (typeof SortOrder)[keyof typeof SortOrder];
export declare const NullableJsonNullValueInput: {
    readonly DbNull: {
        "__#97@#private": any;
        _getNamespace(): string;
        _getName(): string;
        toString(): string;
    };
    readonly JsonNull: {
        "__#98@#private": any;
        _getNamespace(): string;
        _getName(): string;
        toString(): string;
    };
};
export type NullableJsonNullValueInput = (typeof NullableJsonNullValueInput)[keyof typeof NullableJsonNullValueInput];
export declare const QueryMode: {
    readonly default: "default";
    readonly insensitive: "insensitive";
};
export type QueryMode = (typeof QueryMode)[keyof typeof QueryMode];
export declare const NullsOrder: {
    readonly first: "first";
    readonly last: "last";
};
export type NullsOrder = (typeof NullsOrder)[keyof typeof NullsOrder];
export declare const JsonNullValueFilter: {
    readonly DbNull: {
        "__#97@#private": any;
        _getNamespace(): string;
        _getName(): string;
        toString(): string;
    };
    readonly JsonNull: {
        "__#98@#private": any;
        _getNamespace(): string;
        _getName(): string;
        toString(): string;
    };
    readonly AnyNull: {
        "__#96@#private": any;
        _getNamespace(): string;
        _getName(): string;
        toString(): string;
    };
};
export type JsonNullValueFilter = (typeof JsonNullValueFilter)[keyof typeof JsonNullValueFilter];
/**
 * Field references
 */
/**
 * Reference to a field of type 'String'
 */
export type StringFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'String'>;
/**
 * Reference to a field of type 'String[]'
 */
export type ListStringFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'String[]'>;
/**
 * Reference to a field of type 'Boolean'
 */
export type BooleanFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Boolean'>;
/**
 * Reference to a field of type 'DateTime'
 */
export type DateTimeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'DateTime'>;
/**
 * Reference to a field of type 'DateTime[]'
 */
export type ListDateTimeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'DateTime[]'>;
/**
 * Reference to a field of type 'Json'
 */
export type JsonFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Json'>;
/**
 * Reference to a field of type 'QueryMode'
 */
export type EnumQueryModeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'QueryMode'>;
/**
 * Reference to a field of type 'GameProviderName[]'
 */
export type ListEnumGameProviderNameFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'GameProviderName[]'>;
/**
 * Reference to a field of type 'GameProviderName'
 */
export type EnumGameProviderNameFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'GameProviderName'>;
/**
 * Reference to a field of type 'GameCategory'
 */
export type EnumGameCategoryFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'GameCategory'>;
/**
 * Reference to a field of type 'GameCategory[]'
 */
export type ListEnumGameCategoryFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'GameCategory[]'>;
/**
 * Reference to a field of type 'Int'
 */
export type IntFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Int'>;
/**
 * Reference to a field of type 'Int[]'
 */
export type ListIntFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Int[]'>;
/**
 * Reference to a field of type 'ProviderAuthType'
 */
export type EnumProviderAuthTypeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'ProviderAuthType'>;
/**
 * Reference to a field of type 'ProviderAuthType[]'
 */
export type ListEnumProviderAuthTypeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'ProviderAuthType[]'>;
/**
 * Reference to a field of type 'KeyMode[]'
 */
export type ListEnumKeyModeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'KeyMode[]'>;
/**
 * Reference to a field of type 'KeyMode'
 */
export type EnumKeyModeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'KeyMode'>;
/**
 * Reference to a field of type 'PaymentMethod[]'
 */
export type ListEnumPaymentMethodFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'PaymentMethod[]'>;
/**
 * Reference to a field of type 'PaymentMethod'
 */
export type EnumPaymentMethodFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'PaymentMethod'>;
/**
 * Reference to a field of type 'Role'
 */
export type EnumRoleFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Role'>;
/**
 * Reference to a field of type 'Role[]'
 */
export type ListEnumRoleFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Role[]'>;
/**
 * Reference to a field of type 'TournamentStatus'
 */
export type EnumTournamentStatusFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'TournamentStatus'>;
/**
 * Reference to a field of type 'TournamentStatus[]'
 */
export type ListEnumTournamentStatusFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'TournamentStatus[]'>;
/**
 * Reference to a field of type 'Float'
 */
export type FloatFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Float'>;
/**
 * Reference to a field of type 'Float[]'
 */
export type ListFloatFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'Float[]'>;
/**
 * Reference to a field of type 'TransactionType'
 */
export type EnumTransactionTypeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'TransactionType'>;
/**
 * Reference to a field of type 'TransactionType[]'
 */
export type ListEnumTransactionTypeFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'TransactionType[]'>;
/**
 * Reference to a field of type 'TransactionStatus'
 */
export type EnumTransactionStatusFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'TransactionStatus'>;
/**
 * Reference to a field of type 'TransactionStatus[]'
 */
export type ListEnumTransactionStatusFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'TransactionStatus[]'>;
/**
 * Reference to a field of type 'RewardStatus'
 */
export type EnumRewardStatusFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'RewardStatus'>;
/**
 * Reference to a field of type 'RewardStatus[]'
 */
export type ListEnumRewardStatusFieldRefInput<$PrismaModel> = FieldRefInputType<$PrismaModel, 'RewardStatus[]'>;
/**
 * Batch Payload for updateMany & deleteMany & createMany
 */
export type BatchPayload = {
    count: number;
};
export type Datasource = {
    url?: string;
};
export type Datasources = {
    db?: Datasource;
};
export declare const defineExtension: runtime.Types.Extensions.ExtendsHook<"define", TypeMapCb, runtime.Types.Extensions.DefaultArgs>;
export type DefaultPrismaClient = PrismaClient;
export type ErrorFormat = 'pretty' | 'colorless' | 'minimal';
export interface PrismaClientOptions {
    /**
     * Overwrites the datasource url from your schema.prisma file
     */
    datasources?: Datasources;
    /**
     * Overwrites the datasource url from your schema.prisma file
     */
    datasourceUrl?: string;
    /**
     * @default "colorless"
     */
    errorFormat?: ErrorFormat;
    /**
     * @example
     * ```
     * // Defaults to stdout
     * log: ['query', 'info', 'warn', 'error']
     *
     * // Emit as events
     * log: [
     *   { emit: 'stdout', level: 'query' },
     *   { emit: 'stdout', level: 'info' },
     *   { emit: 'stdout', level: 'warn' }
     *   { emit: 'stdout', level: 'error' }
     * ]
     * ```
     * Read more in our [docs](https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client/logging#the-log-option).
     */
    log?: (LogLevel | LogDefinition)[];
    /**
     * The default values for transactionOptions
     * maxWait ?= 2000
     * timeout ?= 5000
     */
    transactionOptions?: {
        maxWait?: number;
        timeout?: number;
        isolationLevel?: TransactionIsolationLevel;
    };
    /**
     * Global configuration for omitting model fields by default.
     *
     * @example
     * ```
     * const prisma = new PrismaClient({
     *   omit: {
     *     user: {
     *       password: true
     *     }
     *   }
     * })
     * ```
     */
    omit?: GlobalOmitConfig;
}
export type GlobalOmitConfig = {
    user?: Prisma.UserOmit;
    session?: Prisma.SessionOmit;
    account?: Prisma.AccountOmit;
    verification?: Prisma.VerificationOmit;
    game?: Prisma.GameOmit;
    gameSession?: Prisma.GameSessionOmit;
    gameSpin?: Prisma.GameSpinOmit;
    gameProvider?: Prisma.GameProviderOmit;
    gameLaunchLink?: Prisma.GameLaunchLinkOmit;
    operator?: Prisma.OperatorOmit;
    operatorInvitation?: Prisma.OperatorInvitationOmit;
    product?: Prisma.ProductOmit;
    todo?: Prisma.TodoOmit;
    tournament?: Prisma.TournamentOmit;
    tournamentGame?: Prisma.TournamentGameOmit;
    tournamentParticipant?: Prisma.TournamentParticipantOmit;
    tournamentGamePlay?: Prisma.TournamentGamePlayOmit;
    tournamentReward?: Prisma.TournamentRewardOmit;
    transaction?: Prisma.TransactionOmit;
    rebateTransaction?: Prisma.RebateTransactionOmit;
    wallet?: Prisma.WalletOmit;
    userProfile?: Prisma.UserProfileOmit;
};
export type LogLevel = 'info' | 'query' | 'warn' | 'error';
export type LogDefinition = {
    level: LogLevel;
    emit: 'stdout' | 'event';
};
export type GetLogType<T extends LogLevel | LogDefinition> = T extends LogDefinition ? T['emit'] extends 'event' ? T['level'] : never : never;
export type GetEvents<T extends any> = T extends Array<LogLevel | LogDefinition> ? GetLogType<T[0]> | GetLogType<T[1]> | GetLogType<T[2]> | GetLogType<T[3]> : never;
export type QueryEvent = {
    timestamp: Date;
    query: string;
    params: string;
    duration: number;
    target: string;
};
export type LogEvent = {
    timestamp: Date;
    message: string;
    target: string;
};
export type PrismaAction = 'findUnique' | 'findUniqueOrThrow' | 'findMany' | 'findFirst' | 'findFirstOrThrow' | 'create' | 'createMany' | 'createManyAndReturn' | 'update' | 'updateMany' | 'updateManyAndReturn' | 'upsert' | 'delete' | 'deleteMany' | 'executeRaw' | 'queryRaw' | 'aggregate' | 'count' | 'runCommandRaw' | 'findRaw' | 'groupBy';
/**
 * These options are being passed into the middleware as "params"
 */
export type MiddlewareParams = {
    model?: ModelName;
    action: PrismaAction;
    args: any;
    dataPath: string[];
    runInTransaction: boolean;
};
/**
 * The `T` type makes sure, that the `return proceed` is not forgotten in the middleware implementation
 */
export type Middleware<T = any> = (params: MiddlewareParams, next: (params: MiddlewareParams) => runtime.Types.Utils.JsPromise<T>) => runtime.Types.Utils.JsPromise<T>;
/**
 * `PrismaClient` proxy available in interactive transactions.
 */
export type TransactionClient = Omit<DefaultPrismaClient, runtime.ITXClientDenyList>;
