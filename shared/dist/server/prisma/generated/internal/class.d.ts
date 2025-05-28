/**
 * WARNING: This is an internal file that is subject to change!
 *
 * 🛑 Under no circumstances should you import this file directly! 🛑
 *
 * Please import the `PrismaClient` class from the `client.ts` file instead.
 */
import * as runtime from "@prisma/client/runtime/library";
import type * as Prisma from "./prismaNamespace.ts";
export type LogOptions<ClientOptions extends Prisma.PrismaClientOptions> = 'log' extends keyof ClientOptions ? ClientOptions['log'] extends Array<Prisma.LogLevel | Prisma.LogDefinition> ? Prisma.GetEvents<ClientOptions['log']> : never : never;
export interface PrismaClientConstructor {
    /**
   * ## Prisma Client
   *
   * Type-safe database client for TypeScript
   * @example
   * ```
   * const prisma = new PrismaClient()
   * // Fetch zero or more Users
   * const users = await prisma.user.findMany()
   * ```
   *
   * Read more in our [docs](https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client).
   */
    new <ClientOptions extends Prisma.PrismaClientOptions = Prisma.PrismaClientOptions, U = LogOptions<ClientOptions>, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs>(options?: Prisma.Subset<ClientOptions, Prisma.PrismaClientOptions>): PrismaClient<ClientOptions, U, ExtArgs>;
}
/**
 * ## Prisma Client
 *
 * Type-safe database client for TypeScript
 * @example
 * ```
 * const prisma = new PrismaClient()
 * // Fetch zero or more Users
 * const users = await prisma.user.findMany()
 * ```
 *
 * Read more in our [docs](https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client).
 */
export interface PrismaClient<ClientOptions extends Prisma.PrismaClientOptions = Prisma.PrismaClientOptions, U = LogOptions<ClientOptions>, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> {
    [K: symbol]: {
        types: Prisma.TypeMap<ExtArgs>['other'];
    };
    $on<V extends U>(eventType: V, callback: (event: V extends 'query' ? Prisma.QueryEvent : Prisma.LogEvent) => void): PrismaClient;
    /**
     * Connect with the database
     */
    $connect(): runtime.Types.Utils.JsPromise<void>;
    /**
     * Disconnect from the database
     */
    $disconnect(): runtime.Types.Utils.JsPromise<void>;
    /**
     * Add a middleware
     * @deprecated since 4.16.0. For new code, prefer client extensions instead.
     * @see https://pris.ly/d/extensions
     */
    $use(cb: Prisma.Middleware): void;
    /**
       * Executes a prepared raw query and returns the number of affected rows.
       * @example
       * ```
       * const result = await prisma.$executeRaw`UPDATE User SET cool = ${true} WHERE email = ${'user@email.com'};`
       * ```
       *
       * Read more in our [docs](https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client/raw-database-access).
       */
    $executeRaw<T = unknown>(query: TemplateStringsArray | Prisma.Sql, ...values: any[]): Prisma.PrismaPromise<number>;
    /**
     * Executes a raw query and returns the number of affected rows.
     * Susceptible to SQL injections, see documentation.
     * @example
     * ```
     * const result = await prisma.$executeRawUnsafe('UPDATE User SET cool = $1 WHERE email = $2 ;', true, 'user@email.com')
     * ```
     *
     * Read more in our [docs](https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client/raw-database-access).
     */
    $executeRawUnsafe<T = unknown>(query: string, ...values: any[]): Prisma.PrismaPromise<number>;
    /**
     * Performs a prepared raw query and returns the `SELECT` data.
     * @example
     * ```
     * const result = await prisma.$queryRaw`SELECT * FROM User WHERE id = ${1} OR email = ${'user@email.com'};`
     * ```
     *
     * Read more in our [docs](https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client/raw-database-access).
     */
    $queryRaw<T = unknown>(query: TemplateStringsArray | Prisma.Sql, ...values: any[]): Prisma.PrismaPromise<T>;
    /**
     * Performs a raw query and returns the `SELECT` data.
     * Susceptible to SQL injections, see documentation.
     * @example
     * ```
     * const result = await prisma.$queryRawUnsafe('SELECT * FROM User WHERE id = $1 OR email = $2;', 1, 'user@email.com')
     * ```
     *
     * Read more in our [docs](https://www.prisma.io/docs/reference/tools-and-interfaces/prisma-client/raw-database-access).
     */
    $queryRawUnsafe<T = unknown>(query: string, ...values: any[]): Prisma.PrismaPromise<T>;
    /**
     * Allows the running of a sequence of read/write operations that are guaranteed to either succeed or fail as a whole.
     * @example
     * ```
     * const [george, bob, alice] = await prisma.$transaction([
     *   prisma.user.create({ data: { name: 'George' } }),
     *   prisma.user.create({ data: { name: 'Bob' } }),
     *   prisma.user.create({ data: { name: 'Alice' } }),
     * ])
     * ```
     *
     * Read more in our [docs](https://www.prisma.io/docs/concepts/components/prisma-client/transactions).
     */
    $transaction<P extends Prisma.PrismaPromise<any>[]>(arg: [...P], options?: {
        isolationLevel?: Prisma.TransactionIsolationLevel;
    }): runtime.Types.Utils.JsPromise<runtime.Types.Utils.UnwrapTuple<P>>;
    $transaction<R>(fn: (prisma: Omit<PrismaClient, runtime.ITXClientDenyList>) => runtime.Types.Utils.JsPromise<R>, options?: {
        maxWait?: number;
        timeout?: number;
        isolationLevel?: Prisma.TransactionIsolationLevel;
    }): runtime.Types.Utils.JsPromise<R>;
    $extends: runtime.Types.Extensions.ExtendsHook<"extends", Prisma.TypeMapCb<ClientOptions>, ExtArgs, runtime.Types.Utils.Call<Prisma.TypeMapCb<ClientOptions>, {
        extArgs: ExtArgs;
    }>>;
    /**
 * `prisma.user`: Exposes CRUD operations for the **User** model.
  * Example usage:
  * ```ts
  * // Fetch zero or more Users
  * const users = await prisma.user.findMany()
  * ```
  */
    get user(): Prisma.UserDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.session`: Exposes CRUD operations for the **Session** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Sessions
      * const sessions = await prisma.session.findMany()
      * ```
      */
    get session(): Prisma.SessionDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.account`: Exposes CRUD operations for the **Account** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Accounts
      * const accounts = await prisma.account.findMany()
      * ```
      */
    get account(): Prisma.AccountDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.verification`: Exposes CRUD operations for the **Verification** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Verifications
      * const verifications = await prisma.verification.findMany()
      * ```
      */
    get verification(): Prisma.VerificationDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.game`: Exposes CRUD operations for the **Game** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Games
      * const games = await prisma.game.findMany()
      * ```
      */
    get game(): Prisma.GameDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.gameSession`: Exposes CRUD operations for the **GameSession** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more GameSessions
      * const gameSessions = await prisma.gameSession.findMany()
      * ```
      */
    get gameSession(): Prisma.GameSessionDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.gameSpin`: Exposes CRUD operations for the **GameSpin** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more GameSpins
      * const gameSpins = await prisma.gameSpin.findMany()
      * ```
      */
    get gameSpin(): Prisma.GameSpinDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.gameProvider`: Exposes CRUD operations for the **GameProvider** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more GameProviders
      * const gameProviders = await prisma.gameProvider.findMany()
      * ```
      */
    get gameProvider(): Prisma.GameProviderDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.gameLaunchLink`: Exposes CRUD operations for the **GameLaunchLink** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more GameLaunchLinks
      * const gameLaunchLinks = await prisma.gameLaunchLink.findMany()
      * ```
      */
    get gameLaunchLink(): Prisma.GameLaunchLinkDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.operator`: Exposes CRUD operations for the **Operator** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Operators
      * const operators = await prisma.operator.findMany()
      * ```
      */
    get operator(): Prisma.OperatorDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.operatorInvitation`: Exposes CRUD operations for the **OperatorInvitation** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more OperatorInvitations
      * const operatorInvitations = await prisma.operatorInvitation.findMany()
      * ```
      */
    get operatorInvitation(): Prisma.OperatorInvitationDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.product`: Exposes CRUD operations for the **Product** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Products
      * const products = await prisma.product.findMany()
      * ```
      */
    get product(): Prisma.ProductDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.todo`: Exposes CRUD operations for the **Todo** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Todos
      * const todos = await prisma.todo.findMany()
      * ```
      */
    get todo(): Prisma.TodoDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.tournament`: Exposes CRUD operations for the **Tournament** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Tournaments
      * const tournaments = await prisma.tournament.findMany()
      * ```
      */
    get tournament(): Prisma.TournamentDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.tournamentGame`: Exposes CRUD operations for the **TournamentGame** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more TournamentGames
      * const tournamentGames = await prisma.tournamentGame.findMany()
      * ```
      */
    get tournamentGame(): Prisma.TournamentGameDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.tournamentParticipant`: Exposes CRUD operations for the **TournamentParticipant** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more TournamentParticipants
      * const tournamentParticipants = await prisma.tournamentParticipant.findMany()
      * ```
      */
    get tournamentParticipant(): Prisma.TournamentParticipantDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.tournamentGamePlay`: Exposes CRUD operations for the **TournamentGamePlay** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more TournamentGamePlays
      * const tournamentGamePlays = await prisma.tournamentGamePlay.findMany()
      * ```
      */
    get tournamentGamePlay(): Prisma.TournamentGamePlayDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.tournamentReward`: Exposes CRUD operations for the **TournamentReward** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more TournamentRewards
      * const tournamentRewards = await prisma.tournamentReward.findMany()
      * ```
      */
    get tournamentReward(): Prisma.TournamentRewardDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.transaction`: Exposes CRUD operations for the **Transaction** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Transactions
      * const transactions = await prisma.transaction.findMany()
      * ```
      */
    get transaction(): Prisma.TransactionDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.rebateTransaction`: Exposes CRUD operations for the **RebateTransaction** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more RebateTransactions
      * const rebateTransactions = await prisma.rebateTransaction.findMany()
      * ```
      */
    get rebateTransaction(): Prisma.RebateTransactionDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.wallet`: Exposes CRUD operations for the **Wallet** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more Wallets
      * const wallets = await prisma.wallet.findMany()
      * ```
      */
    get wallet(): Prisma.WalletDelegate<ExtArgs, ClientOptions>;
    /**
     * `prisma.userProfile`: Exposes CRUD operations for the **UserProfile** model.
      * Example usage:
      * ```ts
      * // Fetch zero or more UserProfiles
      * const userProfiles = await prisma.userProfile.findMany()
      * ```
      */
    get userProfile(): Prisma.UserProfileDelegate<ExtArgs, ClientOptions>;
}
export declare function getPrismaClientClass(dirname: string): PrismaClientConstructor;
