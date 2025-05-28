/**
 * This file exports the `RebateTransaction` model and its related types.
 *
 * 🟢 You can import this file directly.
 */
import * as runtime from "@prisma/client/runtime/library";
import type * as $Enums from "../enums.ts";
import type * as Prisma from "../internal/prismaNamespace.ts";
/**
 * Model RebateTransaction
 *
 */
export type RebateTransactionModel = runtime.Types.Result.DefaultSelection<Prisma.$RebateTransactionPayload>;
export type AggregateRebateTransaction = {
    _count: RebateTransactionCountAggregateOutputType | null;
    _avg: RebateTransactionAvgAggregateOutputType | null;
    _sum: RebateTransactionSumAggregateOutputType | null;
    _min: RebateTransactionMinAggregateOutputType | null;
    _max: RebateTransactionMaxAggregateOutputType | null;
};
export type RebateTransactionAvgAggregateOutputType = {
    rebateAmount: number | null;
    vipLevel: number | null;
    rebatePercentage: number | null;
};
export type RebateTransactionSumAggregateOutputType = {
    rebateAmount: number | null;
    vipLevel: number | null;
    rebatePercentage: number | null;
};
export type RebateTransactionMinAggregateOutputType = {
    id: string | null;
    userId: string | null;
    transactionId: string | null;
    rebateAmount: number | null;
    currencyId: string | null;
    vipLevel: number | null;
    rebatePercentage: number | null;
    status: $Enums.RewardStatus | null;
    paidOutAt: Date | null;
    createdAt: Date | null;
    updatedAt: Date | null;
};
export type RebateTransactionMaxAggregateOutputType = {
    id: string | null;
    userId: string | null;
    transactionId: string | null;
    rebateAmount: number | null;
    currencyId: string | null;
    vipLevel: number | null;
    rebatePercentage: number | null;
    status: $Enums.RewardStatus | null;
    paidOutAt: Date | null;
    createdAt: Date | null;
    updatedAt: Date | null;
};
export type RebateTransactionCountAggregateOutputType = {
    id: number;
    userId: number;
    transactionId: number;
    rebateAmount: number;
    currencyId: number;
    vipLevel: number;
    rebatePercentage: number;
    status: number;
    paidOutAt: number;
    createdAt: number;
    updatedAt: number;
    _all: number;
};
export type RebateTransactionAvgAggregateInputType = {
    rebateAmount?: true;
    vipLevel?: true;
    rebatePercentage?: true;
};
export type RebateTransactionSumAggregateInputType = {
    rebateAmount?: true;
    vipLevel?: true;
    rebatePercentage?: true;
};
export type RebateTransactionMinAggregateInputType = {
    id?: true;
    userId?: true;
    transactionId?: true;
    rebateAmount?: true;
    currencyId?: true;
    vipLevel?: true;
    rebatePercentage?: true;
    status?: true;
    paidOutAt?: true;
    createdAt?: true;
    updatedAt?: true;
};
export type RebateTransactionMaxAggregateInputType = {
    id?: true;
    userId?: true;
    transactionId?: true;
    rebateAmount?: true;
    currencyId?: true;
    vipLevel?: true;
    rebatePercentage?: true;
    status?: true;
    paidOutAt?: true;
    createdAt?: true;
    updatedAt?: true;
};
export type RebateTransactionCountAggregateInputType = {
    id?: true;
    userId?: true;
    transactionId?: true;
    rebateAmount?: true;
    currencyId?: true;
    vipLevel?: true;
    rebatePercentage?: true;
    status?: true;
    paidOutAt?: true;
    createdAt?: true;
    updatedAt?: true;
    _all?: true;
};
export type RebateTransactionAggregateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Filter which RebateTransaction to aggregate.
     */
    where?: Prisma.RebateTransactionWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of RebateTransactions to fetch.
     */
    orderBy?: Prisma.RebateTransactionOrderByWithRelationInput | Prisma.RebateTransactionOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the start position
     */
    cursor?: Prisma.RebateTransactionWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` RebateTransactions from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` RebateTransactions.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Count returned RebateTransactions
    **/
    _count?: true | RebateTransactionCountAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to average
    **/
    _avg?: RebateTransactionAvgAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to sum
    **/
    _sum?: RebateTransactionSumAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to find the minimum value
    **/
    _min?: RebateTransactionMinAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to find the maximum value
    **/
    _max?: RebateTransactionMaxAggregateInputType;
};
export type GetRebateTransactionAggregateType<T extends RebateTransactionAggregateArgs> = {
    [P in keyof T & keyof AggregateRebateTransaction]: P extends '_count' | 'count' ? T[P] extends true ? number : Prisma.GetScalarType<T[P], AggregateRebateTransaction[P]> : Prisma.GetScalarType<T[P], AggregateRebateTransaction[P]>;
};
export type RebateTransactionGroupByArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.RebateTransactionWhereInput;
    orderBy?: Prisma.RebateTransactionOrderByWithAggregationInput | Prisma.RebateTransactionOrderByWithAggregationInput[];
    by: Prisma.RebateTransactionScalarFieldEnum[] | Prisma.RebateTransactionScalarFieldEnum;
    having?: Prisma.RebateTransactionScalarWhereWithAggregatesInput;
    take?: number;
    skip?: number;
    _count?: RebateTransactionCountAggregateInputType | true;
    _avg?: RebateTransactionAvgAggregateInputType;
    _sum?: RebateTransactionSumAggregateInputType;
    _min?: RebateTransactionMinAggregateInputType;
    _max?: RebateTransactionMaxAggregateInputType;
};
export type RebateTransactionGroupByOutputType = {
    id: string;
    userId: string;
    transactionId: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status: $Enums.RewardStatus;
    paidOutAt: Date | null;
    createdAt: Date;
    updatedAt: Date;
    _count: RebateTransactionCountAggregateOutputType | null;
    _avg: RebateTransactionAvgAggregateOutputType | null;
    _sum: RebateTransactionSumAggregateOutputType | null;
    _min: RebateTransactionMinAggregateOutputType | null;
    _max: RebateTransactionMaxAggregateOutputType | null;
};
type GetRebateTransactionGroupByPayload<T extends RebateTransactionGroupByArgs> = Prisma.PrismaPromise<Array<Prisma.PickEnumerable<RebateTransactionGroupByOutputType, T['by']> & {
    [P in ((keyof T) & (keyof RebateTransactionGroupByOutputType))]: P extends '_count' ? T[P] extends boolean ? number : Prisma.GetScalarType<T[P], RebateTransactionGroupByOutputType[P]> : Prisma.GetScalarType<T[P], RebateTransactionGroupByOutputType[P]>;
}>>;
export type RebateTransactionWhereInput = {
    AND?: Prisma.RebateTransactionWhereInput | Prisma.RebateTransactionWhereInput[];
    OR?: Prisma.RebateTransactionWhereInput[];
    NOT?: Prisma.RebateTransactionWhereInput | Prisma.RebateTransactionWhereInput[];
    id?: Prisma.StringFilter<"RebateTransaction"> | string;
    userId?: Prisma.StringFilter<"RebateTransaction"> | string;
    transactionId?: Prisma.StringFilter<"RebateTransaction"> | string;
    rebateAmount?: Prisma.FloatFilter<"RebateTransaction"> | number;
    currencyId?: Prisma.StringFilter<"RebateTransaction"> | string;
    vipLevel?: Prisma.IntFilter<"RebateTransaction"> | number;
    rebatePercentage?: Prisma.FloatFilter<"RebateTransaction"> | number;
    status?: Prisma.EnumRewardStatusFilter<"RebateTransaction"> | $Enums.RewardStatus;
    paidOutAt?: Prisma.DateTimeNullableFilter<"RebateTransaction"> | Date | string | null;
    createdAt?: Prisma.DateTimeFilter<"RebateTransaction"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"RebateTransaction"> | Date | string;
    user?: Prisma.XOR<Prisma.UserProfileScalarRelationFilter, Prisma.UserProfileWhereInput>;
    originalTransaction?: Prisma.XOR<Prisma.TransactionScalarRelationFilter, Prisma.TransactionWhereInput>;
};
export type RebateTransactionOrderByWithRelationInput = {
    id?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    transactionId?: Prisma.SortOrder;
    rebateAmount?: Prisma.SortOrder;
    currencyId?: Prisma.SortOrder;
    vipLevel?: Prisma.SortOrder;
    rebatePercentage?: Prisma.SortOrder;
    status?: Prisma.SortOrder;
    paidOutAt?: Prisma.SortOrderInput | Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    user?: Prisma.UserProfileOrderByWithRelationInput;
    originalTransaction?: Prisma.TransactionOrderByWithRelationInput;
};
export type RebateTransactionWhereUniqueInput = Prisma.AtLeast<{
    id?: string;
    transactionId?: string;
    AND?: Prisma.RebateTransactionWhereInput | Prisma.RebateTransactionWhereInput[];
    OR?: Prisma.RebateTransactionWhereInput[];
    NOT?: Prisma.RebateTransactionWhereInput | Prisma.RebateTransactionWhereInput[];
    userId?: Prisma.StringFilter<"RebateTransaction"> | string;
    rebateAmount?: Prisma.FloatFilter<"RebateTransaction"> | number;
    currencyId?: Prisma.StringFilter<"RebateTransaction"> | string;
    vipLevel?: Prisma.IntFilter<"RebateTransaction"> | number;
    rebatePercentage?: Prisma.FloatFilter<"RebateTransaction"> | number;
    status?: Prisma.EnumRewardStatusFilter<"RebateTransaction"> | $Enums.RewardStatus;
    paidOutAt?: Prisma.DateTimeNullableFilter<"RebateTransaction"> | Date | string | null;
    createdAt?: Prisma.DateTimeFilter<"RebateTransaction"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"RebateTransaction"> | Date | string;
    user?: Prisma.XOR<Prisma.UserProfileScalarRelationFilter, Prisma.UserProfileWhereInput>;
    originalTransaction?: Prisma.XOR<Prisma.TransactionScalarRelationFilter, Prisma.TransactionWhereInput>;
}, "id" | "transactionId">;
export type RebateTransactionOrderByWithAggregationInput = {
    id?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    transactionId?: Prisma.SortOrder;
    rebateAmount?: Prisma.SortOrder;
    currencyId?: Prisma.SortOrder;
    vipLevel?: Prisma.SortOrder;
    rebatePercentage?: Prisma.SortOrder;
    status?: Prisma.SortOrder;
    paidOutAt?: Prisma.SortOrderInput | Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    _count?: Prisma.RebateTransactionCountOrderByAggregateInput;
    _avg?: Prisma.RebateTransactionAvgOrderByAggregateInput;
    _max?: Prisma.RebateTransactionMaxOrderByAggregateInput;
    _min?: Prisma.RebateTransactionMinOrderByAggregateInput;
    _sum?: Prisma.RebateTransactionSumOrderByAggregateInput;
};
export type RebateTransactionScalarWhereWithAggregatesInput = {
    AND?: Prisma.RebateTransactionScalarWhereWithAggregatesInput | Prisma.RebateTransactionScalarWhereWithAggregatesInput[];
    OR?: Prisma.RebateTransactionScalarWhereWithAggregatesInput[];
    NOT?: Prisma.RebateTransactionScalarWhereWithAggregatesInput | Prisma.RebateTransactionScalarWhereWithAggregatesInput[];
    id?: Prisma.StringWithAggregatesFilter<"RebateTransaction"> | string;
    userId?: Prisma.StringWithAggregatesFilter<"RebateTransaction"> | string;
    transactionId?: Prisma.StringWithAggregatesFilter<"RebateTransaction"> | string;
    rebateAmount?: Prisma.FloatWithAggregatesFilter<"RebateTransaction"> | number;
    currencyId?: Prisma.StringWithAggregatesFilter<"RebateTransaction"> | string;
    vipLevel?: Prisma.IntWithAggregatesFilter<"RebateTransaction"> | number;
    rebatePercentage?: Prisma.FloatWithAggregatesFilter<"RebateTransaction"> | number;
    status?: Prisma.EnumRewardStatusWithAggregatesFilter<"RebateTransaction"> | $Enums.RewardStatus;
    paidOutAt?: Prisma.DateTimeNullableWithAggregatesFilter<"RebateTransaction"> | Date | string | null;
    createdAt?: Prisma.DateTimeWithAggregatesFilter<"RebateTransaction"> | Date | string;
    updatedAt?: Prisma.DateTimeWithAggregatesFilter<"RebateTransaction"> | Date | string;
};
export type RebateTransactionCreateInput = {
    id?: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status?: $Enums.RewardStatus;
    paidOutAt?: Date | string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    user: Prisma.UserProfileCreateNestedOneWithoutRebateTransactionsInput;
    originalTransaction: Prisma.TransactionCreateNestedOneWithoutRebateGeneratedInput;
};
export type RebateTransactionUncheckedCreateInput = {
    id?: string;
    userId: string;
    transactionId: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status?: $Enums.RewardStatus;
    paidOutAt?: Date | string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
};
export type RebateTransactionUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    user?: Prisma.UserProfileUpdateOneRequiredWithoutRebateTransactionsNestedInput;
    originalTransaction?: Prisma.TransactionUpdateOneRequiredWithoutRebateGeneratedNestedInput;
};
export type RebateTransactionUncheckedUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    transactionId?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
};
export type RebateTransactionCreateManyInput = {
    id?: string;
    userId: string;
    transactionId: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status?: $Enums.RewardStatus;
    paidOutAt?: Date | string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
};
export type RebateTransactionUpdateManyMutationInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
};
export type RebateTransactionUncheckedUpdateManyInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    transactionId?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
};
export type RebateTransactionNullableScalarRelationFilter = {
    is?: Prisma.RebateTransactionWhereInput | null;
    isNot?: Prisma.RebateTransactionWhereInput | null;
};
export type RebateTransactionCountOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    transactionId?: Prisma.SortOrder;
    rebateAmount?: Prisma.SortOrder;
    currencyId?: Prisma.SortOrder;
    vipLevel?: Prisma.SortOrder;
    rebatePercentage?: Prisma.SortOrder;
    status?: Prisma.SortOrder;
    paidOutAt?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
};
export type RebateTransactionAvgOrderByAggregateInput = {
    rebateAmount?: Prisma.SortOrder;
    vipLevel?: Prisma.SortOrder;
    rebatePercentage?: Prisma.SortOrder;
};
export type RebateTransactionMaxOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    transactionId?: Prisma.SortOrder;
    rebateAmount?: Prisma.SortOrder;
    currencyId?: Prisma.SortOrder;
    vipLevel?: Prisma.SortOrder;
    rebatePercentage?: Prisma.SortOrder;
    status?: Prisma.SortOrder;
    paidOutAt?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
};
export type RebateTransactionMinOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    transactionId?: Prisma.SortOrder;
    rebateAmount?: Prisma.SortOrder;
    currencyId?: Prisma.SortOrder;
    vipLevel?: Prisma.SortOrder;
    rebatePercentage?: Prisma.SortOrder;
    status?: Prisma.SortOrder;
    paidOutAt?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
};
export type RebateTransactionSumOrderByAggregateInput = {
    rebateAmount?: Prisma.SortOrder;
    vipLevel?: Prisma.SortOrder;
    rebatePercentage?: Prisma.SortOrder;
};
export type RebateTransactionListRelationFilter = {
    every?: Prisma.RebateTransactionWhereInput;
    some?: Prisma.RebateTransactionWhereInput;
    none?: Prisma.RebateTransactionWhereInput;
};
export type RebateTransactionOrderByRelationAggregateInput = {
    _count?: Prisma.SortOrder;
};
export type RebateTransactionCreateNestedOneWithoutOriginalTransactionInput = {
    create?: Prisma.XOR<Prisma.RebateTransactionCreateWithoutOriginalTransactionInput, Prisma.RebateTransactionUncheckedCreateWithoutOriginalTransactionInput>;
    connectOrCreate?: Prisma.RebateTransactionCreateOrConnectWithoutOriginalTransactionInput;
    connect?: Prisma.RebateTransactionWhereUniqueInput;
};
export type RebateTransactionUncheckedCreateNestedOneWithoutOriginalTransactionInput = {
    create?: Prisma.XOR<Prisma.RebateTransactionCreateWithoutOriginalTransactionInput, Prisma.RebateTransactionUncheckedCreateWithoutOriginalTransactionInput>;
    connectOrCreate?: Prisma.RebateTransactionCreateOrConnectWithoutOriginalTransactionInput;
    connect?: Prisma.RebateTransactionWhereUniqueInput;
};
export type RebateTransactionUpdateOneWithoutOriginalTransactionNestedInput = {
    create?: Prisma.XOR<Prisma.RebateTransactionCreateWithoutOriginalTransactionInput, Prisma.RebateTransactionUncheckedCreateWithoutOriginalTransactionInput>;
    connectOrCreate?: Prisma.RebateTransactionCreateOrConnectWithoutOriginalTransactionInput;
    upsert?: Prisma.RebateTransactionUpsertWithoutOriginalTransactionInput;
    disconnect?: Prisma.RebateTransactionWhereInput | boolean;
    delete?: Prisma.RebateTransactionWhereInput | boolean;
    connect?: Prisma.RebateTransactionWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.RebateTransactionUpdateToOneWithWhereWithoutOriginalTransactionInput, Prisma.RebateTransactionUpdateWithoutOriginalTransactionInput>, Prisma.RebateTransactionUncheckedUpdateWithoutOriginalTransactionInput>;
};
export type RebateTransactionUncheckedUpdateOneWithoutOriginalTransactionNestedInput = {
    create?: Prisma.XOR<Prisma.RebateTransactionCreateWithoutOriginalTransactionInput, Prisma.RebateTransactionUncheckedCreateWithoutOriginalTransactionInput>;
    connectOrCreate?: Prisma.RebateTransactionCreateOrConnectWithoutOriginalTransactionInput;
    upsert?: Prisma.RebateTransactionUpsertWithoutOriginalTransactionInput;
    disconnect?: Prisma.RebateTransactionWhereInput | boolean;
    delete?: Prisma.RebateTransactionWhereInput | boolean;
    connect?: Prisma.RebateTransactionWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.RebateTransactionUpdateToOneWithWhereWithoutOriginalTransactionInput, Prisma.RebateTransactionUpdateWithoutOriginalTransactionInput>, Prisma.RebateTransactionUncheckedUpdateWithoutOriginalTransactionInput>;
};
export type EnumRewardStatusFieldUpdateOperationsInput = {
    set?: $Enums.RewardStatus;
};
export type RebateTransactionCreateNestedManyWithoutUserInput = {
    create?: Prisma.XOR<Prisma.RebateTransactionCreateWithoutUserInput, Prisma.RebateTransactionUncheckedCreateWithoutUserInput> | Prisma.RebateTransactionCreateWithoutUserInput[] | Prisma.RebateTransactionUncheckedCreateWithoutUserInput[];
    connectOrCreate?: Prisma.RebateTransactionCreateOrConnectWithoutUserInput | Prisma.RebateTransactionCreateOrConnectWithoutUserInput[];
    createMany?: Prisma.RebateTransactionCreateManyUserInputEnvelope;
    connect?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
};
export type RebateTransactionUncheckedCreateNestedManyWithoutUserInput = {
    create?: Prisma.XOR<Prisma.RebateTransactionCreateWithoutUserInput, Prisma.RebateTransactionUncheckedCreateWithoutUserInput> | Prisma.RebateTransactionCreateWithoutUserInput[] | Prisma.RebateTransactionUncheckedCreateWithoutUserInput[];
    connectOrCreate?: Prisma.RebateTransactionCreateOrConnectWithoutUserInput | Prisma.RebateTransactionCreateOrConnectWithoutUserInput[];
    createMany?: Prisma.RebateTransactionCreateManyUserInputEnvelope;
    connect?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
};
export type RebateTransactionUpdateManyWithoutUserNestedInput = {
    create?: Prisma.XOR<Prisma.RebateTransactionCreateWithoutUserInput, Prisma.RebateTransactionUncheckedCreateWithoutUserInput> | Prisma.RebateTransactionCreateWithoutUserInput[] | Prisma.RebateTransactionUncheckedCreateWithoutUserInput[];
    connectOrCreate?: Prisma.RebateTransactionCreateOrConnectWithoutUserInput | Prisma.RebateTransactionCreateOrConnectWithoutUserInput[];
    upsert?: Prisma.RebateTransactionUpsertWithWhereUniqueWithoutUserInput | Prisma.RebateTransactionUpsertWithWhereUniqueWithoutUserInput[];
    createMany?: Prisma.RebateTransactionCreateManyUserInputEnvelope;
    set?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
    disconnect?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
    delete?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
    connect?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
    update?: Prisma.RebateTransactionUpdateWithWhereUniqueWithoutUserInput | Prisma.RebateTransactionUpdateWithWhereUniqueWithoutUserInput[];
    updateMany?: Prisma.RebateTransactionUpdateManyWithWhereWithoutUserInput | Prisma.RebateTransactionUpdateManyWithWhereWithoutUserInput[];
    deleteMany?: Prisma.RebateTransactionScalarWhereInput | Prisma.RebateTransactionScalarWhereInput[];
};
export type RebateTransactionUncheckedUpdateManyWithoutUserNestedInput = {
    create?: Prisma.XOR<Prisma.RebateTransactionCreateWithoutUserInput, Prisma.RebateTransactionUncheckedCreateWithoutUserInput> | Prisma.RebateTransactionCreateWithoutUserInput[] | Prisma.RebateTransactionUncheckedCreateWithoutUserInput[];
    connectOrCreate?: Prisma.RebateTransactionCreateOrConnectWithoutUserInput | Prisma.RebateTransactionCreateOrConnectWithoutUserInput[];
    upsert?: Prisma.RebateTransactionUpsertWithWhereUniqueWithoutUserInput | Prisma.RebateTransactionUpsertWithWhereUniqueWithoutUserInput[];
    createMany?: Prisma.RebateTransactionCreateManyUserInputEnvelope;
    set?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
    disconnect?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
    delete?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
    connect?: Prisma.RebateTransactionWhereUniqueInput | Prisma.RebateTransactionWhereUniqueInput[];
    update?: Prisma.RebateTransactionUpdateWithWhereUniqueWithoutUserInput | Prisma.RebateTransactionUpdateWithWhereUniqueWithoutUserInput[];
    updateMany?: Prisma.RebateTransactionUpdateManyWithWhereWithoutUserInput | Prisma.RebateTransactionUpdateManyWithWhereWithoutUserInput[];
    deleteMany?: Prisma.RebateTransactionScalarWhereInput | Prisma.RebateTransactionScalarWhereInput[];
};
export type RebateTransactionCreateWithoutOriginalTransactionInput = {
    id?: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status?: $Enums.RewardStatus;
    paidOutAt?: Date | string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    user: Prisma.UserProfileCreateNestedOneWithoutRebateTransactionsInput;
};
export type RebateTransactionUncheckedCreateWithoutOriginalTransactionInput = {
    id?: string;
    userId: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status?: $Enums.RewardStatus;
    paidOutAt?: Date | string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
};
export type RebateTransactionCreateOrConnectWithoutOriginalTransactionInput = {
    where: Prisma.RebateTransactionWhereUniqueInput;
    create: Prisma.XOR<Prisma.RebateTransactionCreateWithoutOriginalTransactionInput, Prisma.RebateTransactionUncheckedCreateWithoutOriginalTransactionInput>;
};
export type RebateTransactionUpsertWithoutOriginalTransactionInput = {
    update: Prisma.XOR<Prisma.RebateTransactionUpdateWithoutOriginalTransactionInput, Prisma.RebateTransactionUncheckedUpdateWithoutOriginalTransactionInput>;
    create: Prisma.XOR<Prisma.RebateTransactionCreateWithoutOriginalTransactionInput, Prisma.RebateTransactionUncheckedCreateWithoutOriginalTransactionInput>;
    where?: Prisma.RebateTransactionWhereInput;
};
export type RebateTransactionUpdateToOneWithWhereWithoutOriginalTransactionInput = {
    where?: Prisma.RebateTransactionWhereInput;
    data: Prisma.XOR<Prisma.RebateTransactionUpdateWithoutOriginalTransactionInput, Prisma.RebateTransactionUncheckedUpdateWithoutOriginalTransactionInput>;
};
export type RebateTransactionUpdateWithoutOriginalTransactionInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    user?: Prisma.UserProfileUpdateOneRequiredWithoutRebateTransactionsNestedInput;
};
export type RebateTransactionUncheckedUpdateWithoutOriginalTransactionInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
};
export type RebateTransactionCreateWithoutUserInput = {
    id?: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status?: $Enums.RewardStatus;
    paidOutAt?: Date | string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    originalTransaction: Prisma.TransactionCreateNestedOneWithoutRebateGeneratedInput;
};
export type RebateTransactionUncheckedCreateWithoutUserInput = {
    id?: string;
    transactionId: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status?: $Enums.RewardStatus;
    paidOutAt?: Date | string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
};
export type RebateTransactionCreateOrConnectWithoutUserInput = {
    where: Prisma.RebateTransactionWhereUniqueInput;
    create: Prisma.XOR<Prisma.RebateTransactionCreateWithoutUserInput, Prisma.RebateTransactionUncheckedCreateWithoutUserInput>;
};
export type RebateTransactionCreateManyUserInputEnvelope = {
    data: Prisma.RebateTransactionCreateManyUserInput | Prisma.RebateTransactionCreateManyUserInput[];
    skipDuplicates?: boolean;
};
export type RebateTransactionUpsertWithWhereUniqueWithoutUserInput = {
    where: Prisma.RebateTransactionWhereUniqueInput;
    update: Prisma.XOR<Prisma.RebateTransactionUpdateWithoutUserInput, Prisma.RebateTransactionUncheckedUpdateWithoutUserInput>;
    create: Prisma.XOR<Prisma.RebateTransactionCreateWithoutUserInput, Prisma.RebateTransactionUncheckedCreateWithoutUserInput>;
};
export type RebateTransactionUpdateWithWhereUniqueWithoutUserInput = {
    where: Prisma.RebateTransactionWhereUniqueInput;
    data: Prisma.XOR<Prisma.RebateTransactionUpdateWithoutUserInput, Prisma.RebateTransactionUncheckedUpdateWithoutUserInput>;
};
export type RebateTransactionUpdateManyWithWhereWithoutUserInput = {
    where: Prisma.RebateTransactionScalarWhereInput;
    data: Prisma.XOR<Prisma.RebateTransactionUpdateManyMutationInput, Prisma.RebateTransactionUncheckedUpdateManyWithoutUserInput>;
};
export type RebateTransactionScalarWhereInput = {
    AND?: Prisma.RebateTransactionScalarWhereInput | Prisma.RebateTransactionScalarWhereInput[];
    OR?: Prisma.RebateTransactionScalarWhereInput[];
    NOT?: Prisma.RebateTransactionScalarWhereInput | Prisma.RebateTransactionScalarWhereInput[];
    id?: Prisma.StringFilter<"RebateTransaction"> | string;
    userId?: Prisma.StringFilter<"RebateTransaction"> | string;
    transactionId?: Prisma.StringFilter<"RebateTransaction"> | string;
    rebateAmount?: Prisma.FloatFilter<"RebateTransaction"> | number;
    currencyId?: Prisma.StringFilter<"RebateTransaction"> | string;
    vipLevel?: Prisma.IntFilter<"RebateTransaction"> | number;
    rebatePercentage?: Prisma.FloatFilter<"RebateTransaction"> | number;
    status?: Prisma.EnumRewardStatusFilter<"RebateTransaction"> | $Enums.RewardStatus;
    paidOutAt?: Prisma.DateTimeNullableFilter<"RebateTransaction"> | Date | string | null;
    createdAt?: Prisma.DateTimeFilter<"RebateTransaction"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"RebateTransaction"> | Date | string;
};
export type RebateTransactionCreateManyUserInput = {
    id?: string;
    transactionId: string;
    rebateAmount: number;
    currencyId: string;
    vipLevel: number;
    rebatePercentage: number;
    status?: $Enums.RewardStatus;
    paidOutAt?: Date | string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
};
export type RebateTransactionUpdateWithoutUserInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    originalTransaction?: Prisma.TransactionUpdateOneRequiredWithoutRebateGeneratedNestedInput;
};
export type RebateTransactionUncheckedUpdateWithoutUserInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    transactionId?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
};
export type RebateTransactionUncheckedUpdateManyWithoutUserInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    transactionId?: Prisma.StringFieldUpdateOperationsInput | string;
    rebateAmount?: Prisma.FloatFieldUpdateOperationsInput | number;
    currencyId?: Prisma.StringFieldUpdateOperationsInput | string;
    vipLevel?: Prisma.IntFieldUpdateOperationsInput | number;
    rebatePercentage?: Prisma.FloatFieldUpdateOperationsInput | number;
    status?: Prisma.EnumRewardStatusFieldUpdateOperationsInput | $Enums.RewardStatus;
    paidOutAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
};
export type RebateTransactionSelect<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    userId?: boolean;
    transactionId?: boolean;
    rebateAmount?: boolean;
    currencyId?: boolean;
    vipLevel?: boolean;
    rebatePercentage?: boolean;
    status?: boolean;
    paidOutAt?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    user?: boolean | Prisma.UserProfileDefaultArgs<ExtArgs>;
    originalTransaction?: boolean | Prisma.TransactionDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["rebateTransaction"]>;
export type RebateTransactionSelectCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    userId?: boolean;
    transactionId?: boolean;
    rebateAmount?: boolean;
    currencyId?: boolean;
    vipLevel?: boolean;
    rebatePercentage?: boolean;
    status?: boolean;
    paidOutAt?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    user?: boolean | Prisma.UserProfileDefaultArgs<ExtArgs>;
    originalTransaction?: boolean | Prisma.TransactionDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["rebateTransaction"]>;
export type RebateTransactionSelectUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    userId?: boolean;
    transactionId?: boolean;
    rebateAmount?: boolean;
    currencyId?: boolean;
    vipLevel?: boolean;
    rebatePercentage?: boolean;
    status?: boolean;
    paidOutAt?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    user?: boolean | Prisma.UserProfileDefaultArgs<ExtArgs>;
    originalTransaction?: boolean | Prisma.TransactionDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["rebateTransaction"]>;
export type RebateTransactionSelectScalar = {
    id?: boolean;
    userId?: boolean;
    transactionId?: boolean;
    rebateAmount?: boolean;
    currencyId?: boolean;
    vipLevel?: boolean;
    rebatePercentage?: boolean;
    status?: boolean;
    paidOutAt?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
};
export type RebateTransactionOmit<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetOmit<"id" | "userId" | "transactionId" | "rebateAmount" | "currencyId" | "vipLevel" | "rebatePercentage" | "status" | "paidOutAt" | "createdAt" | "updatedAt", ExtArgs["result"]["rebateTransaction"]>;
export type RebateTransactionInclude<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    user?: boolean | Prisma.UserProfileDefaultArgs<ExtArgs>;
    originalTransaction?: boolean | Prisma.TransactionDefaultArgs<ExtArgs>;
};
export type RebateTransactionIncludeCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    user?: boolean | Prisma.UserProfileDefaultArgs<ExtArgs>;
    originalTransaction?: boolean | Prisma.TransactionDefaultArgs<ExtArgs>;
};
export type RebateTransactionIncludeUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    user?: boolean | Prisma.UserProfileDefaultArgs<ExtArgs>;
    originalTransaction?: boolean | Prisma.TransactionDefaultArgs<ExtArgs>;
};
export type $RebateTransactionPayload<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    name: "RebateTransaction";
    objects: {
        user: Prisma.$UserProfilePayload<ExtArgs>;
        originalTransaction: Prisma.$TransactionPayload<ExtArgs>;
    };
    scalars: runtime.Types.Extensions.GetPayloadResult<{
        id: string;
        userId: string;
        transactionId: string;
        rebateAmount: number;
        currencyId: string;
        vipLevel: number;
        rebatePercentage: number;
        status: $Enums.RewardStatus;
        paidOutAt: Date | null;
        createdAt: Date;
        updatedAt: Date;
    }, ExtArgs["result"]["rebateTransaction"]>;
    composites: {};
};
export type RebateTransactionGetPayload<S extends boolean | null | undefined | RebateTransactionDefaultArgs> = runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload, S>;
export type RebateTransactionCountArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = Omit<RebateTransactionFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
    select?: RebateTransactionCountAggregateInputType | true;
};
export interface RebateTransactionDelegate<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: {
        types: Prisma.TypeMap<ExtArgs>['model']['RebateTransaction'];
        meta: {
            name: 'RebateTransaction';
        };
    };
    /**
     * Find zero or one RebateTransaction that matches the filter.
     * @param {RebateTransactionFindUniqueArgs} args - Arguments to find a RebateTransaction
     * @example
     * // Get one RebateTransaction
     * const rebateTransaction = await prisma.rebateTransaction.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends RebateTransactionFindUniqueArgs>(args: Prisma.SelectSubset<T, RebateTransactionFindUniqueArgs<ExtArgs>>): Prisma.Prisma__RebateTransactionClient<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    /**
     * Find one RebateTransaction that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {RebateTransactionFindUniqueOrThrowArgs} args - Arguments to find a RebateTransaction
     * @example
     * // Get one RebateTransaction
     * const rebateTransaction = await prisma.rebateTransaction.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends RebateTransactionFindUniqueOrThrowArgs>(args: Prisma.SelectSubset<T, RebateTransactionFindUniqueOrThrowArgs<ExtArgs>>): Prisma.Prisma__RebateTransactionClient<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Find the first RebateTransaction that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {RebateTransactionFindFirstArgs} args - Arguments to find a RebateTransaction
     * @example
     * // Get one RebateTransaction
     * const rebateTransaction = await prisma.rebateTransaction.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends RebateTransactionFindFirstArgs>(args?: Prisma.SelectSubset<T, RebateTransactionFindFirstArgs<ExtArgs>>): Prisma.Prisma__RebateTransactionClient<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    /**
     * Find the first RebateTransaction that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {RebateTransactionFindFirstOrThrowArgs} args - Arguments to find a RebateTransaction
     * @example
     * // Get one RebateTransaction
     * const rebateTransaction = await prisma.rebateTransaction.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends RebateTransactionFindFirstOrThrowArgs>(args?: Prisma.SelectSubset<T, RebateTransactionFindFirstOrThrowArgs<ExtArgs>>): Prisma.Prisma__RebateTransactionClient<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Find zero or more RebateTransactions that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {RebateTransactionFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all RebateTransactions
     * const rebateTransactions = await prisma.rebateTransaction.findMany()
     *
     * // Get first 10 RebateTransactions
     * const rebateTransactions = await prisma.rebateTransaction.findMany({ take: 10 })
     *
     * // Only select the `id`
     * const rebateTransactionWithIdOnly = await prisma.rebateTransaction.findMany({ select: { id: true } })
     *
     */
    findMany<T extends RebateTransactionFindManyArgs>(args?: Prisma.SelectSubset<T, RebateTransactionFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>;
    /**
     * Create a RebateTransaction.
     * @param {RebateTransactionCreateArgs} args - Arguments to create a RebateTransaction.
     * @example
     * // Create one RebateTransaction
     * const RebateTransaction = await prisma.rebateTransaction.create({
     *   data: {
     *     // ... data to create a RebateTransaction
     *   }
     * })
     *
     */
    create<T extends RebateTransactionCreateArgs>(args: Prisma.SelectSubset<T, RebateTransactionCreateArgs<ExtArgs>>): Prisma.Prisma__RebateTransactionClient<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Create many RebateTransactions.
     * @param {RebateTransactionCreateManyArgs} args - Arguments to create many RebateTransactions.
     * @example
     * // Create many RebateTransactions
     * const rebateTransaction = await prisma.rebateTransaction.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     */
    createMany<T extends RebateTransactionCreateManyArgs>(args?: Prisma.SelectSubset<T, RebateTransactionCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Create many RebateTransactions and returns the data saved in the database.
     * @param {RebateTransactionCreateManyAndReturnArgs} args - Arguments to create many RebateTransactions.
     * @example
     * // Create many RebateTransactions
     * const rebateTransaction = await prisma.rebateTransaction.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     * // Create many RebateTransactions and only return the `id`
     * const rebateTransactionWithIdOnly = await prisma.rebateTransaction.createManyAndReturn({
     *   select: { id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     *
     */
    createManyAndReturn<T extends RebateTransactionCreateManyAndReturnArgs>(args?: Prisma.SelectSubset<T, RebateTransactionCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>;
    /**
     * Delete a RebateTransaction.
     * @param {RebateTransactionDeleteArgs} args - Arguments to delete one RebateTransaction.
     * @example
     * // Delete one RebateTransaction
     * const RebateTransaction = await prisma.rebateTransaction.delete({
     *   where: {
     *     // ... filter to delete one RebateTransaction
     *   }
     * })
     *
     */
    delete<T extends RebateTransactionDeleteArgs>(args: Prisma.SelectSubset<T, RebateTransactionDeleteArgs<ExtArgs>>): Prisma.Prisma__RebateTransactionClient<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Update one RebateTransaction.
     * @param {RebateTransactionUpdateArgs} args - Arguments to update one RebateTransaction.
     * @example
     * // Update one RebateTransaction
     * const rebateTransaction = await prisma.rebateTransaction.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     *
     */
    update<T extends RebateTransactionUpdateArgs>(args: Prisma.SelectSubset<T, RebateTransactionUpdateArgs<ExtArgs>>): Prisma.Prisma__RebateTransactionClient<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Delete zero or more RebateTransactions.
     * @param {RebateTransactionDeleteManyArgs} args - Arguments to filter RebateTransactions to delete.
     * @example
     * // Delete a few RebateTransactions
     * const { count } = await prisma.rebateTransaction.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     *
     */
    deleteMany<T extends RebateTransactionDeleteManyArgs>(args?: Prisma.SelectSubset<T, RebateTransactionDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Update zero or more RebateTransactions.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {RebateTransactionUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many RebateTransactions
     * const rebateTransaction = await prisma.rebateTransaction.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     *
     */
    updateMany<T extends RebateTransactionUpdateManyArgs>(args: Prisma.SelectSubset<T, RebateTransactionUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Update zero or more RebateTransactions and returns the data updated in the database.
     * @param {RebateTransactionUpdateManyAndReturnArgs} args - Arguments to update many RebateTransactions.
     * @example
     * // Update many RebateTransactions
     * const rebateTransaction = await prisma.rebateTransaction.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     * // Update zero or more RebateTransactions and only return the `id`
     * const rebateTransactionWithIdOnly = await prisma.rebateTransaction.updateManyAndReturn({
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
    updateManyAndReturn<T extends RebateTransactionUpdateManyAndReturnArgs>(args: Prisma.SelectSubset<T, RebateTransactionUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>;
    /**
     * Create or update one RebateTransaction.
     * @param {RebateTransactionUpsertArgs} args - Arguments to update or create a RebateTransaction.
     * @example
     * // Update or create a RebateTransaction
     * const rebateTransaction = await prisma.rebateTransaction.upsert({
     *   create: {
     *     // ... data to create a RebateTransaction
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the RebateTransaction we want to update
     *   }
     * })
     */
    upsert<T extends RebateTransactionUpsertArgs>(args: Prisma.SelectSubset<T, RebateTransactionUpsertArgs<ExtArgs>>): Prisma.Prisma__RebateTransactionClient<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Count the number of RebateTransactions.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {RebateTransactionCountArgs} args - Arguments to filter RebateTransactions to count.
     * @example
     * // Count the number of RebateTransactions
     * const count = await prisma.rebateTransaction.count({
     *   where: {
     *     // ... the filter for the RebateTransactions we want to count
     *   }
     * })
    **/
    count<T extends RebateTransactionCountArgs>(args?: Prisma.Subset<T, RebateTransactionCountArgs>): Prisma.PrismaPromise<T extends runtime.Types.Utils.Record<'select', any> ? T['select'] extends true ? number : Prisma.GetScalarType<T['select'], RebateTransactionCountAggregateOutputType> : number>;
    /**
     * Allows you to perform aggregations operations on a RebateTransaction.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {RebateTransactionAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
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
    aggregate<T extends RebateTransactionAggregateArgs>(args: Prisma.Subset<T, RebateTransactionAggregateArgs>): Prisma.PrismaPromise<GetRebateTransactionAggregateType<T>>;
    /**
     * Group by RebateTransaction.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {RebateTransactionGroupByArgs} args - Group by arguments.
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
    groupBy<T extends RebateTransactionGroupByArgs, HasSelectOrTake extends Prisma.Or<Prisma.Extends<'skip', Prisma.Keys<T>>, Prisma.Extends<'take', Prisma.Keys<T>>>, OrderByArg extends Prisma.True extends HasSelectOrTake ? {
        orderBy: RebateTransactionGroupByArgs['orderBy'];
    } : {
        orderBy?: RebateTransactionGroupByArgs['orderBy'];
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
    }[OrderFields]>(args: Prisma.SubsetIntersection<T, RebateTransactionGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetRebateTransactionGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>;
    /**
     * Fields of the RebateTransaction model
     */
    readonly fields: RebateTransactionFieldRefs;
}
/**
 * The delegate class that acts as a "Promise-like" for RebateTransaction.
 * Why is this prefixed with `Prisma__`?
 * Because we want to prevent naming conflicts as mentioned in
 * https://github.com/prisma/prisma-client-js/issues/707
 */
export interface Prisma__RebateTransactionClient<T, Null = never, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise";
    user<T extends Prisma.UserProfileDefaultArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfileDefaultArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>;
    originalTransaction<T extends Prisma.TransactionDefaultArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.TransactionDefaultArgs<ExtArgs>>): Prisma.Prisma__TransactionClient<runtime.Types.Result.GetResult<Prisma.$TransactionPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>;
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
 * Fields of the RebateTransaction model
 */
export interface RebateTransactionFieldRefs {
    readonly id: Prisma.FieldRef<"RebateTransaction", 'String'>;
    readonly userId: Prisma.FieldRef<"RebateTransaction", 'String'>;
    readonly transactionId: Prisma.FieldRef<"RebateTransaction", 'String'>;
    readonly rebateAmount: Prisma.FieldRef<"RebateTransaction", 'Float'>;
    readonly currencyId: Prisma.FieldRef<"RebateTransaction", 'String'>;
    readonly vipLevel: Prisma.FieldRef<"RebateTransaction", 'Int'>;
    readonly rebatePercentage: Prisma.FieldRef<"RebateTransaction", 'Float'>;
    readonly status: Prisma.FieldRef<"RebateTransaction", 'RewardStatus'>;
    readonly paidOutAt: Prisma.FieldRef<"RebateTransaction", 'DateTime'>;
    readonly createdAt: Prisma.FieldRef<"RebateTransaction", 'DateTime'>;
    readonly updatedAt: Prisma.FieldRef<"RebateTransaction", 'DateTime'>;
}
/**
 * RebateTransaction findUnique
 */
export type RebateTransactionFindUniqueArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * Filter, which RebateTransaction to fetch.
     */
    where: Prisma.RebateTransactionWhereUniqueInput;
};
/**
 * RebateTransaction findUniqueOrThrow
 */
export type RebateTransactionFindUniqueOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * Filter, which RebateTransaction to fetch.
     */
    where: Prisma.RebateTransactionWhereUniqueInput;
};
/**
 * RebateTransaction findFirst
 */
export type RebateTransactionFindFirstArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * Filter, which RebateTransaction to fetch.
     */
    where?: Prisma.RebateTransactionWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of RebateTransactions to fetch.
     */
    orderBy?: Prisma.RebateTransactionOrderByWithRelationInput | Prisma.RebateTransactionOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for searching for RebateTransactions.
     */
    cursor?: Prisma.RebateTransactionWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` RebateTransactions from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` RebateTransactions.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     *
     * Filter by unique combinations of RebateTransactions.
     */
    distinct?: Prisma.RebateTransactionScalarFieldEnum | Prisma.RebateTransactionScalarFieldEnum[];
};
/**
 * RebateTransaction findFirstOrThrow
 */
export type RebateTransactionFindFirstOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * Filter, which RebateTransaction to fetch.
     */
    where?: Prisma.RebateTransactionWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of RebateTransactions to fetch.
     */
    orderBy?: Prisma.RebateTransactionOrderByWithRelationInput | Prisma.RebateTransactionOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for searching for RebateTransactions.
     */
    cursor?: Prisma.RebateTransactionWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` RebateTransactions from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` RebateTransactions.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     *
     * Filter by unique combinations of RebateTransactions.
     */
    distinct?: Prisma.RebateTransactionScalarFieldEnum | Prisma.RebateTransactionScalarFieldEnum[];
};
/**
 * RebateTransaction findMany
 */
export type RebateTransactionFindManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * Filter, which RebateTransactions to fetch.
     */
    where?: Prisma.RebateTransactionWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of RebateTransactions to fetch.
     */
    orderBy?: Prisma.RebateTransactionOrderByWithRelationInput | Prisma.RebateTransactionOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for listing RebateTransactions.
     */
    cursor?: Prisma.RebateTransactionWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` RebateTransactions from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` RebateTransactions.
     */
    skip?: number;
    distinct?: Prisma.RebateTransactionScalarFieldEnum | Prisma.RebateTransactionScalarFieldEnum[];
};
/**
 * RebateTransaction create
 */
export type RebateTransactionCreateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * The data needed to create a RebateTransaction.
     */
    data: Prisma.XOR<Prisma.RebateTransactionCreateInput, Prisma.RebateTransactionUncheckedCreateInput>;
};
/**
 * RebateTransaction createMany
 */
export type RebateTransactionCreateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * The data used to create many RebateTransactions.
     */
    data: Prisma.RebateTransactionCreateManyInput | Prisma.RebateTransactionCreateManyInput[];
    skipDuplicates?: boolean;
};
/**
 * RebateTransaction createManyAndReturn
 */
export type RebateTransactionCreateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelectCreateManyAndReturn<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * The data used to create many RebateTransactions.
     */
    data: Prisma.RebateTransactionCreateManyInput | Prisma.RebateTransactionCreateManyInput[];
    skipDuplicates?: boolean;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionIncludeCreateManyAndReturn<ExtArgs> | null;
};
/**
 * RebateTransaction update
 */
export type RebateTransactionUpdateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * The data needed to update a RebateTransaction.
     */
    data: Prisma.XOR<Prisma.RebateTransactionUpdateInput, Prisma.RebateTransactionUncheckedUpdateInput>;
    /**
     * Choose, which RebateTransaction to update.
     */
    where: Prisma.RebateTransactionWhereUniqueInput;
};
/**
 * RebateTransaction updateMany
 */
export type RebateTransactionUpdateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * The data used to update RebateTransactions.
     */
    data: Prisma.XOR<Prisma.RebateTransactionUpdateManyMutationInput, Prisma.RebateTransactionUncheckedUpdateManyInput>;
    /**
     * Filter which RebateTransactions to update
     */
    where?: Prisma.RebateTransactionWhereInput;
    /**
     * Limit how many RebateTransactions to update.
     */
    limit?: number;
};
/**
 * RebateTransaction updateManyAndReturn
 */
export type RebateTransactionUpdateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelectUpdateManyAndReturn<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * The data used to update RebateTransactions.
     */
    data: Prisma.XOR<Prisma.RebateTransactionUpdateManyMutationInput, Prisma.RebateTransactionUncheckedUpdateManyInput>;
    /**
     * Filter which RebateTransactions to update
     */
    where?: Prisma.RebateTransactionWhereInput;
    /**
     * Limit how many RebateTransactions to update.
     */
    limit?: number;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionIncludeUpdateManyAndReturn<ExtArgs> | null;
};
/**
 * RebateTransaction upsert
 */
export type RebateTransactionUpsertArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * The filter to search for the RebateTransaction to update in case it exists.
     */
    where: Prisma.RebateTransactionWhereUniqueInput;
    /**
     * In case the RebateTransaction found by the `where` argument doesn't exist, create a new RebateTransaction with this data.
     */
    create: Prisma.XOR<Prisma.RebateTransactionCreateInput, Prisma.RebateTransactionUncheckedCreateInput>;
    /**
     * In case the RebateTransaction was found with the provided `where` argument, update it with this data.
     */
    update: Prisma.XOR<Prisma.RebateTransactionUpdateInput, Prisma.RebateTransactionUncheckedUpdateInput>;
};
/**
 * RebateTransaction delete
 */
export type RebateTransactionDeleteArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
    /**
     * Filter which RebateTransaction to delete.
     */
    where: Prisma.RebateTransactionWhereUniqueInput;
};
/**
 * RebateTransaction deleteMany
 */
export type RebateTransactionDeleteManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Filter which RebateTransactions to delete
     */
    where?: Prisma.RebateTransactionWhereInput;
    /**
     * Limit how many RebateTransactions to delete.
     */
    limit?: number;
};
/**
 * RebateTransaction without action
 */
export type RebateTransactionDefaultArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the RebateTransaction
     */
    select?: Prisma.RebateTransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the RebateTransaction
     */
    omit?: Prisma.RebateTransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.RebateTransactionInclude<ExtArgs> | null;
};
export {};
