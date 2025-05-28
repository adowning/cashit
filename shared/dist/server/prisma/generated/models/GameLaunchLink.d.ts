/**
 * This file exports the `GameLaunchLink` model and its related types.
 *
 * 🟢 You can import this file directly.
 */
import * as runtime from "@prisma/client/runtime/library";
import type * as Prisma from "../internal/prismaNamespace.ts";
/**
 * Model GameLaunchLink
 *
 */
export type GameLaunchLinkModel = runtime.Types.Result.DefaultSelection<Prisma.$GameLaunchLinkPayload>;
export type AggregateGameLaunchLink = {
    _count: GameLaunchLinkCountAggregateOutputType | null;
    _min: GameLaunchLinkMinAggregateOutputType | null;
    _max: GameLaunchLinkMaxAggregateOutputType | null;
};
export type GameLaunchLinkMinAggregateOutputType = {
    id: string | null;
    token_internal: string | null;
    currency: string | null;
    player_operator_id: string | null;
    mode: string | null;
    requestIp: string | null;
    userAgent: string | null;
    session_url: string | null;
    state: string | null;
    active: boolean | null;
    expiresAt: Date | null;
    token_original: string | null;
    createdAt: Date | null;
    updatedAt: Date | null;
    userId: string | null;
    gameId: string | null;
    operatorId: string | null;
    userProfileId: string | null;
};
export type GameLaunchLinkMaxAggregateOutputType = {
    id: string | null;
    token_internal: string | null;
    currency: string | null;
    player_operator_id: string | null;
    mode: string | null;
    requestIp: string | null;
    userAgent: string | null;
    session_url: string | null;
    state: string | null;
    active: boolean | null;
    expiresAt: Date | null;
    token_original: string | null;
    createdAt: Date | null;
    updatedAt: Date | null;
    userId: string | null;
    gameId: string | null;
    operatorId: string | null;
    userProfileId: string | null;
};
export type GameLaunchLinkCountAggregateOutputType = {
    id: number;
    token_internal: number;
    currency: number;
    player_operator_id: number;
    mode: number;
    meta: number;
    requestIp: number;
    userAgent: number;
    session_url: number;
    state: number;
    active: number;
    expiresAt: number;
    extra_meta: number;
    token_original: number;
    createdAt: number;
    updatedAt: number;
    userId: number;
    gameId: number;
    operatorId: number;
    userProfileId: number;
    _all: number;
};
export type GameLaunchLinkMinAggregateInputType = {
    id?: true;
    token_internal?: true;
    currency?: true;
    player_operator_id?: true;
    mode?: true;
    requestIp?: true;
    userAgent?: true;
    session_url?: true;
    state?: true;
    active?: true;
    expiresAt?: true;
    token_original?: true;
    createdAt?: true;
    updatedAt?: true;
    userId?: true;
    gameId?: true;
    operatorId?: true;
    userProfileId?: true;
};
export type GameLaunchLinkMaxAggregateInputType = {
    id?: true;
    token_internal?: true;
    currency?: true;
    player_operator_id?: true;
    mode?: true;
    requestIp?: true;
    userAgent?: true;
    session_url?: true;
    state?: true;
    active?: true;
    expiresAt?: true;
    token_original?: true;
    createdAt?: true;
    updatedAt?: true;
    userId?: true;
    gameId?: true;
    operatorId?: true;
    userProfileId?: true;
};
export type GameLaunchLinkCountAggregateInputType = {
    id?: true;
    token_internal?: true;
    currency?: true;
    player_operator_id?: true;
    mode?: true;
    meta?: true;
    requestIp?: true;
    userAgent?: true;
    session_url?: true;
    state?: true;
    active?: true;
    expiresAt?: true;
    extra_meta?: true;
    token_original?: true;
    createdAt?: true;
    updatedAt?: true;
    userId?: true;
    gameId?: true;
    operatorId?: true;
    userProfileId?: true;
    _all?: true;
};
export type GameLaunchLinkAggregateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Filter which GameLaunchLink to aggregate.
     */
    where?: Prisma.GameLaunchLinkWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of GameLaunchLinks to fetch.
     */
    orderBy?: Prisma.GameLaunchLinkOrderByWithRelationInput | Prisma.GameLaunchLinkOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the start position
     */
    cursor?: Prisma.GameLaunchLinkWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` GameLaunchLinks from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` GameLaunchLinks.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Count returned GameLaunchLinks
    **/
    _count?: true | GameLaunchLinkCountAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to find the minimum value
    **/
    _min?: GameLaunchLinkMinAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to find the maximum value
    **/
    _max?: GameLaunchLinkMaxAggregateInputType;
};
export type GetGameLaunchLinkAggregateType<T extends GameLaunchLinkAggregateArgs> = {
    [P in keyof T & keyof AggregateGameLaunchLink]: P extends '_count' | 'count' ? T[P] extends true ? number : Prisma.GetScalarType<T[P], AggregateGameLaunchLink[P]> : Prisma.GetScalarType<T[P], AggregateGameLaunchLink[P]>;
};
export type GameLaunchLinkGroupByArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.GameLaunchLinkWhereInput;
    orderBy?: Prisma.GameLaunchLinkOrderByWithAggregationInput | Prisma.GameLaunchLinkOrderByWithAggregationInput[];
    by: Prisma.GameLaunchLinkScalarFieldEnum[] | Prisma.GameLaunchLinkScalarFieldEnum;
    having?: Prisma.GameLaunchLinkScalarWhereWithAggregatesInput;
    take?: number;
    skip?: number;
    _count?: GameLaunchLinkCountAggregateInputType | true;
    _min?: GameLaunchLinkMinAggregateInputType;
    _max?: GameLaunchLinkMaxAggregateInputType;
};
export type GameLaunchLinkGroupByOutputType = {
    id: string;
    token_internal: string;
    currency: string;
    player_operator_id: string | null;
    mode: string;
    meta: runtime.JsonValue | null;
    requestIp: string | null;
    userAgent: string | null;
    session_url: string | null;
    state: string;
    active: boolean;
    expiresAt: Date | null;
    extra_meta: runtime.JsonValue | null;
    token_original: string | null;
    createdAt: Date;
    updatedAt: Date;
    userId: string;
    gameId: string;
    operatorId: string;
    userProfileId: string | null;
    _count: GameLaunchLinkCountAggregateOutputType | null;
    _min: GameLaunchLinkMinAggregateOutputType | null;
    _max: GameLaunchLinkMaxAggregateOutputType | null;
};
type GetGameLaunchLinkGroupByPayload<T extends GameLaunchLinkGroupByArgs> = Prisma.PrismaPromise<Array<Prisma.PickEnumerable<GameLaunchLinkGroupByOutputType, T['by']> & {
    [P in ((keyof T) & (keyof GameLaunchLinkGroupByOutputType))]: P extends '_count' ? T[P] extends boolean ? number : Prisma.GetScalarType<T[P], GameLaunchLinkGroupByOutputType[P]> : Prisma.GetScalarType<T[P], GameLaunchLinkGroupByOutputType[P]>;
}>>;
export type GameLaunchLinkWhereInput = {
    AND?: Prisma.GameLaunchLinkWhereInput | Prisma.GameLaunchLinkWhereInput[];
    OR?: Prisma.GameLaunchLinkWhereInput[];
    NOT?: Prisma.GameLaunchLinkWhereInput | Prisma.GameLaunchLinkWhereInput[];
    id?: Prisma.StringFilter<"GameLaunchLink"> | string;
    token_internal?: Prisma.StringFilter<"GameLaunchLink"> | string;
    currency?: Prisma.StringFilter<"GameLaunchLink"> | string;
    player_operator_id?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    mode?: Prisma.StringFilter<"GameLaunchLink"> | string;
    meta?: Prisma.JsonNullableFilter<"GameLaunchLink">;
    requestIp?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    userAgent?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    session_url?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    state?: Prisma.StringFilter<"GameLaunchLink"> | string;
    active?: Prisma.BoolFilter<"GameLaunchLink"> | boolean;
    expiresAt?: Prisma.DateTimeNullableFilter<"GameLaunchLink"> | Date | string | null;
    extra_meta?: Prisma.JsonNullableFilter<"GameLaunchLink">;
    token_original?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    createdAt?: Prisma.DateTimeFilter<"GameLaunchLink"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"GameLaunchLink"> | Date | string;
    userId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    gameId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    operatorId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    userProfileId?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    game?: Prisma.XOR<Prisma.GameScalarRelationFilter, Prisma.GameWhereInput>;
    operator?: Prisma.XOR<Prisma.OperatorScalarRelationFilter, Prisma.OperatorWhereInput>;
    UserProfile?: Prisma.XOR<Prisma.UserProfileNullableScalarRelationFilter, Prisma.UserProfileWhereInput> | null;
};
export type GameLaunchLinkOrderByWithRelationInput = {
    id?: Prisma.SortOrder;
    token_internal?: Prisma.SortOrder;
    currency?: Prisma.SortOrder;
    player_operator_id?: Prisma.SortOrderInput | Prisma.SortOrder;
    mode?: Prisma.SortOrder;
    meta?: Prisma.SortOrderInput | Prisma.SortOrder;
    requestIp?: Prisma.SortOrderInput | Prisma.SortOrder;
    userAgent?: Prisma.SortOrderInput | Prisma.SortOrder;
    session_url?: Prisma.SortOrderInput | Prisma.SortOrder;
    state?: Prisma.SortOrder;
    active?: Prisma.SortOrder;
    expiresAt?: Prisma.SortOrderInput | Prisma.SortOrder;
    extra_meta?: Prisma.SortOrderInput | Prisma.SortOrder;
    token_original?: Prisma.SortOrderInput | Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    operatorId?: Prisma.SortOrder;
    userProfileId?: Prisma.SortOrderInput | Prisma.SortOrder;
    game?: Prisma.GameOrderByWithRelationInput;
    operator?: Prisma.OperatorOrderByWithRelationInput;
    UserProfile?: Prisma.UserProfileOrderByWithRelationInput;
};
export type GameLaunchLinkWhereUniqueInput = Prisma.AtLeast<{
    id?: string;
    token_internal?: string;
    session_url?: string;
    AND?: Prisma.GameLaunchLinkWhereInput | Prisma.GameLaunchLinkWhereInput[];
    OR?: Prisma.GameLaunchLinkWhereInput[];
    NOT?: Prisma.GameLaunchLinkWhereInput | Prisma.GameLaunchLinkWhereInput[];
    currency?: Prisma.StringFilter<"GameLaunchLink"> | string;
    player_operator_id?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    mode?: Prisma.StringFilter<"GameLaunchLink"> | string;
    meta?: Prisma.JsonNullableFilter<"GameLaunchLink">;
    requestIp?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    userAgent?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    state?: Prisma.StringFilter<"GameLaunchLink"> | string;
    active?: Prisma.BoolFilter<"GameLaunchLink"> | boolean;
    expiresAt?: Prisma.DateTimeNullableFilter<"GameLaunchLink"> | Date | string | null;
    extra_meta?: Prisma.JsonNullableFilter<"GameLaunchLink">;
    token_original?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    createdAt?: Prisma.DateTimeFilter<"GameLaunchLink"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"GameLaunchLink"> | Date | string;
    userId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    gameId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    operatorId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    userProfileId?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    game?: Prisma.XOR<Prisma.GameScalarRelationFilter, Prisma.GameWhereInput>;
    operator?: Prisma.XOR<Prisma.OperatorScalarRelationFilter, Prisma.OperatorWhereInput>;
    UserProfile?: Prisma.XOR<Prisma.UserProfileNullableScalarRelationFilter, Prisma.UserProfileWhereInput> | null;
}, "id" | "token_internal" | "session_url">;
export type GameLaunchLinkOrderByWithAggregationInput = {
    id?: Prisma.SortOrder;
    token_internal?: Prisma.SortOrder;
    currency?: Prisma.SortOrder;
    player_operator_id?: Prisma.SortOrderInput | Prisma.SortOrder;
    mode?: Prisma.SortOrder;
    meta?: Prisma.SortOrderInput | Prisma.SortOrder;
    requestIp?: Prisma.SortOrderInput | Prisma.SortOrder;
    userAgent?: Prisma.SortOrderInput | Prisma.SortOrder;
    session_url?: Prisma.SortOrderInput | Prisma.SortOrder;
    state?: Prisma.SortOrder;
    active?: Prisma.SortOrder;
    expiresAt?: Prisma.SortOrderInput | Prisma.SortOrder;
    extra_meta?: Prisma.SortOrderInput | Prisma.SortOrder;
    token_original?: Prisma.SortOrderInput | Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    operatorId?: Prisma.SortOrder;
    userProfileId?: Prisma.SortOrderInput | Prisma.SortOrder;
    _count?: Prisma.GameLaunchLinkCountOrderByAggregateInput;
    _max?: Prisma.GameLaunchLinkMaxOrderByAggregateInput;
    _min?: Prisma.GameLaunchLinkMinOrderByAggregateInput;
};
export type GameLaunchLinkScalarWhereWithAggregatesInput = {
    AND?: Prisma.GameLaunchLinkScalarWhereWithAggregatesInput | Prisma.GameLaunchLinkScalarWhereWithAggregatesInput[];
    OR?: Prisma.GameLaunchLinkScalarWhereWithAggregatesInput[];
    NOT?: Prisma.GameLaunchLinkScalarWhereWithAggregatesInput | Prisma.GameLaunchLinkScalarWhereWithAggregatesInput[];
    id?: Prisma.StringWithAggregatesFilter<"GameLaunchLink"> | string;
    token_internal?: Prisma.StringWithAggregatesFilter<"GameLaunchLink"> | string;
    currency?: Prisma.StringWithAggregatesFilter<"GameLaunchLink"> | string;
    player_operator_id?: Prisma.StringNullableWithAggregatesFilter<"GameLaunchLink"> | string | null;
    mode?: Prisma.StringWithAggregatesFilter<"GameLaunchLink"> | string;
    meta?: Prisma.JsonNullableWithAggregatesFilter<"GameLaunchLink">;
    requestIp?: Prisma.StringNullableWithAggregatesFilter<"GameLaunchLink"> | string | null;
    userAgent?: Prisma.StringNullableWithAggregatesFilter<"GameLaunchLink"> | string | null;
    session_url?: Prisma.StringNullableWithAggregatesFilter<"GameLaunchLink"> | string | null;
    state?: Prisma.StringWithAggregatesFilter<"GameLaunchLink"> | string;
    active?: Prisma.BoolWithAggregatesFilter<"GameLaunchLink"> | boolean;
    expiresAt?: Prisma.DateTimeNullableWithAggregatesFilter<"GameLaunchLink"> | Date | string | null;
    extra_meta?: Prisma.JsonNullableWithAggregatesFilter<"GameLaunchLink">;
    token_original?: Prisma.StringNullableWithAggregatesFilter<"GameLaunchLink"> | string | null;
    createdAt?: Prisma.DateTimeWithAggregatesFilter<"GameLaunchLink"> | Date | string;
    updatedAt?: Prisma.DateTimeWithAggregatesFilter<"GameLaunchLink"> | Date | string;
    userId?: Prisma.StringWithAggregatesFilter<"GameLaunchLink"> | string;
    gameId?: Prisma.StringWithAggregatesFilter<"GameLaunchLink"> | string;
    operatorId?: Prisma.StringWithAggregatesFilter<"GameLaunchLink"> | string;
    userProfileId?: Prisma.StringNullableWithAggregatesFilter<"GameLaunchLink"> | string | null;
};
export type GameLaunchLinkCreateInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    game: Prisma.GameCreateNestedOneWithoutGameLaunchLinksInput;
    operator: Prisma.OperatorCreateNestedOneWithoutGameLaunchLinksInput;
    UserProfile?: Prisma.UserProfileCreateNestedOneWithoutGameLaunchLinkInput;
};
export type GameLaunchLinkUncheckedCreateInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    gameId: string;
    operatorId: string;
    userProfileId?: string | null;
};
export type GameLaunchLinkUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    game?: Prisma.GameUpdateOneRequiredWithoutGameLaunchLinksNestedInput;
    operator?: Prisma.OperatorUpdateOneRequiredWithoutGameLaunchLinksNestedInput;
    UserProfile?: Prisma.UserProfileUpdateOneWithoutGameLaunchLinkNestedInput;
};
export type GameLaunchLinkUncheckedUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    operatorId?: Prisma.StringFieldUpdateOperationsInput | string;
    userProfileId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
export type GameLaunchLinkCreateManyInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    gameId: string;
    operatorId: string;
    userProfileId?: string | null;
};
export type GameLaunchLinkUpdateManyMutationInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type GameLaunchLinkUncheckedUpdateManyInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    operatorId?: Prisma.StringFieldUpdateOperationsInput | string;
    userProfileId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
export type GameLaunchLinkListRelationFilter = {
    every?: Prisma.GameLaunchLinkWhereInput;
    some?: Prisma.GameLaunchLinkWhereInput;
    none?: Prisma.GameLaunchLinkWhereInput;
};
export type GameLaunchLinkOrderByRelationAggregateInput = {
    _count?: Prisma.SortOrder;
};
export type GameLaunchLinkCountOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    token_internal?: Prisma.SortOrder;
    currency?: Prisma.SortOrder;
    player_operator_id?: Prisma.SortOrder;
    mode?: Prisma.SortOrder;
    meta?: Prisma.SortOrder;
    requestIp?: Prisma.SortOrder;
    userAgent?: Prisma.SortOrder;
    session_url?: Prisma.SortOrder;
    state?: Prisma.SortOrder;
    active?: Prisma.SortOrder;
    expiresAt?: Prisma.SortOrder;
    extra_meta?: Prisma.SortOrder;
    token_original?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    operatorId?: Prisma.SortOrder;
    userProfileId?: Prisma.SortOrder;
};
export type GameLaunchLinkMaxOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    token_internal?: Prisma.SortOrder;
    currency?: Prisma.SortOrder;
    player_operator_id?: Prisma.SortOrder;
    mode?: Prisma.SortOrder;
    requestIp?: Prisma.SortOrder;
    userAgent?: Prisma.SortOrder;
    session_url?: Prisma.SortOrder;
    state?: Prisma.SortOrder;
    active?: Prisma.SortOrder;
    expiresAt?: Prisma.SortOrder;
    token_original?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    operatorId?: Prisma.SortOrder;
    userProfileId?: Prisma.SortOrder;
};
export type GameLaunchLinkMinOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    token_internal?: Prisma.SortOrder;
    currency?: Prisma.SortOrder;
    player_operator_id?: Prisma.SortOrder;
    mode?: Prisma.SortOrder;
    requestIp?: Prisma.SortOrder;
    userAgent?: Prisma.SortOrder;
    session_url?: Prisma.SortOrder;
    state?: Prisma.SortOrder;
    active?: Prisma.SortOrder;
    expiresAt?: Prisma.SortOrder;
    token_original?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    gameId?: Prisma.SortOrder;
    operatorId?: Prisma.SortOrder;
    userProfileId?: Prisma.SortOrder;
};
export type GameLaunchLinkCreateNestedManyWithoutGameInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutGameInput, Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput> | Prisma.GameLaunchLinkCreateWithoutGameInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutGameInput | Prisma.GameLaunchLinkCreateOrConnectWithoutGameInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyGameInputEnvelope;
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
};
export type GameLaunchLinkUncheckedCreateNestedManyWithoutGameInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutGameInput, Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput> | Prisma.GameLaunchLinkCreateWithoutGameInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutGameInput | Prisma.GameLaunchLinkCreateOrConnectWithoutGameInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyGameInputEnvelope;
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
};
export type GameLaunchLinkUpdateManyWithoutGameNestedInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutGameInput, Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput> | Prisma.GameLaunchLinkCreateWithoutGameInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutGameInput | Prisma.GameLaunchLinkCreateOrConnectWithoutGameInput[];
    upsert?: Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutGameInput | Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutGameInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyGameInputEnvelope;
    set?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    disconnect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    delete?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    update?: Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutGameInput | Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutGameInput[];
    updateMany?: Prisma.GameLaunchLinkUpdateManyWithWhereWithoutGameInput | Prisma.GameLaunchLinkUpdateManyWithWhereWithoutGameInput[];
    deleteMany?: Prisma.GameLaunchLinkScalarWhereInput | Prisma.GameLaunchLinkScalarWhereInput[];
};
export type GameLaunchLinkUncheckedUpdateManyWithoutGameNestedInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutGameInput, Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput> | Prisma.GameLaunchLinkCreateWithoutGameInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutGameInput | Prisma.GameLaunchLinkCreateOrConnectWithoutGameInput[];
    upsert?: Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutGameInput | Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutGameInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyGameInputEnvelope;
    set?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    disconnect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    delete?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    update?: Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutGameInput | Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutGameInput[];
    updateMany?: Prisma.GameLaunchLinkUpdateManyWithWhereWithoutGameInput | Prisma.GameLaunchLinkUpdateManyWithWhereWithoutGameInput[];
    deleteMany?: Prisma.GameLaunchLinkScalarWhereInput | Prisma.GameLaunchLinkScalarWhereInput[];
};
export type GameLaunchLinkCreateNestedManyWithoutOperatorInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutOperatorInput, Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput> | Prisma.GameLaunchLinkCreateWithoutOperatorInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutOperatorInput | Prisma.GameLaunchLinkCreateOrConnectWithoutOperatorInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyOperatorInputEnvelope;
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
};
export type GameLaunchLinkUncheckedCreateNestedManyWithoutOperatorInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutOperatorInput, Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput> | Prisma.GameLaunchLinkCreateWithoutOperatorInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutOperatorInput | Prisma.GameLaunchLinkCreateOrConnectWithoutOperatorInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyOperatorInputEnvelope;
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
};
export type GameLaunchLinkUpdateManyWithoutOperatorNestedInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutOperatorInput, Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput> | Prisma.GameLaunchLinkCreateWithoutOperatorInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutOperatorInput | Prisma.GameLaunchLinkCreateOrConnectWithoutOperatorInput[];
    upsert?: Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutOperatorInput | Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutOperatorInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyOperatorInputEnvelope;
    set?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    disconnect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    delete?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    update?: Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutOperatorInput | Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutOperatorInput[];
    updateMany?: Prisma.GameLaunchLinkUpdateManyWithWhereWithoutOperatorInput | Prisma.GameLaunchLinkUpdateManyWithWhereWithoutOperatorInput[];
    deleteMany?: Prisma.GameLaunchLinkScalarWhereInput | Prisma.GameLaunchLinkScalarWhereInput[];
};
export type GameLaunchLinkUncheckedUpdateManyWithoutOperatorNestedInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutOperatorInput, Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput> | Prisma.GameLaunchLinkCreateWithoutOperatorInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutOperatorInput | Prisma.GameLaunchLinkCreateOrConnectWithoutOperatorInput[];
    upsert?: Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutOperatorInput | Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutOperatorInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyOperatorInputEnvelope;
    set?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    disconnect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    delete?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    update?: Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutOperatorInput | Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutOperatorInput[];
    updateMany?: Prisma.GameLaunchLinkUpdateManyWithWhereWithoutOperatorInput | Prisma.GameLaunchLinkUpdateManyWithWhereWithoutOperatorInput[];
    deleteMany?: Prisma.GameLaunchLinkScalarWhereInput | Prisma.GameLaunchLinkScalarWhereInput[];
};
export type GameLaunchLinkCreateNestedManyWithoutUserProfileInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutUserProfileInput, Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput> | Prisma.GameLaunchLinkCreateWithoutUserProfileInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutUserProfileInput | Prisma.GameLaunchLinkCreateOrConnectWithoutUserProfileInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyUserProfileInputEnvelope;
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
};
export type GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutUserProfileInput, Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput> | Prisma.GameLaunchLinkCreateWithoutUserProfileInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutUserProfileInput | Prisma.GameLaunchLinkCreateOrConnectWithoutUserProfileInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyUserProfileInputEnvelope;
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
};
export type GameLaunchLinkUpdateManyWithoutUserProfileNestedInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutUserProfileInput, Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput> | Prisma.GameLaunchLinkCreateWithoutUserProfileInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutUserProfileInput | Prisma.GameLaunchLinkCreateOrConnectWithoutUserProfileInput[];
    upsert?: Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutUserProfileInput | Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutUserProfileInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyUserProfileInputEnvelope;
    set?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    disconnect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    delete?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    update?: Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutUserProfileInput | Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutUserProfileInput[];
    updateMany?: Prisma.GameLaunchLinkUpdateManyWithWhereWithoutUserProfileInput | Prisma.GameLaunchLinkUpdateManyWithWhereWithoutUserProfileInput[];
    deleteMany?: Prisma.GameLaunchLinkScalarWhereInput | Prisma.GameLaunchLinkScalarWhereInput[];
};
export type GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput = {
    create?: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutUserProfileInput, Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput> | Prisma.GameLaunchLinkCreateWithoutUserProfileInput[] | Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput[];
    connectOrCreate?: Prisma.GameLaunchLinkCreateOrConnectWithoutUserProfileInput | Prisma.GameLaunchLinkCreateOrConnectWithoutUserProfileInput[];
    upsert?: Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutUserProfileInput | Prisma.GameLaunchLinkUpsertWithWhereUniqueWithoutUserProfileInput[];
    createMany?: Prisma.GameLaunchLinkCreateManyUserProfileInputEnvelope;
    set?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    disconnect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    delete?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    connect?: Prisma.GameLaunchLinkWhereUniqueInput | Prisma.GameLaunchLinkWhereUniqueInput[];
    update?: Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutUserProfileInput | Prisma.GameLaunchLinkUpdateWithWhereUniqueWithoutUserProfileInput[];
    updateMany?: Prisma.GameLaunchLinkUpdateManyWithWhereWithoutUserProfileInput | Prisma.GameLaunchLinkUpdateManyWithWhereWithoutUserProfileInput[];
    deleteMany?: Prisma.GameLaunchLinkScalarWhereInput | Prisma.GameLaunchLinkScalarWhereInput[];
};
export type GameLaunchLinkCreateWithoutGameInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    operator: Prisma.OperatorCreateNestedOneWithoutGameLaunchLinksInput;
    UserProfile?: Prisma.UserProfileCreateNestedOneWithoutGameLaunchLinkInput;
};
export type GameLaunchLinkUncheckedCreateWithoutGameInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    operatorId: string;
    userProfileId?: string | null;
};
export type GameLaunchLinkCreateOrConnectWithoutGameInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    create: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutGameInput, Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput>;
};
export type GameLaunchLinkCreateManyGameInputEnvelope = {
    data: Prisma.GameLaunchLinkCreateManyGameInput | Prisma.GameLaunchLinkCreateManyGameInput[];
    skipDuplicates?: boolean;
};
export type GameLaunchLinkUpsertWithWhereUniqueWithoutGameInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    update: Prisma.XOR<Prisma.GameLaunchLinkUpdateWithoutGameInput, Prisma.GameLaunchLinkUncheckedUpdateWithoutGameInput>;
    create: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutGameInput, Prisma.GameLaunchLinkUncheckedCreateWithoutGameInput>;
};
export type GameLaunchLinkUpdateWithWhereUniqueWithoutGameInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateWithoutGameInput, Prisma.GameLaunchLinkUncheckedUpdateWithoutGameInput>;
};
export type GameLaunchLinkUpdateManyWithWhereWithoutGameInput = {
    where: Prisma.GameLaunchLinkScalarWhereInput;
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateManyMutationInput, Prisma.GameLaunchLinkUncheckedUpdateManyWithoutGameInput>;
};
export type GameLaunchLinkScalarWhereInput = {
    AND?: Prisma.GameLaunchLinkScalarWhereInput | Prisma.GameLaunchLinkScalarWhereInput[];
    OR?: Prisma.GameLaunchLinkScalarWhereInput[];
    NOT?: Prisma.GameLaunchLinkScalarWhereInput | Prisma.GameLaunchLinkScalarWhereInput[];
    id?: Prisma.StringFilter<"GameLaunchLink"> | string;
    token_internal?: Prisma.StringFilter<"GameLaunchLink"> | string;
    currency?: Prisma.StringFilter<"GameLaunchLink"> | string;
    player_operator_id?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    mode?: Prisma.StringFilter<"GameLaunchLink"> | string;
    meta?: Prisma.JsonNullableFilter<"GameLaunchLink">;
    requestIp?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    userAgent?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    session_url?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    state?: Prisma.StringFilter<"GameLaunchLink"> | string;
    active?: Prisma.BoolFilter<"GameLaunchLink"> | boolean;
    expiresAt?: Prisma.DateTimeNullableFilter<"GameLaunchLink"> | Date | string | null;
    extra_meta?: Prisma.JsonNullableFilter<"GameLaunchLink">;
    token_original?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
    createdAt?: Prisma.DateTimeFilter<"GameLaunchLink"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"GameLaunchLink"> | Date | string;
    userId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    gameId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    operatorId?: Prisma.StringFilter<"GameLaunchLink"> | string;
    userProfileId?: Prisma.StringNullableFilter<"GameLaunchLink"> | string | null;
};
export type GameLaunchLinkCreateWithoutOperatorInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    game: Prisma.GameCreateNestedOneWithoutGameLaunchLinksInput;
    UserProfile?: Prisma.UserProfileCreateNestedOneWithoutGameLaunchLinkInput;
};
export type GameLaunchLinkUncheckedCreateWithoutOperatorInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    gameId: string;
    userProfileId?: string | null;
};
export type GameLaunchLinkCreateOrConnectWithoutOperatorInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    create: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutOperatorInput, Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput>;
};
export type GameLaunchLinkCreateManyOperatorInputEnvelope = {
    data: Prisma.GameLaunchLinkCreateManyOperatorInput | Prisma.GameLaunchLinkCreateManyOperatorInput[];
    skipDuplicates?: boolean;
};
export type GameLaunchLinkUpsertWithWhereUniqueWithoutOperatorInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    update: Prisma.XOR<Prisma.GameLaunchLinkUpdateWithoutOperatorInput, Prisma.GameLaunchLinkUncheckedUpdateWithoutOperatorInput>;
    create: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutOperatorInput, Prisma.GameLaunchLinkUncheckedCreateWithoutOperatorInput>;
};
export type GameLaunchLinkUpdateWithWhereUniqueWithoutOperatorInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateWithoutOperatorInput, Prisma.GameLaunchLinkUncheckedUpdateWithoutOperatorInput>;
};
export type GameLaunchLinkUpdateManyWithWhereWithoutOperatorInput = {
    where: Prisma.GameLaunchLinkScalarWhereInput;
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateManyMutationInput, Prisma.GameLaunchLinkUncheckedUpdateManyWithoutOperatorInput>;
};
export type GameLaunchLinkCreateWithoutUserProfileInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    game: Prisma.GameCreateNestedOneWithoutGameLaunchLinksInput;
    operator: Prisma.OperatorCreateNestedOneWithoutGameLaunchLinksInput;
};
export type GameLaunchLinkUncheckedCreateWithoutUserProfileInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    gameId: string;
    operatorId: string;
};
export type GameLaunchLinkCreateOrConnectWithoutUserProfileInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    create: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutUserProfileInput, Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput>;
};
export type GameLaunchLinkCreateManyUserProfileInputEnvelope = {
    data: Prisma.GameLaunchLinkCreateManyUserProfileInput | Prisma.GameLaunchLinkCreateManyUserProfileInput[];
    skipDuplicates?: boolean;
};
export type GameLaunchLinkUpsertWithWhereUniqueWithoutUserProfileInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    update: Prisma.XOR<Prisma.GameLaunchLinkUpdateWithoutUserProfileInput, Prisma.GameLaunchLinkUncheckedUpdateWithoutUserProfileInput>;
    create: Prisma.XOR<Prisma.GameLaunchLinkCreateWithoutUserProfileInput, Prisma.GameLaunchLinkUncheckedCreateWithoutUserProfileInput>;
};
export type GameLaunchLinkUpdateWithWhereUniqueWithoutUserProfileInput = {
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateWithoutUserProfileInput, Prisma.GameLaunchLinkUncheckedUpdateWithoutUserProfileInput>;
};
export type GameLaunchLinkUpdateManyWithWhereWithoutUserProfileInput = {
    where: Prisma.GameLaunchLinkScalarWhereInput;
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateManyMutationInput, Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileInput>;
};
export type GameLaunchLinkCreateManyGameInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    operatorId: string;
    userProfileId?: string | null;
};
export type GameLaunchLinkUpdateWithoutGameInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    operator?: Prisma.OperatorUpdateOneRequiredWithoutGameLaunchLinksNestedInput;
    UserProfile?: Prisma.UserProfileUpdateOneWithoutGameLaunchLinkNestedInput;
};
export type GameLaunchLinkUncheckedUpdateWithoutGameInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    operatorId?: Prisma.StringFieldUpdateOperationsInput | string;
    userProfileId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
export type GameLaunchLinkUncheckedUpdateManyWithoutGameInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    operatorId?: Prisma.StringFieldUpdateOperationsInput | string;
    userProfileId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
export type GameLaunchLinkCreateManyOperatorInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    gameId: string;
    userProfileId?: string | null;
};
export type GameLaunchLinkUpdateWithoutOperatorInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    game?: Prisma.GameUpdateOneRequiredWithoutGameLaunchLinksNestedInput;
    UserProfile?: Prisma.UserProfileUpdateOneWithoutGameLaunchLinkNestedInput;
};
export type GameLaunchLinkUncheckedUpdateWithoutOperatorInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    userProfileId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
export type GameLaunchLinkUncheckedUpdateManyWithoutOperatorInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    userProfileId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
export type GameLaunchLinkCreateManyUserProfileInput = {
    id?: string;
    token_internal?: string;
    currency: string;
    player_operator_id?: string | null;
    mode: string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: string | null;
    userAgent?: string | null;
    session_url?: string | null;
    state?: string;
    active?: boolean;
    expiresAt?: Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: string | null;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    userId: string;
    gameId: string;
    operatorId: string;
};
export type GameLaunchLinkUpdateWithoutUserProfileInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    game?: Prisma.GameUpdateOneRequiredWithoutGameLaunchLinksNestedInput;
    operator?: Prisma.OperatorUpdateOneRequiredWithoutGameLaunchLinksNestedInput;
};
export type GameLaunchLinkUncheckedUpdateWithoutUserProfileInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    operatorId?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type GameLaunchLinkUncheckedUpdateManyWithoutUserProfileInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    token_internal?: Prisma.StringFieldUpdateOperationsInput | string;
    currency?: Prisma.StringFieldUpdateOperationsInput | string;
    player_operator_id?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    mode?: Prisma.StringFieldUpdateOperationsInput | string;
    meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    requestIp?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    userAgent?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    session_url?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    state?: Prisma.StringFieldUpdateOperationsInput | string;
    active?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    expiresAt?: Prisma.NullableDateTimeFieldUpdateOperationsInput | Date | string | null;
    extra_meta?: Prisma.NullableJsonNullValueInput | runtime.InputJsonValue;
    token_original?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    gameId?: Prisma.StringFieldUpdateOperationsInput | string;
    operatorId?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type GameLaunchLinkSelect<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    token_internal?: boolean;
    currency?: boolean;
    player_operator_id?: boolean;
    mode?: boolean;
    meta?: boolean;
    requestIp?: boolean;
    userAgent?: boolean;
    session_url?: boolean;
    state?: boolean;
    active?: boolean;
    expiresAt?: boolean;
    extra_meta?: boolean;
    token_original?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    userId?: boolean;
    gameId?: boolean;
    operatorId?: boolean;
    userProfileId?: boolean;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
    operator?: boolean | Prisma.OperatorDefaultArgs<ExtArgs>;
    UserProfile?: boolean | Prisma.GameLaunchLink$UserProfileArgs<ExtArgs>;
}, ExtArgs["result"]["gameLaunchLink"]>;
export type GameLaunchLinkSelectCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    token_internal?: boolean;
    currency?: boolean;
    player_operator_id?: boolean;
    mode?: boolean;
    meta?: boolean;
    requestIp?: boolean;
    userAgent?: boolean;
    session_url?: boolean;
    state?: boolean;
    active?: boolean;
    expiresAt?: boolean;
    extra_meta?: boolean;
    token_original?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    userId?: boolean;
    gameId?: boolean;
    operatorId?: boolean;
    userProfileId?: boolean;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
    operator?: boolean | Prisma.OperatorDefaultArgs<ExtArgs>;
    UserProfile?: boolean | Prisma.GameLaunchLink$UserProfileArgs<ExtArgs>;
}, ExtArgs["result"]["gameLaunchLink"]>;
export type GameLaunchLinkSelectUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    token_internal?: boolean;
    currency?: boolean;
    player_operator_id?: boolean;
    mode?: boolean;
    meta?: boolean;
    requestIp?: boolean;
    userAgent?: boolean;
    session_url?: boolean;
    state?: boolean;
    active?: boolean;
    expiresAt?: boolean;
    extra_meta?: boolean;
    token_original?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    userId?: boolean;
    gameId?: boolean;
    operatorId?: boolean;
    userProfileId?: boolean;
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
    operator?: boolean | Prisma.OperatorDefaultArgs<ExtArgs>;
    UserProfile?: boolean | Prisma.GameLaunchLink$UserProfileArgs<ExtArgs>;
}, ExtArgs["result"]["gameLaunchLink"]>;
export type GameLaunchLinkSelectScalar = {
    id?: boolean;
    token_internal?: boolean;
    currency?: boolean;
    player_operator_id?: boolean;
    mode?: boolean;
    meta?: boolean;
    requestIp?: boolean;
    userAgent?: boolean;
    session_url?: boolean;
    state?: boolean;
    active?: boolean;
    expiresAt?: boolean;
    extra_meta?: boolean;
    token_original?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    userId?: boolean;
    gameId?: boolean;
    operatorId?: boolean;
    userProfileId?: boolean;
};
export type GameLaunchLinkOmit<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetOmit<"id" | "token_internal" | "currency" | "player_operator_id" | "mode" | "meta" | "requestIp" | "userAgent" | "session_url" | "state" | "active" | "expiresAt" | "extra_meta" | "token_original" | "createdAt" | "updatedAt" | "userId" | "gameId" | "operatorId" | "userProfileId", ExtArgs["result"]["gameLaunchLink"]>;
export type GameLaunchLinkInclude<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
    operator?: boolean | Prisma.OperatorDefaultArgs<ExtArgs>;
    UserProfile?: boolean | Prisma.GameLaunchLink$UserProfileArgs<ExtArgs>;
};
export type GameLaunchLinkIncludeCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
    operator?: boolean | Prisma.OperatorDefaultArgs<ExtArgs>;
    UserProfile?: boolean | Prisma.GameLaunchLink$UserProfileArgs<ExtArgs>;
};
export type GameLaunchLinkIncludeUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    game?: boolean | Prisma.GameDefaultArgs<ExtArgs>;
    operator?: boolean | Prisma.OperatorDefaultArgs<ExtArgs>;
    UserProfile?: boolean | Prisma.GameLaunchLink$UserProfileArgs<ExtArgs>;
};
export type $GameLaunchLinkPayload<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    name: "GameLaunchLink";
    objects: {
        game: Prisma.$GamePayload<ExtArgs>;
        operator: Prisma.$OperatorPayload<ExtArgs>;
        UserProfile: Prisma.$UserProfilePayload<ExtArgs> | null;
    };
    scalars: runtime.Types.Extensions.GetPayloadResult<{
        id: string;
        token_internal: string;
        currency: string;
        player_operator_id: string | null;
        mode: string;
        meta: runtime.JsonValue | null;
        requestIp: string | null;
        userAgent: string | null;
        session_url: string | null;
        state: string;
        active: boolean;
        expiresAt: Date | null;
        extra_meta: runtime.JsonValue | null;
        token_original: string | null;
        createdAt: Date;
        updatedAt: Date;
        userId: string;
        gameId: string;
        operatorId: string;
        userProfileId: string | null;
    }, ExtArgs["result"]["gameLaunchLink"]>;
    composites: {};
};
export type GameLaunchLinkGetPayload<S extends boolean | null | undefined | GameLaunchLinkDefaultArgs> = runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload, S>;
export type GameLaunchLinkCountArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = Omit<GameLaunchLinkFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
    select?: GameLaunchLinkCountAggregateInputType | true;
};
export interface GameLaunchLinkDelegate<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: {
        types: Prisma.TypeMap<ExtArgs>['model']['GameLaunchLink'];
        meta: {
            name: 'GameLaunchLink';
        };
    };
    /**
     * Find zero or one GameLaunchLink that matches the filter.
     * @param {GameLaunchLinkFindUniqueArgs} args - Arguments to find a GameLaunchLink
     * @example
     * // Get one GameLaunchLink
     * const gameLaunchLink = await prisma.gameLaunchLink.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends GameLaunchLinkFindUniqueArgs>(args: Prisma.SelectSubset<T, GameLaunchLinkFindUniqueArgs<ExtArgs>>): Prisma.Prisma__GameLaunchLinkClient<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    /**
     * Find one GameLaunchLink that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {GameLaunchLinkFindUniqueOrThrowArgs} args - Arguments to find a GameLaunchLink
     * @example
     * // Get one GameLaunchLink
     * const gameLaunchLink = await prisma.gameLaunchLink.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends GameLaunchLinkFindUniqueOrThrowArgs>(args: Prisma.SelectSubset<T, GameLaunchLinkFindUniqueOrThrowArgs<ExtArgs>>): Prisma.Prisma__GameLaunchLinkClient<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Find the first GameLaunchLink that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {GameLaunchLinkFindFirstArgs} args - Arguments to find a GameLaunchLink
     * @example
     * // Get one GameLaunchLink
     * const gameLaunchLink = await prisma.gameLaunchLink.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends GameLaunchLinkFindFirstArgs>(args?: Prisma.SelectSubset<T, GameLaunchLinkFindFirstArgs<ExtArgs>>): Prisma.Prisma__GameLaunchLinkClient<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    /**
     * Find the first GameLaunchLink that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {GameLaunchLinkFindFirstOrThrowArgs} args - Arguments to find a GameLaunchLink
     * @example
     * // Get one GameLaunchLink
     * const gameLaunchLink = await prisma.gameLaunchLink.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends GameLaunchLinkFindFirstOrThrowArgs>(args?: Prisma.SelectSubset<T, GameLaunchLinkFindFirstOrThrowArgs<ExtArgs>>): Prisma.Prisma__GameLaunchLinkClient<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Find zero or more GameLaunchLinks that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {GameLaunchLinkFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all GameLaunchLinks
     * const gameLaunchLinks = await prisma.gameLaunchLink.findMany()
     *
     * // Get first 10 GameLaunchLinks
     * const gameLaunchLinks = await prisma.gameLaunchLink.findMany({ take: 10 })
     *
     * // Only select the `id`
     * const gameLaunchLinkWithIdOnly = await prisma.gameLaunchLink.findMany({ select: { id: true } })
     *
     */
    findMany<T extends GameLaunchLinkFindManyArgs>(args?: Prisma.SelectSubset<T, GameLaunchLinkFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>;
    /**
     * Create a GameLaunchLink.
     * @param {GameLaunchLinkCreateArgs} args - Arguments to create a GameLaunchLink.
     * @example
     * // Create one GameLaunchLink
     * const GameLaunchLink = await prisma.gameLaunchLink.create({
     *   data: {
     *     // ... data to create a GameLaunchLink
     *   }
     * })
     *
     */
    create<T extends GameLaunchLinkCreateArgs>(args: Prisma.SelectSubset<T, GameLaunchLinkCreateArgs<ExtArgs>>): Prisma.Prisma__GameLaunchLinkClient<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Create many GameLaunchLinks.
     * @param {GameLaunchLinkCreateManyArgs} args - Arguments to create many GameLaunchLinks.
     * @example
     * // Create many GameLaunchLinks
     * const gameLaunchLink = await prisma.gameLaunchLink.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     */
    createMany<T extends GameLaunchLinkCreateManyArgs>(args?: Prisma.SelectSubset<T, GameLaunchLinkCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Create many GameLaunchLinks and returns the data saved in the database.
     * @param {GameLaunchLinkCreateManyAndReturnArgs} args - Arguments to create many GameLaunchLinks.
     * @example
     * // Create many GameLaunchLinks
     * const gameLaunchLink = await prisma.gameLaunchLink.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     * // Create many GameLaunchLinks and only return the `id`
     * const gameLaunchLinkWithIdOnly = await prisma.gameLaunchLink.createManyAndReturn({
     *   select: { id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     *
     */
    createManyAndReturn<T extends GameLaunchLinkCreateManyAndReturnArgs>(args?: Prisma.SelectSubset<T, GameLaunchLinkCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>;
    /**
     * Delete a GameLaunchLink.
     * @param {GameLaunchLinkDeleteArgs} args - Arguments to delete one GameLaunchLink.
     * @example
     * // Delete one GameLaunchLink
     * const GameLaunchLink = await prisma.gameLaunchLink.delete({
     *   where: {
     *     // ... filter to delete one GameLaunchLink
     *   }
     * })
     *
     */
    delete<T extends GameLaunchLinkDeleteArgs>(args: Prisma.SelectSubset<T, GameLaunchLinkDeleteArgs<ExtArgs>>): Prisma.Prisma__GameLaunchLinkClient<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Update one GameLaunchLink.
     * @param {GameLaunchLinkUpdateArgs} args - Arguments to update one GameLaunchLink.
     * @example
     * // Update one GameLaunchLink
     * const gameLaunchLink = await prisma.gameLaunchLink.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     *
     */
    update<T extends GameLaunchLinkUpdateArgs>(args: Prisma.SelectSubset<T, GameLaunchLinkUpdateArgs<ExtArgs>>): Prisma.Prisma__GameLaunchLinkClient<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Delete zero or more GameLaunchLinks.
     * @param {GameLaunchLinkDeleteManyArgs} args - Arguments to filter GameLaunchLinks to delete.
     * @example
     * // Delete a few GameLaunchLinks
     * const { count } = await prisma.gameLaunchLink.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     *
     */
    deleteMany<T extends GameLaunchLinkDeleteManyArgs>(args?: Prisma.SelectSubset<T, GameLaunchLinkDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Update zero or more GameLaunchLinks.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {GameLaunchLinkUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many GameLaunchLinks
     * const gameLaunchLink = await prisma.gameLaunchLink.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     *
     */
    updateMany<T extends GameLaunchLinkUpdateManyArgs>(args: Prisma.SelectSubset<T, GameLaunchLinkUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Update zero or more GameLaunchLinks and returns the data updated in the database.
     * @param {GameLaunchLinkUpdateManyAndReturnArgs} args - Arguments to update many GameLaunchLinks.
     * @example
     * // Update many GameLaunchLinks
     * const gameLaunchLink = await prisma.gameLaunchLink.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     * // Update zero or more GameLaunchLinks and only return the `id`
     * const gameLaunchLinkWithIdOnly = await prisma.gameLaunchLink.updateManyAndReturn({
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
    updateManyAndReturn<T extends GameLaunchLinkUpdateManyAndReturnArgs>(args: Prisma.SelectSubset<T, GameLaunchLinkUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>;
    /**
     * Create or update one GameLaunchLink.
     * @param {GameLaunchLinkUpsertArgs} args - Arguments to update or create a GameLaunchLink.
     * @example
     * // Update or create a GameLaunchLink
     * const gameLaunchLink = await prisma.gameLaunchLink.upsert({
     *   create: {
     *     // ... data to create a GameLaunchLink
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the GameLaunchLink we want to update
     *   }
     * })
     */
    upsert<T extends GameLaunchLinkUpsertArgs>(args: Prisma.SelectSubset<T, GameLaunchLinkUpsertArgs<ExtArgs>>): Prisma.Prisma__GameLaunchLinkClient<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Count the number of GameLaunchLinks.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {GameLaunchLinkCountArgs} args - Arguments to filter GameLaunchLinks to count.
     * @example
     * // Count the number of GameLaunchLinks
     * const count = await prisma.gameLaunchLink.count({
     *   where: {
     *     // ... the filter for the GameLaunchLinks we want to count
     *   }
     * })
    **/
    count<T extends GameLaunchLinkCountArgs>(args?: Prisma.Subset<T, GameLaunchLinkCountArgs>): Prisma.PrismaPromise<T extends runtime.Types.Utils.Record<'select', any> ? T['select'] extends true ? number : Prisma.GetScalarType<T['select'], GameLaunchLinkCountAggregateOutputType> : number>;
    /**
     * Allows you to perform aggregations operations on a GameLaunchLink.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {GameLaunchLinkAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
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
    aggregate<T extends GameLaunchLinkAggregateArgs>(args: Prisma.Subset<T, GameLaunchLinkAggregateArgs>): Prisma.PrismaPromise<GetGameLaunchLinkAggregateType<T>>;
    /**
     * Group by GameLaunchLink.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {GameLaunchLinkGroupByArgs} args - Group by arguments.
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
    groupBy<T extends GameLaunchLinkGroupByArgs, HasSelectOrTake extends Prisma.Or<Prisma.Extends<'skip', Prisma.Keys<T>>, Prisma.Extends<'take', Prisma.Keys<T>>>, OrderByArg extends Prisma.True extends HasSelectOrTake ? {
        orderBy: GameLaunchLinkGroupByArgs['orderBy'];
    } : {
        orderBy?: GameLaunchLinkGroupByArgs['orderBy'];
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
    }[OrderFields]>(args: Prisma.SubsetIntersection<T, GameLaunchLinkGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetGameLaunchLinkGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>;
    /**
     * Fields of the GameLaunchLink model
     */
    readonly fields: GameLaunchLinkFieldRefs;
}
/**
 * The delegate class that acts as a "Promise-like" for GameLaunchLink.
 * Why is this prefixed with `Prisma__`?
 * Because we want to prevent naming conflicts as mentioned in
 * https://github.com/prisma/prisma-client-js/issues/707
 */
export interface Prisma__GameLaunchLinkClient<T, Null = never, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise";
    game<T extends Prisma.GameDefaultArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.GameDefaultArgs<ExtArgs>>): Prisma.Prisma__GameClient<runtime.Types.Result.GetResult<Prisma.$GamePayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>;
    operator<T extends Prisma.OperatorDefaultArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.OperatorDefaultArgs<ExtArgs>>): Prisma.Prisma__OperatorClient<runtime.Types.Result.GetResult<Prisma.$OperatorPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>;
    UserProfile<T extends Prisma.GameLaunchLink$UserProfileArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.GameLaunchLink$UserProfileArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
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
 * Fields of the GameLaunchLink model
 */
export interface GameLaunchLinkFieldRefs {
    readonly id: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly token_internal: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly currency: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly player_operator_id: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly mode: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly meta: Prisma.FieldRef<"GameLaunchLink", 'Json'>;
    readonly requestIp: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly userAgent: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly session_url: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly state: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly active: Prisma.FieldRef<"GameLaunchLink", 'Boolean'>;
    readonly expiresAt: Prisma.FieldRef<"GameLaunchLink", 'DateTime'>;
    readonly extra_meta: Prisma.FieldRef<"GameLaunchLink", 'Json'>;
    readonly token_original: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly createdAt: Prisma.FieldRef<"GameLaunchLink", 'DateTime'>;
    readonly updatedAt: Prisma.FieldRef<"GameLaunchLink", 'DateTime'>;
    readonly userId: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly gameId: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly operatorId: Prisma.FieldRef<"GameLaunchLink", 'String'>;
    readonly userProfileId: Prisma.FieldRef<"GameLaunchLink", 'String'>;
}
/**
 * GameLaunchLink findUnique
 */
export type GameLaunchLinkFindUniqueArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * Filter, which GameLaunchLink to fetch.
     */
    where: Prisma.GameLaunchLinkWhereUniqueInput;
};
/**
 * GameLaunchLink findUniqueOrThrow
 */
export type GameLaunchLinkFindUniqueOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * Filter, which GameLaunchLink to fetch.
     */
    where: Prisma.GameLaunchLinkWhereUniqueInput;
};
/**
 * GameLaunchLink findFirst
 */
export type GameLaunchLinkFindFirstArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * Filter, which GameLaunchLink to fetch.
     */
    where?: Prisma.GameLaunchLinkWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of GameLaunchLinks to fetch.
     */
    orderBy?: Prisma.GameLaunchLinkOrderByWithRelationInput | Prisma.GameLaunchLinkOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for searching for GameLaunchLinks.
     */
    cursor?: Prisma.GameLaunchLinkWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` GameLaunchLinks from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` GameLaunchLinks.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     *
     * Filter by unique combinations of GameLaunchLinks.
     */
    distinct?: Prisma.GameLaunchLinkScalarFieldEnum | Prisma.GameLaunchLinkScalarFieldEnum[];
};
/**
 * GameLaunchLink findFirstOrThrow
 */
export type GameLaunchLinkFindFirstOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * Filter, which GameLaunchLink to fetch.
     */
    where?: Prisma.GameLaunchLinkWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of GameLaunchLinks to fetch.
     */
    orderBy?: Prisma.GameLaunchLinkOrderByWithRelationInput | Prisma.GameLaunchLinkOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for searching for GameLaunchLinks.
     */
    cursor?: Prisma.GameLaunchLinkWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` GameLaunchLinks from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` GameLaunchLinks.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     *
     * Filter by unique combinations of GameLaunchLinks.
     */
    distinct?: Prisma.GameLaunchLinkScalarFieldEnum | Prisma.GameLaunchLinkScalarFieldEnum[];
};
/**
 * GameLaunchLink findMany
 */
export type GameLaunchLinkFindManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * Filter, which GameLaunchLinks to fetch.
     */
    where?: Prisma.GameLaunchLinkWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of GameLaunchLinks to fetch.
     */
    orderBy?: Prisma.GameLaunchLinkOrderByWithRelationInput | Prisma.GameLaunchLinkOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for listing GameLaunchLinks.
     */
    cursor?: Prisma.GameLaunchLinkWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` GameLaunchLinks from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` GameLaunchLinks.
     */
    skip?: number;
    distinct?: Prisma.GameLaunchLinkScalarFieldEnum | Prisma.GameLaunchLinkScalarFieldEnum[];
};
/**
 * GameLaunchLink create
 */
export type GameLaunchLinkCreateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * The data needed to create a GameLaunchLink.
     */
    data: Prisma.XOR<Prisma.GameLaunchLinkCreateInput, Prisma.GameLaunchLinkUncheckedCreateInput>;
};
/**
 * GameLaunchLink createMany
 */
export type GameLaunchLinkCreateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * The data used to create many GameLaunchLinks.
     */
    data: Prisma.GameLaunchLinkCreateManyInput | Prisma.GameLaunchLinkCreateManyInput[];
    skipDuplicates?: boolean;
};
/**
 * GameLaunchLink createManyAndReturn
 */
export type GameLaunchLinkCreateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelectCreateManyAndReturn<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * The data used to create many GameLaunchLinks.
     */
    data: Prisma.GameLaunchLinkCreateManyInput | Prisma.GameLaunchLinkCreateManyInput[];
    skipDuplicates?: boolean;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkIncludeCreateManyAndReturn<ExtArgs> | null;
};
/**
 * GameLaunchLink update
 */
export type GameLaunchLinkUpdateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * The data needed to update a GameLaunchLink.
     */
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateInput, Prisma.GameLaunchLinkUncheckedUpdateInput>;
    /**
     * Choose, which GameLaunchLink to update.
     */
    where: Prisma.GameLaunchLinkWhereUniqueInput;
};
/**
 * GameLaunchLink updateMany
 */
export type GameLaunchLinkUpdateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * The data used to update GameLaunchLinks.
     */
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateManyMutationInput, Prisma.GameLaunchLinkUncheckedUpdateManyInput>;
    /**
     * Filter which GameLaunchLinks to update
     */
    where?: Prisma.GameLaunchLinkWhereInput;
    /**
     * Limit how many GameLaunchLinks to update.
     */
    limit?: number;
};
/**
 * GameLaunchLink updateManyAndReturn
 */
export type GameLaunchLinkUpdateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelectUpdateManyAndReturn<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * The data used to update GameLaunchLinks.
     */
    data: Prisma.XOR<Prisma.GameLaunchLinkUpdateManyMutationInput, Prisma.GameLaunchLinkUncheckedUpdateManyInput>;
    /**
     * Filter which GameLaunchLinks to update
     */
    where?: Prisma.GameLaunchLinkWhereInput;
    /**
     * Limit how many GameLaunchLinks to update.
     */
    limit?: number;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkIncludeUpdateManyAndReturn<ExtArgs> | null;
};
/**
 * GameLaunchLink upsert
 */
export type GameLaunchLinkUpsertArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * The filter to search for the GameLaunchLink to update in case it exists.
     */
    where: Prisma.GameLaunchLinkWhereUniqueInput;
    /**
     * In case the GameLaunchLink found by the `where` argument doesn't exist, create a new GameLaunchLink with this data.
     */
    create: Prisma.XOR<Prisma.GameLaunchLinkCreateInput, Prisma.GameLaunchLinkUncheckedCreateInput>;
    /**
     * In case the GameLaunchLink was found with the provided `where` argument, update it with this data.
     */
    update: Prisma.XOR<Prisma.GameLaunchLinkUpdateInput, Prisma.GameLaunchLinkUncheckedUpdateInput>;
};
/**
 * GameLaunchLink delete
 */
export type GameLaunchLinkDeleteArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
    /**
     * Filter which GameLaunchLink to delete.
     */
    where: Prisma.GameLaunchLinkWhereUniqueInput;
};
/**
 * GameLaunchLink deleteMany
 */
export type GameLaunchLinkDeleteManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Filter which GameLaunchLinks to delete
     */
    where?: Prisma.GameLaunchLinkWhereInput;
    /**
     * Limit how many GameLaunchLinks to delete.
     */
    limit?: number;
};
/**
 * GameLaunchLink.UserProfile
 */
export type GameLaunchLink$UserProfileArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the UserProfile
     */
    select?: Prisma.UserProfileSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the UserProfile
     */
    omit?: Prisma.UserProfileOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.UserProfileInclude<ExtArgs> | null;
    where?: Prisma.UserProfileWhereInput;
};
/**
 * GameLaunchLink without action
 */
export type GameLaunchLinkDefaultArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameLaunchLink
     */
    select?: Prisma.GameLaunchLinkSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameLaunchLink
     */
    omit?: Prisma.GameLaunchLinkOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameLaunchLinkInclude<ExtArgs> | null;
};
export {};
