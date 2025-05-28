/**
 * This file exports the `TournamentGame` model and its related types.
 *
 * 🟢 You can import this file directly.
 */
import * as runtime from "@prisma/client/runtime/library";
import type * as Prisma from "../internal/prismaNamespace.ts";
/**
 * Model TournamentGame
 *
 */
export type TournamentGameModel = runtime.Types.Result.DefaultSelection<Prisma.$TournamentGamePayload>;
export type AggregateTournamentGame = {
    _count: TournamentGameCountAggregateOutputType | null;
    _avg: TournamentGameAvgAggregateOutputType | null;
    _sum: TournamentGameSumAggregateOutputType | null;
    _min: TournamentGameMinAggregateOutputType | null;
    _max: TournamentGameMaxAggregateOutputType | null;
};
export type TournamentGameAvgAggregateOutputType = {
    pointMultiplier: number | null;
};
export type TournamentGameSumAggregateOutputType = {
    pointMultiplier: number | null;
};
export type TournamentGameMinAggregateOutputType = {
    id: string | null;
    tournamentId: string | null;
    gameId: string | null;
    pointMultiplier: number | null;
};
export type TournamentGameMaxAggregateOutputType = {
    id: string | null;
    tournamentId: string | null;
    gameId: string | null;
    pointMultiplier: number | null;
};
export type TournamentGameCountAggregateOutputType = {
    id: number;
    tournamentId: number;
    gameId: number;
    pointMultiplier: number;
    _all: number;
};
export type TournamentGameAvgAggregateInputType = {
    pointMultiplier?: true;
};
export type TournamentGameSumAggregateInputType = {
    pointMultiplier?: true;
};
export type TournamentGameMinAggregateInputType = {
    id?: true;
    tournamentId?: true;
    gameId?: true;
    pointMultiplier?: true;
};
export type TournamentGameMaxAggregateInputType = {
    id?: true;
    tournamentId?: true;
    gameId?: true;
    pointMultiplier?: true;
};
export type TournamentGameCountAggregateInputType = {
    id?: true;
    tournamentId?: true;
    gameId?: true;
    pointMultiplier?: true;
    _all?: true;
};
export type TournamentGameAggregateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Filter which TournamentGame to aggregate.
     */
    where?: Prisma.TournamentGameWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of TournamentGames to fetch.
     */
    orderBy?: Prisma.TournamentGameOrderByWithRelationInput | Prisma.TournamentGameOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the start position
     */
    cursor?: Prisma.TournamentGameWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` TournamentGames from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` TournamentGames.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Count returned TournamentGames
    **/
    _count?: true | TournamentGameCountAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to average
    **/
    _avg?: TournamentGameAvgAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to sum
    **/
    _sum?: TournamentGameSumAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to find the minimum value
    **/
    _min?: TournamentGameMinAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to find the maximum value
    **/
    _max?: TournamentGameMaxAggregateInputType;
};
export type GetTournamentGameAggregateType<T extends TournamentGameAggregateArgs> = {
    [P in keyof T & keyof AggregateTournamentGame]: P extends '_count' | 'count' ? T[P] extends true ? number : Prisma.GetScalarType<T[P], AggregateTournamentGame[P]> : Prisma.GetScalarType<T[P], AggregateTournamentGame[P]>;
};
export type TournamentGameGroupByArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.TournamentGameWhereInput;
    orderBy?: Prisma.TournamentGameOrderByWithAggregationInput | Prisma.TournamentGameOrderByWithAggregationInput[];
    by: Prisma.TournamentGameScalarFieldEnum[] | Prisma.TournamentGameScalarFieldEnum;
    having?: Prisma.TournamentGameScalarWhereWithAggregatesInput;
    take?: number;
    skip?: number;
    _count?: TournamentGameCountAggregateInputType | true;
    _avg?: TournamentGameAvgAggregateInputType;
    _sum?: TournamentGameSumAggregateInputType;
    _min?: TournamentGameMinAggregateInputType;
    _max?: TournamentGameMaxAggregateInputType;
};
export type TournamentGameGroupByOutputType = {
    id: string;
    tournamentId: string;
    gameId: string;
    pointMultiplier: number;
    _count: TournamentGameCountAggregateOutputType | null;
    _avg: TournamentGameAvgAggregateOutputType | null;
    _sum: TournamentGameSumAggregateOutputType | null;
    _min: TournamentGameMinAggregateOutputType | null;
    _max: TournamentGameMaxAggregateOutputType | null;
};
type GetTournamentGameGroupByPayload<T extends TournamentGameGroupByArgs> = Prisma.PrismaPromise<Array<Prisma.PickEnumerable<TournamentGameGroupByOutputType, T['by']> & {
    [P in ((keyof T) & (keyof TournamentGameGroupByOutputType))]: P extends '_count' ? T[P] extends boolean ? number : Prisma.GetScalarType<T[P], TournamentGameGroupByOutputType[P]> : Prisma.GetScalarType<T[P], TournamentGameGroupByOutputType[P]>;
}>>;
export type TournamentGameWhereInput = {
    AND?: Prisma.TournamentGameWhereInput | Prisma.TournamentGameWhereInput[];
    OR?: Prisma.TournamentGameWhereInput[];
    NOT?: Prisma.TournamentGameWhereInput | Prisma.TournamentGameWhereInput[];
    id?: Prisma.StringFilter<"TournamentGame"> | string;
    tournamentId?: Prisma.StringFilter<"TournamentGame"> | string;
    gameId?: Prisma.StringFilter<"TournamentGame"> | string;
    pointMultiplier?: Prisma.FloatFilter<"TournamentGame"> | number;
    tournament?: Prisma.XOR<Prisma.TournamentScalarRelationFilter, Prisma.TournamentWhereInput>;
    game?: Prisma.XOR<Prisma.GameScalarRelationFilter, Prisma.GameWhereInput>;
};
export type TournamentGameOrderByWithRelationInput = {
    id?: Prisma.SortOrder;
    tournamentId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    pointMultiplier?: Prisma.SortOrder;
    tournament?: Prisma.TournamentOrderByWithRelationInput;
    game?: Prisma.GameOrderByWithRelationInput;
};
export type TournamentGameWhereUniqueInput = Prisma.AtLeast<{
    id?: string;
    tournamentId_gameId?: Prisma.TournamentGameTournamentIdGameIdCompoundUniqueInput;
    AND?: Prisma.TournamentGameWhereInput | Prisma.TournamentGameWhereInput[];
    OR?: Prisma.TournamentGameWhereInput[];
    NOT?: Prisma.TournamentGameWhereInput | Prisma.TournamentGameWhereInput[];
    tournamentId?: Prisma.StringFilter<"TournamentGame"> | string;
    gameId?: Prisma.StringFilter<"TournamentGame"> | string;
    pointMultiplier?: Prisma.FloatFilter<"TournamentGame"> | number;
    tournament?: Prisma.XOR<Prisma.TournamentScalarRelationFilter, Prisma.TournamentWhereInput>;
    game?: Prisma.XOR<Prisma.GameScalarRelationFilter, Prisma.GameWhereInput>;
}, "id" | "tournamentId_gameId">;
export type TournamentGameOrderByWithAggregationInput = {
    id?: Prisma.SortOrder;
    tournamentId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    pointMultiplier?: Prisma.SortOrder;
    _count?: Prisma.TournamentGameCountOrderByAggregateInput;
    _avg?: Prisma.TournamentGameAvgOrderByAggregateInput;
    _max?: Prisma.TournamentGameMaxOrderByAggregateInput;
    _min?: Prisma.TournamentGameMinOrderByAggregateInput;
    _sum?: Prisma.TournamentGameSumOrderByAggregateInput;
};
export type TournamentGameScalarWhereWithAggregatesInput = {
    AND?: Prisma.TournamentGameScalarWhereWithAggregatesInput | Prisma.TournamentGameScalarWhereWithAggregatesInput[];
    OR?: Prisma.TournamentGameScalarWhereWithAggregatesInput[];
    NOT?: Prisma.TournamentGameScalarWhereWithAggregatesInput | Prisma.TournamentGameScalarWhereWithAggregatesInput[];
    id?: Prisma.StringWithAggregatesFilter<"TournamentGame"> | string;
    tournamentId?: Prisma.StringWithAggregatesFilter<"TournamentGame"> | string;
    gameId?: Prisma.StringWithAggregatesFilter<"TournamentGame"> | string;
    pointMultiplier?: Prisma.FloatWithAggregatesFilter<"TournamentGame"> | number;
};
export type TournamentGameCreateInput = {
    id?: string;
    pointMultiplier?: number;
    tournament: Prisma.TournamentCreateNestedOneWithoutEligibleGamesInput;
    game: Prisma.GameCreateNestedOneWithoutTournamentGameInput;
};
export type TournamentGameUncheckedCreateInput = {
    id?: string;
    tournamentId: string;
    gameId: string;
    pointMultiplier?: number;
};
export type TournamentGameUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
    tournament?: Prisma.TournamentUpdateOneRequiredWithoutEligibleGamesNestedInput;
    game?: Prisma.GameUpdateOneRequiredWithoutTournamentGameNestedInput;
};
export type TournamentGameUncheckedUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    tournamentId?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
};
export type TournamentGameCreateManyInput = {
    id?: string;
    tournamentId: string;
    gameId: string;
    pointMultiplier?: number;
};
export type TournamentGameUpdateManyMutationInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
};
export type TournamentGameUncheckedUpdateManyInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    tournamentId?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
};
export type TournamentGameListRelationFilter = {
    every?: Prisma.TournamentGameWhereInput;
    some?: Prisma.TournamentGameWhereInput;
    none?: Prisma.TournamentGameWhereInput;
};
export type TournamentGameOrderByRelationAggregateInput = {
    _count?: Prisma.SortOrder;
};
export type TournamentGameTournamentIdGameIdCompoundUniqueInput = {
    tournamentId: string;
    gameId: string;
};
export type TournamentGameCountOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    tournamentId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    pointMultiplier?: Prisma.SortOrder;
};
export type TournamentGameAvgOrderByAggregateInput = {
    pointMultiplier?: Prisma.SortOrder;
};
export type TournamentGameMaxOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    tournamentId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    pointMultiplier?: Prisma.SortOrder;
};
export type TournamentGameMinOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    tournamentId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    pointMultiplier?: Prisma.SortOrder;
};
export type TournamentGameSumOrderByAggregateInput = {
    pointMultiplier?: Prisma.SortOrder;
};
export type TournamentGameCreateNestedManyWithoutGameInput = {
    create?: Prisma.XOR<Prisma.TournamentGameCreateWithoutGameInput, Prisma.TournamentGameUncheckedCreateWithoutGameInput> | Prisma.TournamentGameCreateWithoutGameInput[] | Prisma.TournamentGameUncheckedCreateWithoutGameInput[];
    connectOrCreate?: Prisma.TournamentGameCreateOrConnectWithoutGameInput | Prisma.TournamentGameCreateOrConnectWithoutGameInput[];
    createMany?: Prisma.TournamentGameCreateManyGameInputEnvelope;
    connect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
};
export type TournamentGameUncheckedCreateNestedManyWithoutGameInput = {
    create?: Prisma.XOR<Prisma.TournamentGameCreateWithoutGameInput, Prisma.TournamentGameUncheckedCreateWithoutGameInput> | Prisma.TournamentGameCreateWithoutGameInput[] | Prisma.TournamentGameUncheckedCreateWithoutGameInput[];
    connectOrCreate?: Prisma.TournamentGameCreateOrConnectWithoutGameInput | Prisma.TournamentGameCreateOrConnectWithoutGameInput[];
    createMany?: Prisma.TournamentGameCreateManyGameInputEnvelope;
    connect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
};
export type TournamentGameUpdateManyWithoutGameNestedInput = {
    create?: Prisma.XOR<Prisma.TournamentGameCreateWithoutGameInput, Prisma.TournamentGameUncheckedCreateWithoutGameInput> | Prisma.TournamentGameCreateWithoutGameInput[] | Prisma.TournamentGameUncheckedCreateWithoutGameInput[];
    connectOrCreate?: Prisma.TournamentGameCreateOrConnectWithoutGameInput | Prisma.TournamentGameCreateOrConnectWithoutGameInput[];
    upsert?: Prisma.TournamentGameUpsertWithWhereUniqueWithoutGameInput | Prisma.TournamentGameUpsertWithWhereUniqueWithoutGameInput[];
    createMany?: Prisma.TournamentGameCreateManyGameInputEnvelope;
    set?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    disconnect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    delete?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    connect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    update?: Prisma.TournamentGameUpdateWithWhereUniqueWithoutGameInput | Prisma.TournamentGameUpdateWithWhereUniqueWithoutGameInput[];
    updateMany?: Prisma.TournamentGameUpdateManyWithWhereWithoutGameInput | Prisma.TournamentGameUpdateManyWithWhereWithoutGameInput[];
    deleteMany?: Prisma.TournamentGameScalarWhereInput | Prisma.TournamentGameScalarWhereInput[];
};
export type TournamentGameUncheckedUpdateManyWithoutGameNestedInput = {
    create?: Prisma.XOR<Prisma.TournamentGameCreateWithoutGameInput, Prisma.TournamentGameUncheckedCreateWithoutGameInput> | Prisma.TournamentGameCreateWithoutGameInput[] | Prisma.TournamentGameUncheckedCreateWithoutGameInput[];
    connectOrCreate?: Prisma.TournamentGameCreateOrConnectWithoutGameInput | Prisma.TournamentGameCreateOrConnectWithoutGameInput[];
    upsert?: Prisma.TournamentGameUpsertWithWhereUniqueWithoutGameInput | Prisma.TournamentGameUpsertWithWhereUniqueWithoutGameInput[];
    createMany?: Prisma.TournamentGameCreateManyGameInputEnvelope;
    set?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    disconnect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    delete?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    connect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    update?: Prisma.TournamentGameUpdateWithWhereUniqueWithoutGameInput | Prisma.TournamentGameUpdateWithWhereUniqueWithoutGameInput[];
    updateMany?: Prisma.TournamentGameUpdateManyWithWhereWithoutGameInput | Prisma.TournamentGameUpdateManyWithWhereWithoutGameInput[];
    deleteMany?: Prisma.TournamentGameScalarWhereInput | Prisma.TournamentGameScalarWhereInput[];
};
export type TournamentGameCreateNestedManyWithoutTournamentInput = {
    create?: Prisma.XOR<Prisma.TournamentGameCreateWithoutTournamentInput, Prisma.TournamentGameUncheckedCreateWithoutTournamentInput> | Prisma.TournamentGameCreateWithoutTournamentInput[] | Prisma.TournamentGameUncheckedCreateWithoutTournamentInput[];
    connectOrCreate?: Prisma.TournamentGameCreateOrConnectWithoutTournamentInput | Prisma.TournamentGameCreateOrConnectWithoutTournamentInput[];
    createMany?: Prisma.TournamentGameCreateManyTournamentInputEnvelope;
    connect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
};
export type TournamentGameUncheckedCreateNestedManyWithoutTournamentInput = {
    create?: Prisma.XOR<Prisma.TournamentGameCreateWithoutTournamentInput, Prisma.TournamentGameUncheckedCreateWithoutTournamentInput> | Prisma.TournamentGameCreateWithoutTournamentInput[] | Prisma.TournamentGameUncheckedCreateWithoutTournamentInput[];
    connectOrCreate?: Prisma.TournamentGameCreateOrConnectWithoutTournamentInput | Prisma.TournamentGameCreateOrConnectWithoutTournamentInput[];
    createMany?: Prisma.TournamentGameCreateManyTournamentInputEnvelope;
    connect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
};
export type TournamentGameUpdateManyWithoutTournamentNestedInput = {
    create?: Prisma.XOR<Prisma.TournamentGameCreateWithoutTournamentInput, Prisma.TournamentGameUncheckedCreateWithoutTournamentInput> | Prisma.TournamentGameCreateWithoutTournamentInput[] | Prisma.TournamentGameUncheckedCreateWithoutTournamentInput[];
    connectOrCreate?: Prisma.TournamentGameCreateOrConnectWithoutTournamentInput | Prisma.TournamentGameCreateOrConnectWithoutTournamentInput[];
    upsert?: Prisma.TournamentGameUpsertWithWhereUniqueWithoutTournamentInput | Prisma.TournamentGameUpsertWithWhereUniqueWithoutTournamentInput[];
    createMany?: Prisma.TournamentGameCreateManyTournamentInputEnvelope;
    set?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    disconnect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    delete?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    connect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    update?: Prisma.TournamentGameUpdateWithWhereUniqueWithoutTournamentInput | Prisma.TournamentGameUpdateWithWhereUniqueWithoutTournamentInput[];
    updateMany?: Prisma.TournamentGameUpdateManyWithWhereWithoutTournamentInput | Prisma.TournamentGameUpdateManyWithWhereWithoutTournamentInput[];
    deleteMany?: Prisma.TournamentGameScalarWhereInput | Prisma.TournamentGameScalarWhereInput[];
};
export type TournamentGameUncheckedUpdateManyWithoutTournamentNestedInput = {
    create?: Prisma.XOR<Prisma.TournamentGameCreateWithoutTournamentInput, Prisma.TournamentGameUncheckedCreateWithoutTournamentInput> | Prisma.TournamentGameCreateWithoutTournamentInput[] | Prisma.TournamentGameUncheckedCreateWithoutTournamentInput[];
    connectOrCreate?: Prisma.TournamentGameCreateOrConnectWithoutTournamentInput | Prisma.TournamentGameCreateOrConnectWithoutTournamentInput[];
    upsert?: Prisma.TournamentGameUpsertWithWhereUniqueWithoutTournamentInput | Prisma.TournamentGameUpsertWithWhereUniqueWithoutTournamentInput[];
    createMany?: Prisma.TournamentGameCreateManyTournamentInputEnvelope;
    set?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    disconnect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    delete?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    connect?: Prisma.TournamentGameWhereUniqueInput | Prisma.TournamentGameWhereUniqueInput[];
    update?: Prisma.TournamentGameUpdateWithWhereUniqueWithoutTournamentInput | Prisma.TournamentGameUpdateWithWhereUniqueWithoutTournamentInput[];
    updateMany?: Prisma.TournamentGameUpdateManyWithWhereWithoutTournamentInput | Prisma.TournamentGameUpdateManyWithWhereWithoutTournamentInput[];
    deleteMany?: Prisma.TournamentGameScalarWhereInput | Prisma.TournamentGameScalarWhereInput[];
};
export type FloatFieldUpdateOperationsInput = {
    set?: number;
    increment?: number;
    decrement?: number;
    multiply?: number;
    divide?: number;
};
export type TournamentGameCreateWithoutGameInput = {
    id?: string;
    pointMultiplier?: number;
    tournament: Prisma.TournamentCreateNestedOneWithoutEligibleGamesInput;
};
export type TournamentGameUncheckedCreateWithoutGameInput = {
    id?: string;
    tournamentId: string;
    pointMultiplier?: number;
};
export type TournamentGameCreateOrConnectWithoutGameInput = {
    where: Prisma.TournamentGameWhereUniqueInput;
    create: Prisma.XOR<Prisma.TournamentGameCreateWithoutGameInput, Prisma.TournamentGameUncheckedCreateWithoutGameInput>;
};
export type TournamentGameCreateManyGameInputEnvelope = {
    data: Prisma.TournamentGameCreateManyGameInput | Prisma.TournamentGameCreateManyGameInput[];
    skipDuplicates?: boolean;
};
export type TournamentGameUpsertWithWhereUniqueWithoutGameInput = {
    where: Prisma.TournamentGameWhereUniqueInput;
    update: Prisma.XOR<Prisma.TournamentGameUpdateWithoutGameInput, Prisma.TournamentGameUncheckedUpdateWithoutGameInput>;
    create: Prisma.XOR<Prisma.TournamentGameCreateWithoutGameInput, Prisma.TournamentGameUncheckedCreateWithoutGameInput>;
};
export type TournamentGameUpdateWithWhereUniqueWithoutGameInput = {
    where: Prisma.TournamentGameWhereUniqueInput;
    data: Prisma.XOR<Prisma.TournamentGameUpdateWithoutGameInput, Prisma.TournamentGameUncheckedUpdateWithoutGameInput>;
};
export type TournamentGameUpdateManyWithWhereWithoutGameInput = {
    where: Prisma.TournamentGameScalarWhereInput;
    data: Prisma.XOR<Prisma.TournamentGameUpdateManyMutationInput, Prisma.TournamentGameUncheckedUpdateManyWithoutGameInput>;
};
export type TournamentGameScalarWhereInput = {
    AND?: Prisma.TournamentGameScalarWhereInput | Prisma.TournamentGameScalarWhereInput[];
    OR?: Prisma.TournamentGameScalarWhereInput[];
    NOT?: Prisma.TournamentGameScalarWhereInput | Prisma.TournamentGameScalarWhereInput[];
    id?: Prisma.StringFilter<"TournamentGame"> | string;
    tournamentId?: Prisma.StringFilter<"TournamentGame"> | string;
    gameId?: Prisma.StringFilter<"TournamentGame"> | string;
    pointMultiplier?: Prisma.FloatFilter<"TournamentGame"> | number;
};
export type TournamentGameCreateWithoutTournamentInput = {
    id?: string;
    pointMultiplier?: number;
    game: Prisma.GameCreateNestedOneWithoutTournamentGameInput;
};
export type TournamentGameUncheckedCreateWithoutTournamentInput = {
    id?: string;
    gameId: string;
    pointMultiplier?: number;
};
export type TournamentGameCreateOrConnectWithoutTournamentInput = {
    where: Prisma.TournamentGameWhereUniqueInput;
    create: Prisma.XOR<Prisma.TournamentGameCreateWithoutTournamentInput, Prisma.TournamentGameUncheckedCreateWithoutTournamentInput>;
};
export type TournamentGameCreateManyTournamentInputEnvelope = {
    data: Prisma.TournamentGameCreateManyTournamentInput | Prisma.TournamentGameCreateManyTournamentInput[];
    skipDuplicates?: boolean;
};
export type TournamentGameUpsertWithWhereUniqueWithoutTournamentInput = {
    where: Prisma.TournamentGameWhereUniqueInput;
    update: Prisma.XOR<Prisma.TournamentGameUpdateWithoutTournamentInput, Prisma.TournamentGameUncheckedUpdateWithoutTournamentInput>;
    create: Prisma.XOR<Prisma.TournamentGameCreateWithoutTournamentInput, Prisma.TournamentGameUncheckedCreateWithoutTournamentInput>;
};
export type TournamentGameUpdateWithWhereUniqueWithoutTournamentInput = {
    where: Prisma.TournamentGameWhereUniqueInput;
    data: Prisma.XOR<Prisma.TournamentGameUpdateWithoutTournamentInput, Prisma.TournamentGameUncheckedUpdateWithoutTournamentInput>;
};
export type TournamentGameUpdateManyWithWhereWithoutTournamentInput = {
    where: Prisma.TournamentGameScalarWhereInput;
    data: Prisma.XOR<Prisma.TournamentGameUpdateManyMutationInput, Prisma.TournamentGameUncheckedUpdateManyWithoutTournamentInput>;
};
export type TournamentGameCreateManyGameInput = {
    id?: string;
    tournamentId: string;
    pointMultiplier?: number;
};
export type TournamentGameUpdateWithoutGameInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
    tournament?: Prisma.TournamentUpdateOneRequiredWithoutEligibleGamesNestedInput;
};
export type TournamentGameUncheckedUpdateWithoutGameInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    tournamentId?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
};
export type TournamentGameUncheckedUpdateManyWithoutGameInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    tournamentId?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
};
export type TournamentGameCreateManyTournamentInput = {
    id?: string;
    gameId: string;
    pointMultiplier?: number;
};
export type TournamentGameUpdateWithoutTournamentInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
    game?: Prisma.GameUpdateOneRequiredWithoutTournamentGameNestedInput;
};
export type TournamentGameUncheckedUpdateWithoutTournamentInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
};
export type TournamentGameUncheckedUpdateManyWithoutTournamentInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    pointMultiplier?: Prisma.FloatFieldUpdateOperationsInput | number;
};
export type TournamentGameSelect<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    tournamentId?: boolean;
    gameId?: boolean;
    pointMultiplier?: boolean;
    tournament?: boolean | Prisma.TournamentDefaultArgs<ExtArgs>;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["tournamentGame"]>;
export type TournamentGameSelectCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    tournamentId?: boolean;
    gameId?: boolean;
    pointMultiplier?: boolean;
    tournament?: boolean | Prisma.TournamentDefaultArgs<ExtArgs>;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["tournamentGame"]>;
export type TournamentGameSelectUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    tournamentId?: boolean;
    gameId?: boolean;
    pointMultiplier?: boolean;
    tournament?: boolean | Prisma.TournamentDefaultArgs<ExtArgs>;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["tournamentGame"]>;
export type TournamentGameSelectScalar = {
    id?: boolean;
    tournamentId?: boolean;
    gameId?: boolean;
    pointMultiplier?: boolean;
};
export type TournamentGameOmit<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetOmit<"id" | "tournamentId" | "gameId" | "pointMultiplier", ExtArgs["result"]["tournamentGame"]>;
export type TournamentGameInclude<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    tournament?: boolean | Prisma.TournamentDefaultArgs<ExtArgs>;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
};
export type TournamentGameIncludeCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    tournament?: boolean | Prisma.TournamentDefaultArgs<ExtArgs>;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
};
export type TournamentGameIncludeUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    tournament?: boolean | Prisma.TournamentDefaultArgs<ExtArgs>;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
};
export type $TournamentGamePayload<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    name: "TournamentGame";
    objects: {
        tournament: Prisma.$TournamentPayload<ExtArgs>;
        game: Prisma.$GamePayload<ExtArgs>;
    };
    scalars: runtime.Types.Extensions.GetPayloadResult<{
        id: string;
        tournamentId: string;
        gameId: string;
        pointMultiplier: number;
    }, ExtArgs["result"]["tournamentGame"]>;
    composites: {};
};
export type TournamentGameGetPayload<S extends boolean | null | undefined | TournamentGameDefaultArgs> = runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload, S>;
export type TournamentGameCountArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = Omit<TournamentGameFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
    select?: TournamentGameCountAggregateInputType | true;
};
export interface TournamentGameDelegate<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: {
        types: Prisma.TypeMap<ExtArgs>['model']['TournamentGame'];
        meta: {
            name: 'TournamentGame';
        };
    };
    /**
     * Find zero or one TournamentGame that matches the filter.
     * @param {TournamentGameFindUniqueArgs} args - Arguments to find a TournamentGame
     * @example
     * // Get one TournamentGame
     * const tournamentGame = await prisma.tournamentGame.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends TournamentGameFindUniqueArgs>(args: Prisma.SelectSubset<T, TournamentGameFindUniqueArgs<ExtArgs>>): Prisma.Prisma__TournamentGameClient<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    /**
     * Find one TournamentGame that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {TournamentGameFindUniqueOrThrowArgs} args - Arguments to find a TournamentGame
     * @example
     * // Get one TournamentGame
     * const tournamentGame = await prisma.tournamentGame.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends TournamentGameFindUniqueOrThrowArgs>(args: Prisma.SelectSubset<T, TournamentGameFindUniqueOrThrowArgs<ExtArgs>>): Prisma.Prisma__TournamentGameClient<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Find the first TournamentGame that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {TournamentGameFindFirstArgs} args - Arguments to find a TournamentGame
     * @example
     * // Get one TournamentGame
     * const tournamentGame = await prisma.tournamentGame.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends TournamentGameFindFirstArgs>(args?: Prisma.SelectSubset<T, TournamentGameFindFirstArgs<ExtArgs>>): Prisma.Prisma__TournamentGameClient<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    /**
     * Find the first TournamentGame that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {TournamentGameFindFirstOrThrowArgs} args - Arguments to find a TournamentGame
     * @example
     * // Get one TournamentGame
     * const tournamentGame = await prisma.tournamentGame.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends TournamentGameFindFirstOrThrowArgs>(args?: Prisma.SelectSubset<T, TournamentGameFindFirstOrThrowArgs<ExtArgs>>): Prisma.Prisma__TournamentGameClient<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Find zero or more TournamentGames that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {TournamentGameFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all TournamentGames
     * const tournamentGames = await prisma.tournamentGame.findMany()
     *
     * // Get first 10 TournamentGames
     * const tournamentGames = await prisma.tournamentGame.findMany({ take: 10 })
     *
     * // Only select the `id`
     * const tournamentGameWithIdOnly = await prisma.tournamentGame.findMany({ select: { id: true } })
     *
     */
    findMany<T extends TournamentGameFindManyArgs>(args?: Prisma.SelectSubset<T, TournamentGameFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>;
    /**
     * Create a TournamentGame.
     * @param {TournamentGameCreateArgs} args - Arguments to create a TournamentGame.
     * @example
     * // Create one TournamentGame
     * const TournamentGame = await prisma.tournamentGame.create({
     *   data: {
     *     // ... data to create a TournamentGame
     *   }
     * })
     *
     */
    create<T extends TournamentGameCreateArgs>(args: Prisma.SelectSubset<T, TournamentGameCreateArgs<ExtArgs>>): Prisma.Prisma__TournamentGameClient<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Create many TournamentGames.
     * @param {TournamentGameCreateManyArgs} args - Arguments to create many TournamentGames.
     * @example
     * // Create many TournamentGames
     * const tournamentGame = await prisma.tournamentGame.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     */
    createMany<T extends TournamentGameCreateManyArgs>(args?: Prisma.SelectSubset<T, TournamentGameCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Create many TournamentGames and returns the data saved in the database.
     * @param {TournamentGameCreateManyAndReturnArgs} args - Arguments to create many TournamentGames.
     * @example
     * // Create many TournamentGames
     * const tournamentGame = await prisma.tournamentGame.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     * // Create many TournamentGames and only return the `id`
     * const tournamentGameWithIdOnly = await prisma.tournamentGame.createManyAndReturn({
     *   select: { id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     *
     */
    createManyAndReturn<T extends TournamentGameCreateManyAndReturnArgs>(args?: Prisma.SelectSubset<T, TournamentGameCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>;
    /**
     * Delete a TournamentGame.
     * @param {TournamentGameDeleteArgs} args - Arguments to delete one TournamentGame.
     * @example
     * // Delete one TournamentGame
     * const TournamentGame = await prisma.tournamentGame.delete({
     *   where: {
     *     // ... filter to delete one TournamentGame
     *   }
     * })
     *
     */
    delete<T extends TournamentGameDeleteArgs>(args: Prisma.SelectSubset<T, TournamentGameDeleteArgs<ExtArgs>>): Prisma.Prisma__TournamentGameClient<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Update one TournamentGame.
     * @param {TournamentGameUpdateArgs} args - Arguments to update one TournamentGame.
     * @example
     * // Update one TournamentGame
     * const tournamentGame = await prisma.tournamentGame.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     *
     */
    update<T extends TournamentGameUpdateArgs>(args: Prisma.SelectSubset<T, TournamentGameUpdateArgs<ExtArgs>>): Prisma.Prisma__TournamentGameClient<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Delete zero or more TournamentGames.
     * @param {TournamentGameDeleteManyArgs} args - Arguments to filter TournamentGames to delete.
     * @example
     * // Delete a few TournamentGames
     * const { count } = await prisma.tournamentGame.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     *
     */
    deleteMany<T extends TournamentGameDeleteManyArgs>(args?: Prisma.SelectSubset<T, TournamentGameDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Update zero or more TournamentGames.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {TournamentGameUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many TournamentGames
     * const tournamentGame = await prisma.tournamentGame.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     *
     */
    updateMany<T extends TournamentGameUpdateManyArgs>(args: Prisma.SelectSubset<T, TournamentGameUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Update zero or more TournamentGames and returns the data updated in the database.
     * @param {TournamentGameUpdateManyAndReturnArgs} args - Arguments to update many TournamentGames.
     * @example
     * // Update many TournamentGames
     * const tournamentGame = await prisma.tournamentGame.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     * // Update zero or more TournamentGames and only return the `id`
     * const tournamentGameWithIdOnly = await prisma.tournamentGame.updateManyAndReturn({
     *   select: { id: true },
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     *
     */
    updateManyAndReturn<T extends TournamentGameUpdateManyAndReturnArgs>(args: Prisma.SelectSubset<T, TournamentGameUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>;
    /**
     * Create or update one TournamentGame.
     * @param {TournamentGameUpsertArgs} args - Arguments to update or create a TournamentGame.
     * @example
     * // Update or create a TournamentGame
     * const tournamentGame = await prisma.tournamentGame.upsert({
     *   create: {
     *     // ... data to create a TournamentGame
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the TournamentGame we want to update
     *   }
     * })
     */
    upsert<T extends TournamentGameUpsertArgs>(args: Prisma.SelectSubset<T, TournamentGameUpsertArgs<ExtArgs>>): Prisma.Prisma__TournamentGameClient<runtime.Types.Result.GetResult<Prisma.$TournamentGamePayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Count the number of TournamentGames.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {TournamentGameCountArgs} args - Arguments to filter TournamentGames to count.
     * @example
     * // Count the number of TournamentGames
     * const count = await prisma.tournamentGame.count({
     *   where: {
     *     // ... the filter for the TournamentGames we want to count
     *   }
     * })
    **/
    count<T extends TournamentGameCountArgs>(args?: Prisma.Subset<T, TournamentGameCountArgs>): Prisma.PrismaPromise<T extends runtime.Types.Utils.Record<'select', any> ? T['select'] extends true ? number : Prisma.GetScalarType<T['select'], TournamentGameCountAggregateOutputType> : number>;
    /**
     * Allows you to perform aggregations operations on a TournamentGame.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {TournamentGameAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
     * @example
     * // Ordered by age ascending
     * // Where email contains prisma.io
     * // Limited to the 10 users
     * const aggregations = await prisma.user.aggregate({
     *   _avg: {
     *     age: true,
     *   },
     *   where: {
     *     email: {
     *       contains: "prisma.io",
     *     },
     *   },
     *   orderBy: {
     *     age: "asc",
     *   },
     *   take: 10,
     * })
    **/
    aggregate<T extends TournamentGameAggregateArgs>(args: Prisma.Subset<T, TournamentGameAggregateArgs>): Prisma.PrismaPromise<GetTournamentGameAggregateType<T>>;
    /**
     * Group by TournamentGame.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {TournamentGameGroupByArgs} args - Group by arguments.
     * @example
     * // Group by city, order by createdAt, get count
     * const result = await prisma.user.groupBy({
     *   by: ['city', 'createdAt'],
     *   orderBy: {
     *     createdAt: true
     *   },
     *   _count: {
     *     _all: true
     *   },
     * })
     *
    **/
    groupBy<T extends TournamentGameGroupByArgs, HasSelectOrTake extends Prisma.Or<Prisma.Extends<'skip', Prisma.Keys<T>>, Prisma.Extends<'take', Prisma.Keys<T>>>, OrderByArg extends Prisma.True extends HasSelectOrTake ? {
        orderBy: TournamentGameGroupByArgs['orderBy'];
    } : {
        orderBy?: TournamentGameGroupByArgs['orderBy'];
    }, OrderFields extends Prisma.ExcludeUnderscoreKeys<Prisma.Keys<Prisma.MaybeTupleToUnion<T['orderBy']>>>, ByFields extends Prisma.MaybeTupleToUnion<T['by']>, ByValid extends Prisma.Has<ByFields, OrderFields>, HavingFields extends Prisma.GetHavingFields<T['having']>, HavingValid extends Prisma.Has<ByFields, HavingFields>, ByEmpty extends T['by'] extends never[] ? Prisma.True : Prisma.False, InputErrors extends ByEmpty extends Prisma.True ? `Error: "by" must not be empty.` : HavingValid extends Prisma.False ? {
        [P in HavingFields]: P extends ByFields ? never : P extends string ? `Error: Field "${P}" used in "having" needs to be provided in "by".` : [
            Error,
            'Field ',
            P,
            ` in "having" needs to be provided in "by"`
        ];
    }[HavingFields] : 'take' extends Prisma.Keys<T> ? 'orderBy' extends Prisma.Keys<T> ? ByValid extends Prisma.True ? {} : {
        [P in OrderFields]: P extends ByFields ? never : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`;
    }[OrderFields] : 'Error: If you provide "take", you also need to provide "orderBy"' : 'skip' extends Prisma.Keys<T> ? 'orderBy' extends Prisma.Keys<T> ? ByValid extends Prisma.True ? {} : {
        [P in OrderFields]: P extends ByFields ? never : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`;
    }[OrderFields] : 'Error: If you provide "skip", you also need to provide "orderBy"' : ByValid extends Prisma.True ? {} : {
        [P in OrderFields]: P extends ByFields ? never : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`;
    }[OrderFields]>(args: Prisma.SubsetIntersection<T, TournamentGameGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetTournamentGameGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>;
    /**
     * Fields of the TournamentGame model
     */
    readonly fields: TournamentGameFieldRefs;
}
/**
 * The delegate class that acts as a "Promise-like" for TournamentGame.
 * Why is this prefixed with `Prisma__`?
 * Because we want to prevent naming conflicts as mentioned in
 * https://github.com/prisma/prisma-client-js/issues/707
 */
export interface Prisma__TournamentGameClient<T, Null = never, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise";
    tournament<T extends Prisma.TournamentDefaultArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.TournamentDefaultArgs<ExtArgs>>): Prisma.Prisma__TournamentClient<runtime.Types.Result.GetResult<Prisma.$TournamentPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>;
    game<T extends Prisma.GameDefaultArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.GameDefaultArgs<ExtArgs>>): Prisma.Prisma__GameClient<runtime.Types.Result.GetResult<Prisma.$GamePayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>;
    /**
     * Attaches callbacks for the resolution and/or rejection of the Promise.
     * @param onfulfilled The callback to execute when the Promise is resolved.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of which ever callback is executed.
     */
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): runtime.Types.Utils.JsPromise<TResult1 | TResult2>;
    /**
     * Attaches a callback for only the rejection of the Promise.
     * @param onrejected The callback to execute when the Promise is rejected.
     * @returns A Promise for the completion of the callback.
     */
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): runtime.Types.Utils.JsPromise<T | TResult>;
    /**
     * Attaches a callback that is invoked when the Promise is settled (fulfilled or rejected). The
     * resolved value cannot be modified from the callback.
     * @param onfinally The callback to execute when the Promise is settled (fulfilled or rejected).
     * @returns A Promise for the completion of the callback.
     */
    finally(onfinally?: (() => void) | undefined | null): runtime.Types.Utils.JsPromise<T>;
}
/**
 * Fields of the TournamentGame model
 */
export interface TournamentGameFieldRefs {
    readonly id: Prisma.FieldRef<"TournamentGame", 'String'>;
    readonly tournamentId: Prisma.FieldRef<"TournamentGame", 'String'>;
    readonly gameId: Prisma.FieldRef<"TournamentGame", 'String'>;
    readonly pointMultiplier: Prisma.FieldRef<"TournamentGame", 'Float'>;
}
/**
 * TournamentGame findUnique
 */
export type TournamentGameFindUniqueArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * Filter, which TournamentGame to fetch.
     */
    where: Prisma.TournamentGameWhereUniqueInput;
};
/**
 * TournamentGame findUniqueOrThrow
 */
export type TournamentGameFindUniqueOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * Filter, which TournamentGame to fetch.
     */
    where: Prisma.TournamentGameWhereUniqueInput;
};
/**
 * TournamentGame findFirst
 */
export type TournamentGameFindFirstArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * Filter, which TournamentGame to fetch.
     */
    where?: Prisma.TournamentGameWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of TournamentGames to fetch.
     */
    orderBy?: Prisma.TournamentGameOrderByWithRelationInput | Prisma.TournamentGameOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for searching for TournamentGames.
     */
    cursor?: Prisma.TournamentGameWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` TournamentGames from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` TournamentGames.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     *
     * Filter by unique combinations of TournamentGames.
     */
    distinct?: Prisma.TournamentGameScalarFieldEnum | Prisma.TournamentGameScalarFieldEnum[];
};
/**
 * TournamentGame findFirstOrThrow
 */
export type TournamentGameFindFirstOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * Filter, which TournamentGame to fetch.
     */
    where?: Prisma.TournamentGameWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of TournamentGames to fetch.
     */
    orderBy?: Prisma.TournamentGameOrderByWithRelationInput | Prisma.TournamentGameOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for searching for TournamentGames.
     */
    cursor?: Prisma.TournamentGameWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` TournamentGames from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` TournamentGames.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     *
     * Filter by unique combinations of TournamentGames.
     */
    distinct?: Prisma.TournamentGameScalarFieldEnum | Prisma.TournamentGameScalarFieldEnum[];
};
/**
 * TournamentGame findMany
 */
export type TournamentGameFindManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * Filter, which TournamentGames to fetch.
     */
    where?: Prisma.TournamentGameWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of TournamentGames to fetch.
     */
    orderBy?: Prisma.TournamentGameOrderByWithRelationInput | Prisma.TournamentGameOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for listing TournamentGames.
     */
    cursor?: Prisma.TournamentGameWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` TournamentGames from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` TournamentGames.
     */
    skip?: number;
    distinct?: Prisma.TournamentGameScalarFieldEnum | Prisma.TournamentGameScalarFieldEnum[];
};
/**
 * TournamentGame create
 */
export type TournamentGameCreateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * The data needed to create a TournamentGame.
     */
    data: Prisma.XOR<Prisma.TournamentGameCreateInput, Prisma.TournamentGameUncheckedCreateInput>;
};
/**
 * TournamentGame createMany
 */
export type TournamentGameCreateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * The data used to create many TournamentGames.
     */
    data: Prisma.TournamentGameCreateManyInput | Prisma.TournamentGameCreateManyInput[];
    skipDuplicates?: boolean;
};
/**
 * TournamentGame createManyAndReturn
 */
export type TournamentGameCreateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelectCreateManyAndReturn<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * The data used to create many TournamentGames.
     */
    data: Prisma.TournamentGameCreateManyInput | Prisma.TournamentGameCreateManyInput[];
    skipDuplicates?: boolean;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameIncludeCreateManyAndReturn<ExtArgs> | null;
};
/**
 * TournamentGame update
 */
export type TournamentGameUpdateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * The data needed to update a TournamentGame.
     */
    data: Prisma.XOR<Prisma.TournamentGameUpdateInput, Prisma.TournamentGameUncheckedUpdateInput>;
    /**
     * Choose, which TournamentGame to update.
     */
    where: Prisma.TournamentGameWhereUniqueInput;
};
/**
 * TournamentGame updateMany
 */
export type TournamentGameUpdateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * The data used to update TournamentGames.
     */
    data: Prisma.XOR<Prisma.TournamentGameUpdateManyMutationInput, Prisma.TournamentGameUncheckedUpdateManyInput>;
    /**
     * Filter which TournamentGames to update
     */
    where?: Prisma.TournamentGameWhereInput;
    /**
     * Limit how many TournamentGames to update.
     */
    limit?: number;
};
/**
 * TournamentGame updateManyAndReturn
 */
export type TournamentGameUpdateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelectUpdateManyAndReturn<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * The data used to update TournamentGames.
     */
    data: Prisma.XOR<Prisma.TournamentGameUpdateManyMutationInput, Prisma.TournamentGameUncheckedUpdateManyInput>;
    /**
     * Filter which TournamentGames to update
     */
    where?: Prisma.TournamentGameWhereInput;
    /**
     * Limit how many TournamentGames to update.
     */
    limit?: number;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameIncludeUpdateManyAndReturn<ExtArgs> | null;
};
/**
 * TournamentGame upsert
 */
export type TournamentGameUpsertArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * The filter to search for the TournamentGame to update in case it exists.
     */
    where: Prisma.TournamentGameWhereUniqueInput;
    /**
     * In case the TournamentGame found by the `where` argument doesn't exist, create a new TournamentGame with this data.
     */
    create: Prisma.XOR<Prisma.TournamentGameCreateInput, Prisma.TournamentGameUncheckedCreateInput>;
    /**
     * In case the TournamentGame was found with the provided `where` argument, update it with this data.
     */
    update: Prisma.XOR<Prisma.TournamentGameUpdateInput, Prisma.TournamentGameUncheckedUpdateInput>;
};
/**
 * TournamentGame delete
 */
export type TournamentGameDeleteArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
    /**
     * Filter which TournamentGame to delete.
     */
    where: Prisma.TournamentGameWhereUniqueInput;
};
/**
 * TournamentGame deleteMany
 */
export type TournamentGameDeleteManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Filter which TournamentGames to delete
     */
    where?: Prisma.TournamentGameWhereInput;
    /**
     * Limit how many TournamentGames to delete.
     */
    limit?: number;
};
/**
 * TournamentGame without action
 */
export type TournamentGameDefaultArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentGame
     */
    select?: Prisma.TournamentGameSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentGame
     */
    omit?: Prisma.TournamentGameOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentGameInclude<ExtArgs> | null;
};
export {};
