/**
 * This file exports the `UserProfile` model and its related types.
 *
 * 🟢 You can import this file directly.
 */
import * as runtime from "@prisma/client/runtime/library";
import type * as $Enums from "../enums.ts";
import type * as Prisma from "../internal/prismaNamespace.ts";
/**
 * Model UserProfile
 *
 */
export type UserProfileModel = runtime.Types.Result.DefaultSelection<Prisma.$UserProfilePayload>;
export type AggregateUserProfile = {
    _count: UserProfileCountAggregateOutputType | null;
    _avg: UserProfileAvgAggregateOutputType | null;
    _sum: UserProfileSumAggregateOutputType | null;
    _min: UserProfileMinAggregateOutputType | null;
    _max: UserProfileMaxAggregateOutputType | null;
};
export type UserProfileAvgAggregateOutputType = {
    balance: number | null;
    totalXpFromOperator: number | null;
};
export type UserProfileSumAggregateOutputType = {
    balance: number | null;
    totalXpFromOperator: number | null;
};
export type UserProfileMinAggregateOutputType = {
    id: string | null;
    createdAt: Date | null;
    updatedAt: Date | null;
    username: string | null;
    avatar: string | null;
    balance: number | null;
    totalXpFromOperator: number | null;
    activeCurrencyType: string | null;
    userId: string | null;
    isActive: boolean | null;
    otherUserid: string | null;
    role: $Enums.Role | null;
    operatorId: string | null;
    currentGameSessionid: string | null;
};
export type UserProfileMaxAggregateOutputType = {
    id: string | null;
    createdAt: Date | null;
    updatedAt: Date | null;
    username: string | null;
    avatar: string | null;
    balance: number | null;
    totalXpFromOperator: number | null;
    activeCurrencyType: string | null;
    userId: string | null;
    isActive: boolean | null;
    otherUserid: string | null;
    role: $Enums.Role | null;
    operatorId: string | null;
    currentGameSessionid: string | null;
};
export type UserProfileCountAggregateOutputType = {
    id: number;
    createdAt: number;
    updatedAt: number;
    username: number;
    avatar: number;
    balance: number;
    totalXpFromOperator: number;
    activeCurrencyType: number;
    userId: number;
    isActive: number;
    otherUserid: number;
    role: number;
    operatorId: number;
    currentGameSessionid: number;
    _all: number;
};
export type UserProfileAvgAggregateInputType = {
    balance?: true;
    totalXpFromOperator?: true;
};
export type UserProfileSumAggregateInputType = {
    balance?: true;
    totalXpFromOperator?: true;
};
export type UserProfileMinAggregateInputType = {
    id?: true;
    createdAt?: true;
    updatedAt?: true;
    username?: true;
    avatar?: true;
    balance?: true;
    totalXpFromOperator?: true;
    activeCurrencyType?: true;
    userId?: true;
    isActive?: true;
    otherUserid?: true;
    role?: true;
    operatorId?: true;
    currentGameSessionid?: true;
};
export type UserProfileMaxAggregateInputType = {
    id?: true;
    createdAt?: true;
    updatedAt?: true;
    username?: true;
    avatar?: true;
    balance?: true;
    totalXpFromOperator?: true;
    activeCurrencyType?: true;
    userId?: true;
    isActive?: true;
    otherUserid?: true;
    role?: true;
    operatorId?: true;
    currentGameSessionid?: true;
};
export type UserProfileCountAggregateInputType = {
    id?: true;
    createdAt?: true;
    updatedAt?: true;
    username?: true;
    avatar?: true;
    balance?: true;
    totalXpFromOperator?: true;
    activeCurrencyType?: true;
    userId?: true;
    isActive?: true;
    otherUserid?: true;
    role?: true;
    operatorId?: true;
    currentGameSessionid?: true;
    _all?: true;
};
export type UserProfileAggregateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Filter which UserProfile to aggregate.
     */
    where?: Prisma.UserProfileWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of UserProfiles to fetch.
     */
    orderBy?: Prisma.UserProfileOrderByWithRelationInput | Prisma.UserProfileOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the start position
     */
    cursor?: Prisma.UserProfileWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` UserProfiles from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` UserProfiles.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Count returned UserProfiles
    **/
    _count?: true | UserProfileCountAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to average
    **/
    _avg?: UserProfileAvgAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to sum
    **/
    _sum?: UserProfileSumAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to find the minimum value
    **/
    _min?: UserProfileMinAggregateInputType;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/aggregations Aggregation Docs}
     *
     * Select which fields to find the maximum value
    **/
    _max?: UserProfileMaxAggregateInputType;
};
export type GetUserProfileAggregateType<T extends UserProfileAggregateArgs> = {
    [P in keyof T & keyof AggregateUserProfile]: P extends '_count' | 'count' ? T[P] extends true ? number : Prisma.GetScalarType<T[P], AggregateUserProfile[P]> : Prisma.GetScalarType<T[P], AggregateUserProfile[P]>;
};
export type UserProfileGroupByArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.UserProfileWhereInput;
    orderBy?: Prisma.UserProfileOrderByWithAggregationInput | Prisma.UserProfileOrderByWithAggregationInput[];
    by: Prisma.UserProfileScalarFieldEnum[] | Prisma.UserProfileScalarFieldEnum;
    having?: Prisma.UserProfileScalarWhereWithAggregatesInput;
    take?: number;
    skip?: number;
    _count?: UserProfileCountAggregateInputType | true;
    _avg?: UserProfileAvgAggregateInputType;
    _sum?: UserProfileSumAggregateInputType;
    _min?: UserProfileMinAggregateInputType;
    _max?: UserProfileMaxAggregateInputType;
};
export type UserProfileGroupByOutputType = {
    id: string;
    createdAt: Date;
    updatedAt: Date;
    username: string;
    avatar: string | null;
    balance: number;
    totalXpFromOperator: number;
    activeCurrencyType: string;
    userId: string;
    isActive: boolean;
    otherUserid: string | null;
    role: $Enums.Role | null;
    operatorId: string | null;
    currentGameSessionid: string | null;
    _count: UserProfileCountAggregateOutputType | null;
    _avg: UserProfileAvgAggregateOutputType | null;
    _sum: UserProfileSumAggregateOutputType | null;
    _min: UserProfileMinAggregateOutputType | null;
    _max: UserProfileMaxAggregateOutputType | null;
};
type GetUserProfileGroupByPayload<T extends UserProfileGroupByArgs> = Prisma.PrismaPromise<Array<Prisma.PickEnumerable<UserProfileGroupByOutputType, T['by']> & {
    [P in ((keyof T) & (keyof UserProfileGroupByOutputType))]: P extends '_count' ? T[P] extends boolean ? number : Prisma.GetScalarType<T[P], UserProfileGroupByOutputType[P]> : Prisma.GetScalarType<T[P], UserProfileGroupByOutputType[P]>;
}>>;
export type UserProfileWhereInput = {
    AND?: Prisma.UserProfileWhereInput | Prisma.UserProfileWhereInput[];
    OR?: Prisma.UserProfileWhereInput[];
    NOT?: Prisma.UserProfileWhereInput | Prisma.UserProfileWhereInput[];
    id?: Prisma.StringFilter<"UserProfile"> | string;
    createdAt?: Prisma.DateTimeFilter<"UserProfile"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"UserProfile"> | Date | string;
    username?: Prisma.StringFilter<"UserProfile"> | string;
    avatar?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    balance?: Prisma.IntFilter<"UserProfile"> | number;
    totalXpFromOperator?: Prisma.IntFilter<"UserProfile"> | number;
    activeCurrencyType?: Prisma.StringFilter<"UserProfile"> | string;
    userId?: Prisma.StringFilter<"UserProfile"> | string;
    isActive?: Prisma.BoolFilter<"UserProfile"> | boolean;
    otherUserid?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    role?: Prisma.EnumRoleNullableFilter<"UserProfile"> | $Enums.Role | null;
    operatorId?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    currentGameSessionid?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    wallets?: Prisma.WalletListRelationFilter;
    transactions?: Prisma.TransactionListRelationFilter;
    rebateTransactions?: Prisma.RebateTransactionListRelationFilter;
    operatorInvitations?: Prisma.OperatorInvitationListRelationFilter;
    TournamentReward?: Prisma.TournamentRewardListRelationFilter;
    gameLaunchLink?: Prisma.GameLaunchLinkListRelationFilter;
    TournamentParticipant?: Prisma.TournamentParticipantListRelationFilter;
    pastGameSessions?: Prisma.GameSessionListRelationFilter;
    currentGameSession?: Prisma.XOR<Prisma.GameSessionNullableScalarRelationFilter, Prisma.GameSessionWhereInput> | null;
};
export type UserProfileOrderByWithRelationInput = {
    id?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    username?: Prisma.SortOrder;
    avatar?: Prisma.SortOrderInput | Prisma.SortOrder;
    balance?: Prisma.SortOrder;
    totalXpFromOperator?: Prisma.SortOrder;
    activeCurrencyType?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    isActive?: Prisma.SortOrder;
    otherUserid?: Prisma.SortOrderInput | Prisma.SortOrder;
    role?: Prisma.SortOrderInput | Prisma.SortOrder;
    operatorId?: Prisma.SortOrderInput | Prisma.SortOrder;
    currentGameSessionid?: Prisma.SortOrderInput | Prisma.SortOrder;
    wallets?: Prisma.WalletOrderByRelationAggregateInput;
    transactions?: Prisma.TransactionOrderByRelationAggregateInput;
    rebateTransactions?: Prisma.RebateTransactionOrderByRelationAggregateInput;
    operatorInvitations?: Prisma.OperatorInvitationOrderByRelationAggregateInput;
    TournamentReward?: Prisma.TournamentRewardOrderByRelationAggregateInput;
    gameLaunchLink?: Prisma.GameLaunchLinkOrderByRelationAggregateInput;
    TournamentParticipant?: Prisma.TournamentParticipantOrderByRelationAggregateInput;
    pastGameSessions?: Prisma.GameSessionOrderByRelationAggregateInput;
    currentGameSession?: Prisma.GameSessionOrderByWithRelationInput;
};
export type UserProfileWhereUniqueInput = Prisma.AtLeast<{
    id?: string;
    username?: string;
    userId?: string;
    AND?: Prisma.UserProfileWhereInput | Prisma.UserProfileWhereInput[];
    OR?: Prisma.UserProfileWhereInput[];
    NOT?: Prisma.UserProfileWhereInput | Prisma.UserProfileWhereInput[];
    createdAt?: Prisma.DateTimeFilter<"UserProfile"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"UserProfile"> | Date | string;
    avatar?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    balance?: Prisma.IntFilter<"UserProfile"> | number;
    totalXpFromOperator?: Prisma.IntFilter<"UserProfile"> | number;
    activeCurrencyType?: Prisma.StringFilter<"UserProfile"> | string;
    isActive?: Prisma.BoolFilter<"UserProfile"> | boolean;
    otherUserid?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    role?: Prisma.EnumRoleNullableFilter<"UserProfile"> | $Enums.Role | null;
    operatorId?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    currentGameSessionid?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    wallets?: Prisma.WalletListRelationFilter;
    transactions?: Prisma.TransactionListRelationFilter;
    rebateTransactions?: Prisma.RebateTransactionListRelationFilter;
    operatorInvitations?: Prisma.OperatorInvitationListRelationFilter;
    TournamentReward?: Prisma.TournamentRewardListRelationFilter;
    gameLaunchLink?: Prisma.GameLaunchLinkListRelationFilter;
    TournamentParticipant?: Prisma.TournamentParticipantListRelationFilter;
    pastGameSessions?: Prisma.GameSessionListRelationFilter;
    currentGameSession?: Prisma.XOR<Prisma.GameSessionNullableScalarRelationFilter, Prisma.GameSessionWhereInput> | null;
}, "id" | "username" | "userId">;
export type UserProfileOrderByWithAggregationInput = {
    id?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    username?: Prisma.SortOrder;
    avatar?: Prisma.SortOrderInput | Prisma.SortOrder;
    balance?: Prisma.SortOrder;
    totalXpFromOperator?: Prisma.SortOrder;
    activeCurrencyType?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    isActive?: Prisma.SortOrder;
    otherUserid?: Prisma.SortOrderInput | Prisma.SortOrder;
    role?: Prisma.SortOrderInput | Prisma.SortOrder;
    operatorId?: Prisma.SortOrderInput | Prisma.SortOrder;
    currentGameSessionid?: Prisma.SortOrderInput | Prisma.SortOrder;
    _count?: Prisma.UserProfileCountOrderByAggregateInput;
    _avg?: Prisma.UserProfileAvgOrderByAggregateInput;
    _max?: Prisma.UserProfileMaxOrderByAggregateInput;
    _min?: Prisma.UserProfileMinOrderByAggregateInput;
    _sum?: Prisma.UserProfileSumOrderByAggregateInput;
};
export type UserProfileScalarWhereWithAggregatesInput = {
    AND?: Prisma.UserProfileScalarWhereWithAggregatesInput | Prisma.UserProfileScalarWhereWithAggregatesInput[];
    OR?: Prisma.UserProfileScalarWhereWithAggregatesInput[];
    NOT?: Prisma.UserProfileScalarWhereWithAggregatesInput | Prisma.UserProfileScalarWhereWithAggregatesInput[];
    id?: Prisma.StringWithAggregatesFilter<"UserProfile"> | string;
    createdAt?: Prisma.DateTimeWithAggregatesFilter<"UserProfile"> | Date | string;
    updatedAt?: Prisma.DateTimeWithAggregatesFilter<"UserProfile"> | Date | string;
    username?: Prisma.StringWithAggregatesFilter<"UserProfile"> | string;
    avatar?: Prisma.StringNullableWithAggregatesFilter<"UserProfile"> | string | null;
    balance?: Prisma.IntWithAggregatesFilter<"UserProfile"> | number;
    totalXpFromOperator?: Prisma.IntWithAggregatesFilter<"UserProfile"> | number;
    activeCurrencyType?: Prisma.StringWithAggregatesFilter<"UserProfile"> | string;
    userId?: Prisma.StringWithAggregatesFilter<"UserProfile"> | string;
    isActive?: Prisma.BoolWithAggregatesFilter<"UserProfile"> | boolean;
    otherUserid?: Prisma.StringNullableWithAggregatesFilter<"UserProfile"> | string | null;
    role?: Prisma.EnumRoleNullableWithAggregatesFilter<"UserProfile"> | $Enums.Role | null;
    operatorId?: Prisma.StringNullableWithAggregatesFilter<"UserProfile"> | string | null;
    currentGameSessionid?: Prisma.StringNullableWithAggregatesFilter<"UserProfile"> | string | null;
};
export type UserProfileCreateInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileCreateManyInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
};
export type UserProfileUpdateManyMutationInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
export type UserProfileUncheckedUpdateManyInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
export type UserProfileScalarRelationFilter = {
    is?: Prisma.UserProfileWhereInput;
    isNot?: Prisma.UserProfileWhereInput;
};
export type UserProfileListRelationFilter = {
    every?: Prisma.UserProfileWhereInput;
    some?: Prisma.UserProfileWhereInput;
    none?: Prisma.UserProfileWhereInput;
};
export type UserProfileOrderByRelationAggregateInput = {
    _count?: Prisma.SortOrder;
};
export type UserProfileNullableScalarRelationFilter = {
    is?: Prisma.UserProfileWhereInput | null;
    isNot?: Prisma.UserProfileWhereInput | null;
};
export type UserProfileCountOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    username?: Prisma.SortOrder;
    avatar?: Prisma.SortOrder;
    balance?: Prisma.SortOrder;
    totalXpFromOperator?: Prisma.SortOrder;
    activeCurrencyType?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    isActive?: Prisma.SortOrder;
    otherUserid?: Prisma.SortOrder;
    role?: Prisma.SortOrder;
    operatorId?: Prisma.SortOrder;
    currentGameSessionid?: Prisma.SortOrder;
};
export type UserProfileAvgOrderByAggregateInput = {
    balance?: Prisma.SortOrder;
    totalXpFromOperator?: Prisma.SortOrder;
};
export type UserProfileMaxOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    username?: Prisma.SortOrder;
    avatar?: Prisma.SortOrder;
    balance?: Prisma.SortOrder;
    totalXpFromOperator?: Prisma.SortOrder;
    activeCurrencyType?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    isActive?: Prisma.SortOrder;
    otherUserid?: Prisma.SortOrder;
    role?: Prisma.SortOrder;
    operatorId?: Prisma.SortOrder;
    currentGameSessionid?: Prisma.SortOrder;
};
export type UserProfileMinOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    createdAt?: Prisma.SortOrder;
    updatedAt?: Prisma.SortOrder;
    username?: Prisma.SortOrder;
    avatar?: Prisma.SortOrder;
    balance?: Prisma.SortOrder;
    totalXpFromOperator?: Prisma.SortOrder;
    activeCurrencyType?: Prisma.SortOrder;
    userId?: Prisma.SortOrder;
    isActive?: Prisma.SortOrder;
    otherUserid?: Prisma.SortOrder;
    role?: Prisma.SortOrder;
    operatorId?: Prisma.SortOrder;
    currentGameSessionid?: Prisma.SortOrder;
};
export type UserProfileSumOrderByAggregateInput = {
    balance?: Prisma.SortOrder;
    totalXpFromOperator?: Prisma.SortOrder;
};
export type UserProfileCreateNestedOneWithoutPastGameSessionsInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutPastGameSessionsInput, Prisma.UserProfileUncheckedCreateWithoutPastGameSessionsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutPastGameSessionsInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
};
export type UserProfileCreateNestedManyWithoutCurrentGameSessionInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutCurrentGameSessionInput, Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput> | Prisma.UserProfileCreateWithoutCurrentGameSessionInput[] | Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput[];
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutCurrentGameSessionInput | Prisma.UserProfileCreateOrConnectWithoutCurrentGameSessionInput[];
    createMany?: Prisma.UserProfileCreateManyCurrentGameSessionInputEnvelope;
    connect?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
};
export type UserProfileUncheckedCreateNestedManyWithoutCurrentGameSessionInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutCurrentGameSessionInput, Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput> | Prisma.UserProfileCreateWithoutCurrentGameSessionInput[] | Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput[];
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutCurrentGameSessionInput | Prisma.UserProfileCreateOrConnectWithoutCurrentGameSessionInput[];
    createMany?: Prisma.UserProfileCreateManyCurrentGameSessionInputEnvelope;
    connect?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
};
export type UserProfileUpdateOneRequiredWithoutPastGameSessionsNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutPastGameSessionsInput, Prisma.UserProfileUncheckedCreateWithoutPastGameSessionsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutPastGameSessionsInput;
    upsert?: Prisma.UserProfileUpsertWithoutPastGameSessionsInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.UserProfileUpdateToOneWithWhereWithoutPastGameSessionsInput, Prisma.UserProfileUpdateWithoutPastGameSessionsInput>, Prisma.UserProfileUncheckedUpdateWithoutPastGameSessionsInput>;
};
export type UserProfileUpdateManyWithoutCurrentGameSessionNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutCurrentGameSessionInput, Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput> | Prisma.UserProfileCreateWithoutCurrentGameSessionInput[] | Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput[];
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutCurrentGameSessionInput | Prisma.UserProfileCreateOrConnectWithoutCurrentGameSessionInput[];
    upsert?: Prisma.UserProfileUpsertWithWhereUniqueWithoutCurrentGameSessionInput | Prisma.UserProfileUpsertWithWhereUniqueWithoutCurrentGameSessionInput[];
    createMany?: Prisma.UserProfileCreateManyCurrentGameSessionInputEnvelope;
    set?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
    disconnect?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
    delete?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
    connect?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
    update?: Prisma.UserProfileUpdateWithWhereUniqueWithoutCurrentGameSessionInput | Prisma.UserProfileUpdateWithWhereUniqueWithoutCurrentGameSessionInput[];
    updateMany?: Prisma.UserProfileUpdateManyWithWhereWithoutCurrentGameSessionInput | Prisma.UserProfileUpdateManyWithWhereWithoutCurrentGameSessionInput[];
    deleteMany?: Prisma.UserProfileScalarWhereInput | Prisma.UserProfileScalarWhereInput[];
};
export type UserProfileUncheckedUpdateManyWithoutCurrentGameSessionNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutCurrentGameSessionInput, Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput> | Prisma.UserProfileCreateWithoutCurrentGameSessionInput[] | Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput[];
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutCurrentGameSessionInput | Prisma.UserProfileCreateOrConnectWithoutCurrentGameSessionInput[];
    upsert?: Prisma.UserProfileUpsertWithWhereUniqueWithoutCurrentGameSessionInput | Prisma.UserProfileUpsertWithWhereUniqueWithoutCurrentGameSessionInput[];
    createMany?: Prisma.UserProfileCreateManyCurrentGameSessionInputEnvelope;
    set?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
    disconnect?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
    delete?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
    connect?: Prisma.UserProfileWhereUniqueInput | Prisma.UserProfileWhereUniqueInput[];
    update?: Prisma.UserProfileUpdateWithWhereUniqueWithoutCurrentGameSessionInput | Prisma.UserProfileUpdateWithWhereUniqueWithoutCurrentGameSessionInput[];
    updateMany?: Prisma.UserProfileUpdateManyWithWhereWithoutCurrentGameSessionInput | Prisma.UserProfileUpdateManyWithWhereWithoutCurrentGameSessionInput[];
    deleteMany?: Prisma.UserProfileScalarWhereInput | Prisma.UserProfileScalarWhereInput[];
};
export type UserProfileCreateNestedOneWithoutGameLaunchLinkInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutGameLaunchLinkInput, Prisma.UserProfileUncheckedCreateWithoutGameLaunchLinkInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutGameLaunchLinkInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
};
export type UserProfileUpdateOneWithoutGameLaunchLinkNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutGameLaunchLinkInput, Prisma.UserProfileUncheckedCreateWithoutGameLaunchLinkInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutGameLaunchLinkInput;
    upsert?: Prisma.UserProfileUpsertWithoutGameLaunchLinkInput;
    disconnect?: Prisma.UserProfileWhereInput | boolean;
    delete?: Prisma.UserProfileWhereInput | boolean;
    connect?: Prisma.UserProfileWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.UserProfileUpdateToOneWithWhereWithoutGameLaunchLinkInput, Prisma.UserProfileUpdateWithoutGameLaunchLinkInput>, Prisma.UserProfileUncheckedUpdateWithoutGameLaunchLinkInput>;
};
export type UserProfileCreateNestedOneWithoutOperatorInvitationsInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutOperatorInvitationsInput, Prisma.UserProfileUncheckedCreateWithoutOperatorInvitationsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutOperatorInvitationsInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
};
export type UserProfileUpdateOneWithoutOperatorInvitationsNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutOperatorInvitationsInput, Prisma.UserProfileUncheckedCreateWithoutOperatorInvitationsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutOperatorInvitationsInput;
    upsert?: Prisma.UserProfileUpsertWithoutOperatorInvitationsInput;
    disconnect?: Prisma.UserProfileWhereInput | boolean;
    delete?: Prisma.UserProfileWhereInput | boolean;
    connect?: Prisma.UserProfileWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.UserProfileUpdateToOneWithWhereWithoutOperatorInvitationsInput, Prisma.UserProfileUpdateWithoutOperatorInvitationsInput>, Prisma.UserProfileUncheckedUpdateWithoutOperatorInvitationsInput>;
};
export type UserProfileCreateNestedOneWithoutTournamentParticipantInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutTournamentParticipantInput, Prisma.UserProfileUncheckedCreateWithoutTournamentParticipantInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutTournamentParticipantInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
};
export type UserProfileUpdateOneRequiredWithoutTournamentParticipantNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutTournamentParticipantInput, Prisma.UserProfileUncheckedCreateWithoutTournamentParticipantInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutTournamentParticipantInput;
    upsert?: Prisma.UserProfileUpsertWithoutTournamentParticipantInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.UserProfileUpdateToOneWithWhereWithoutTournamentParticipantInput, Prisma.UserProfileUpdateWithoutTournamentParticipantInput>, Prisma.UserProfileUncheckedUpdateWithoutTournamentParticipantInput>;
};
export type UserProfileCreateNestedOneWithoutTournamentRewardInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutTournamentRewardInput, Prisma.UserProfileUncheckedCreateWithoutTournamentRewardInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutTournamentRewardInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
};
export type UserProfileUpdateOneWithoutTournamentRewardNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutTournamentRewardInput, Prisma.UserProfileUncheckedCreateWithoutTournamentRewardInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutTournamentRewardInput;
    upsert?: Prisma.UserProfileUpsertWithoutTournamentRewardInput;
    disconnect?: Prisma.UserProfileWhereInput | boolean;
    delete?: Prisma.UserProfileWhereInput | boolean;
    connect?: Prisma.UserProfileWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.UserProfileUpdateToOneWithWhereWithoutTournamentRewardInput, Prisma.UserProfileUpdateWithoutTournamentRewardInput>, Prisma.UserProfileUncheckedUpdateWithoutTournamentRewardInput>;
};
export type UserProfileCreateNestedOneWithoutTransactionsInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutTransactionsInput, Prisma.UserProfileUncheckedCreateWithoutTransactionsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutTransactionsInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
};
export type UserProfileUpdateOneWithoutTransactionsNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutTransactionsInput, Prisma.UserProfileUncheckedCreateWithoutTransactionsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutTransactionsInput;
    upsert?: Prisma.UserProfileUpsertWithoutTransactionsInput;
    disconnect?: Prisma.UserProfileWhereInput | boolean;
    delete?: Prisma.UserProfileWhereInput | boolean;
    connect?: Prisma.UserProfileWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.UserProfileUpdateToOneWithWhereWithoutTransactionsInput, Prisma.UserProfileUpdateWithoutTransactionsInput>, Prisma.UserProfileUncheckedUpdateWithoutTransactionsInput>;
};
export type UserProfileCreateNestedOneWithoutRebateTransactionsInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutRebateTransactionsInput, Prisma.UserProfileUncheckedCreateWithoutRebateTransactionsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutRebateTransactionsInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
};
export type UserProfileUpdateOneRequiredWithoutRebateTransactionsNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutRebateTransactionsInput, Prisma.UserProfileUncheckedCreateWithoutRebateTransactionsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutRebateTransactionsInput;
    upsert?: Prisma.UserProfileUpsertWithoutRebateTransactionsInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.UserProfileUpdateToOneWithWhereWithoutRebateTransactionsInput, Prisma.UserProfileUpdateWithoutRebateTransactionsInput>, Prisma.UserProfileUncheckedUpdateWithoutRebateTransactionsInput>;
};
export type UserProfileCreateNestedOneWithoutWalletsInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutWalletsInput, Prisma.UserProfileUncheckedCreateWithoutWalletsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutWalletsInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
};
export type UserProfileUpdateOneRequiredWithoutWalletsNestedInput = {
    create?: Prisma.XOR<Prisma.UserProfileCreateWithoutWalletsInput, Prisma.UserProfileUncheckedCreateWithoutWalletsInput>;
    connectOrCreate?: Prisma.UserProfileCreateOrConnectWithoutWalletsInput;
    upsert?: Prisma.UserProfileUpsertWithoutWalletsInput;
    connect?: Prisma.UserProfileWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.UserProfileUpdateToOneWithWhereWithoutWalletsInput, Prisma.UserProfileUpdateWithoutWalletsInput>, Prisma.UserProfileUncheckedUpdateWithoutWalletsInput>;
};
export type NullableEnumRoleFieldUpdateOperationsInput = {
    set?: $Enums.Role | null;
};
export type UserProfileCreateWithoutPastGameSessionsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutPastGameSessionsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
};
export type UserProfileCreateOrConnectWithoutPastGameSessionsInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutPastGameSessionsInput, Prisma.UserProfileUncheckedCreateWithoutPastGameSessionsInput>;
};
export type UserProfileCreateWithoutCurrentGameSessionInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutCurrentGameSessionInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileCreateOrConnectWithoutCurrentGameSessionInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutCurrentGameSessionInput, Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput>;
};
export type UserProfileCreateManyCurrentGameSessionInputEnvelope = {
    data: Prisma.UserProfileCreateManyCurrentGameSessionInput | Prisma.UserProfileCreateManyCurrentGameSessionInput[];
    skipDuplicates?: boolean;
};
export type UserProfileUpsertWithoutPastGameSessionsInput = {
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutPastGameSessionsInput, Prisma.UserProfileUncheckedUpdateWithoutPastGameSessionsInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutPastGameSessionsInput, Prisma.UserProfileUncheckedCreateWithoutPastGameSessionsInput>;
    where?: Prisma.UserProfileWhereInput;
};
export type UserProfileUpdateToOneWithWhereWithoutPastGameSessionsInput = {
    where?: Prisma.UserProfileWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutPastGameSessionsInput, Prisma.UserProfileUncheckedUpdateWithoutPastGameSessionsInput>;
};
export type UserProfileUpdateWithoutPastGameSessionsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutPastGameSessionsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
};
export type UserProfileUpsertWithWhereUniqueWithoutCurrentGameSessionInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutCurrentGameSessionInput, Prisma.UserProfileUncheckedUpdateWithoutCurrentGameSessionInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutCurrentGameSessionInput, Prisma.UserProfileUncheckedCreateWithoutCurrentGameSessionInput>;
};
export type UserProfileUpdateWithWhereUniqueWithoutCurrentGameSessionInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutCurrentGameSessionInput, Prisma.UserProfileUncheckedUpdateWithoutCurrentGameSessionInput>;
};
export type UserProfileUpdateManyWithWhereWithoutCurrentGameSessionInput = {
    where: Prisma.UserProfileScalarWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateManyMutationInput, Prisma.UserProfileUncheckedUpdateManyWithoutCurrentGameSessionInput>;
};
export type UserProfileScalarWhereInput = {
    AND?: Prisma.UserProfileScalarWhereInput | Prisma.UserProfileScalarWhereInput[];
    OR?: Prisma.UserProfileScalarWhereInput[];
    NOT?: Prisma.UserProfileScalarWhereInput | Prisma.UserProfileScalarWhereInput[];
    id?: Prisma.StringFilter<"UserProfile"> | string;
    createdAt?: Prisma.DateTimeFilter<"UserProfile"> | Date | string;
    updatedAt?: Prisma.DateTimeFilter<"UserProfile"> | Date | string;
    username?: Prisma.StringFilter<"UserProfile"> | string;
    avatar?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    balance?: Prisma.IntFilter<"UserProfile"> | number;
    totalXpFromOperator?: Prisma.IntFilter<"UserProfile"> | number;
    activeCurrencyType?: Prisma.StringFilter<"UserProfile"> | string;
    userId?: Prisma.StringFilter<"UserProfile"> | string;
    isActive?: Prisma.BoolFilter<"UserProfile"> | boolean;
    otherUserid?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    role?: Prisma.EnumRoleNullableFilter<"UserProfile"> | $Enums.Role | null;
    operatorId?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
    currentGameSessionid?: Prisma.StringNullableFilter<"UserProfile"> | string | null;
};
export type UserProfileCreateWithoutGameLaunchLinkInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutGameLaunchLinkInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileCreateOrConnectWithoutGameLaunchLinkInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutGameLaunchLinkInput, Prisma.UserProfileUncheckedCreateWithoutGameLaunchLinkInput>;
};
export type UserProfileUpsertWithoutGameLaunchLinkInput = {
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutGameLaunchLinkInput, Prisma.UserProfileUncheckedUpdateWithoutGameLaunchLinkInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutGameLaunchLinkInput, Prisma.UserProfileUncheckedCreateWithoutGameLaunchLinkInput>;
    where?: Prisma.UserProfileWhereInput;
};
export type UserProfileUpdateToOneWithWhereWithoutGameLaunchLinkInput = {
    where?: Prisma.UserProfileWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutGameLaunchLinkInput, Prisma.UserProfileUncheckedUpdateWithoutGameLaunchLinkInput>;
};
export type UserProfileUpdateWithoutGameLaunchLinkInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutGameLaunchLinkInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileCreateWithoutOperatorInvitationsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutOperatorInvitationsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileCreateOrConnectWithoutOperatorInvitationsInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutOperatorInvitationsInput, Prisma.UserProfileUncheckedCreateWithoutOperatorInvitationsInput>;
};
export type UserProfileUpsertWithoutOperatorInvitationsInput = {
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutOperatorInvitationsInput, Prisma.UserProfileUncheckedUpdateWithoutOperatorInvitationsInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutOperatorInvitationsInput, Prisma.UserProfileUncheckedCreateWithoutOperatorInvitationsInput>;
    where?: Prisma.UserProfileWhereInput;
};
export type UserProfileUpdateToOneWithWhereWithoutOperatorInvitationsInput = {
    where?: Prisma.UserProfileWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutOperatorInvitationsInput, Prisma.UserProfileUncheckedUpdateWithoutOperatorInvitationsInput>;
};
export type UserProfileUpdateWithoutOperatorInvitationsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutOperatorInvitationsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileCreateWithoutTournamentParticipantInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutTournamentParticipantInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileCreateOrConnectWithoutTournamentParticipantInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutTournamentParticipantInput, Prisma.UserProfileUncheckedCreateWithoutTournamentParticipantInput>;
};
export type UserProfileUpsertWithoutTournamentParticipantInput = {
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutTournamentParticipantInput, Prisma.UserProfileUncheckedUpdateWithoutTournamentParticipantInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutTournamentParticipantInput, Prisma.UserProfileUncheckedCreateWithoutTournamentParticipantInput>;
    where?: Prisma.UserProfileWhereInput;
};
export type UserProfileUpdateToOneWithWhereWithoutTournamentParticipantInput = {
    where?: Prisma.UserProfileWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutTournamentParticipantInput, Prisma.UserProfileUncheckedUpdateWithoutTournamentParticipantInput>;
};
export type UserProfileUpdateWithoutTournamentParticipantInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutTournamentParticipantInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileCreateWithoutTournamentRewardInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutTournamentRewardInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileCreateOrConnectWithoutTournamentRewardInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutTournamentRewardInput, Prisma.UserProfileUncheckedCreateWithoutTournamentRewardInput>;
};
export type UserProfileUpsertWithoutTournamentRewardInput = {
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutTournamentRewardInput, Prisma.UserProfileUncheckedUpdateWithoutTournamentRewardInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutTournamentRewardInput, Prisma.UserProfileUncheckedCreateWithoutTournamentRewardInput>;
    where?: Prisma.UserProfileWhereInput;
};
export type UserProfileUpdateToOneWithWhereWithoutTournamentRewardInput = {
    where?: Prisma.UserProfileWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutTournamentRewardInput, Prisma.UserProfileUncheckedUpdateWithoutTournamentRewardInput>;
};
export type UserProfileUpdateWithoutTournamentRewardInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutTournamentRewardInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileCreateWithoutTransactionsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutTransactionsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileCreateOrConnectWithoutTransactionsInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutTransactionsInput, Prisma.UserProfileUncheckedCreateWithoutTransactionsInput>;
};
export type UserProfileUpsertWithoutTransactionsInput = {
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutTransactionsInput, Prisma.UserProfileUncheckedUpdateWithoutTransactionsInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutTransactionsInput, Prisma.UserProfileUncheckedCreateWithoutTransactionsInput>;
    where?: Prisma.UserProfileWhereInput;
};
export type UserProfileUpdateToOneWithWhereWithoutTransactionsInput = {
    where?: Prisma.UserProfileWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutTransactionsInput, Prisma.UserProfileUncheckedUpdateWithoutTransactionsInput>;
};
export type UserProfileUpdateWithoutTransactionsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutTransactionsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileCreateWithoutRebateTransactionsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    wallets?: Prisma.WalletCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutRebateTransactionsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    wallets?: Prisma.WalletUncheckedCreateNestedManyWithoutUserInput;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileCreateOrConnectWithoutRebateTransactionsInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutRebateTransactionsInput, Prisma.UserProfileUncheckedCreateWithoutRebateTransactionsInput>;
};
export type UserProfileUpsertWithoutRebateTransactionsInput = {
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutRebateTransactionsInput, Prisma.UserProfileUncheckedUpdateWithoutRebateTransactionsInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutRebateTransactionsInput, Prisma.UserProfileUncheckedCreateWithoutRebateTransactionsInput>;
    where?: Prisma.UserProfileWhereInput;
};
export type UserProfileUpdateToOneWithWhereWithoutRebateTransactionsInput = {
    where?: Prisma.UserProfileWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutRebateTransactionsInput, Prisma.UserProfileUncheckedUpdateWithoutRebateTransactionsInput>;
};
export type UserProfileUpdateWithoutRebateTransactionsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutRebateTransactionsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileCreateWithoutWalletsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    transactions?: Prisma.TransactionCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionCreateNestedManyWithoutRefferenceToUserProfileInput;
    currentGameSession?: Prisma.GameSessionCreateNestedOneWithoutUserProfileInput;
};
export type UserProfileUncheckedCreateWithoutWalletsInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
    currentGameSessionid?: string | null;
    transactions?: Prisma.TransactionUncheckedCreateNestedManyWithoutUserProfileInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedCreateNestedManyWithoutUserInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedCreateNestedManyWithoutInvitedUserInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedCreateNestedManyWithoutWinnerInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedCreateNestedManyWithoutUserProfileInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedCreateNestedManyWithoutUserInput;
    pastGameSessions?: Prisma.GameSessionUncheckedCreateNestedManyWithoutRefferenceToUserProfileInput;
};
export type UserProfileCreateOrConnectWithoutWalletsInput = {
    where: Prisma.UserProfileWhereUniqueInput;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutWalletsInput, Prisma.UserProfileUncheckedCreateWithoutWalletsInput>;
};
export type UserProfileUpsertWithoutWalletsInput = {
    update: Prisma.XOR<Prisma.UserProfileUpdateWithoutWalletsInput, Prisma.UserProfileUncheckedUpdateWithoutWalletsInput>;
    create: Prisma.XOR<Prisma.UserProfileCreateWithoutWalletsInput, Prisma.UserProfileUncheckedCreateWithoutWalletsInput>;
    where?: Prisma.UserProfileWhereInput;
};
export type UserProfileUpdateToOneWithWhereWithoutWalletsInput = {
    where?: Prisma.UserProfileWhereInput;
    data: Prisma.XOR<Prisma.UserProfileUpdateWithoutWalletsInput, Prisma.UserProfileUncheckedUpdateWithoutWalletsInput>;
};
export type UserProfileUpdateWithoutWalletsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
    currentGameSession?: Prisma.GameSessionUpdateOneWithoutUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutWalletsInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    currentGameSessionid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileCreateManyCurrentGameSessionInput = {
    id: string;
    createdAt?: Date | string;
    updatedAt?: Date | string;
    username: string;
    avatar?: string | null;
    balance?: number;
    totalXpFromOperator?: number;
    activeCurrencyType?: string;
    userId: string;
    isActive?: boolean;
    otherUserid?: string | null;
    role?: $Enums.Role | null;
    operatorId?: string | null;
};
export type UserProfileUpdateWithoutCurrentGameSessionInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateWithoutCurrentGameSessionInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    wallets?: Prisma.WalletUncheckedUpdateManyWithoutUserNestedInput;
    transactions?: Prisma.TransactionUncheckedUpdateManyWithoutUserProfileNestedInput;
    rebateTransactions?: Prisma.RebateTransactionUncheckedUpdateManyWithoutUserNestedInput;
    operatorInvitations?: Prisma.OperatorInvitationUncheckedUpdateManyWithoutInvitedUserNestedInput;
    TournamentReward?: Prisma.TournamentRewardUncheckedUpdateManyWithoutWinnerNestedInput;
    gameLaunchLink?: Prisma.GameLaunchLinkUncheckedUpdateManyWithoutUserProfileNestedInput;
    TournamentParticipant?: Prisma.TournamentParticipantUncheckedUpdateManyWithoutUserNestedInput;
    pastGameSessions?: Prisma.GameSessionUncheckedUpdateManyWithoutRefferenceToUserProfileNestedInput;
};
export type UserProfileUncheckedUpdateManyWithoutCurrentGameSessionInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    createdAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    updatedAt?: Prisma.DateTimeFieldUpdateOperationsInput | Date | string;
    username?: Prisma.StringFieldUpdateOperationsInput | string;
    avatar?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    balance?: Prisma.IntFieldUpdateOperationsInput | number;
    totalXpFromOperator?: Prisma.IntFieldUpdateOperationsInput | number;
    activeCurrencyType?: Prisma.StringFieldUpdateOperationsInput | string;
    userId?: Prisma.StringFieldUpdateOperationsInput | string;
    isActive?: Prisma.BoolFieldUpdateOperationsInput | boolean;
    otherUserid?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
    role?: Prisma.NullableEnumRoleFieldUpdateOperationsInput | $Enums.Role | null;
    operatorId?: Prisma.NullableStringFieldUpdateOperationsInput | string | null;
};
/**
 * Count Type UserProfileCountOutputType
 */
export type UserProfileCountOutputType = {
    wallets: number;
    transactions: number;
    rebateTransactions: number;
    operatorInvitations: number;
    TournamentReward: number;
    gameLaunchLink: number;
    TournamentParticipant: number;
    pastGameSessions: number;
};
export type UserProfileCountOutputTypeSelect<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    wallets?: boolean | UserProfileCountOutputTypeCountWalletsArgs;
    transactions?: boolean | UserProfileCountOutputTypeCountTransactionsArgs;
    rebateTransactions?: boolean | UserProfileCountOutputTypeCountRebateTransactionsArgs;
    operatorInvitations?: boolean | UserProfileCountOutputTypeCountOperatorInvitationsArgs;
    TournamentReward?: boolean | UserProfileCountOutputTypeCountTournamentRewardArgs;
    gameLaunchLink?: boolean | UserProfileCountOutputTypeCountGameLaunchLinkArgs;
    TournamentParticipant?: boolean | UserProfileCountOutputTypeCountTournamentParticipantArgs;
    pastGameSessions?: boolean | UserProfileCountOutputTypeCountPastGameSessionsArgs;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeDefaultArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the UserProfileCountOutputType
     */
    select?: Prisma.UserProfileCountOutputTypeSelect<ExtArgs> | null;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeCountWalletsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.WalletWhereInput;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeCountTransactionsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.TransactionWhereInput;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeCountRebateTransactionsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.RebateTransactionWhereInput;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeCountOperatorInvitationsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.OperatorInvitationWhereInput;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeCountTournamentRewardArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.TournamentRewardWhereInput;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeCountGameLaunchLinkArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.GameLaunchLinkWhereInput;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeCountTournamentParticipantArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.TournamentParticipantWhereInput;
};
/**
 * UserProfileCountOutputType without action
 */
export type UserProfileCountOutputTypeCountPastGameSessionsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.GameSessionWhereInput;
};
export type UserProfileSelect<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    username?: boolean;
    avatar?: boolean;
    balance?: boolean;
    totalXpFromOperator?: boolean;
    activeCurrencyType?: boolean;
    userId?: boolean;
    isActive?: boolean;
    otherUserid?: boolean;
    role?: boolean;
    operatorId?: boolean;
    currentGameSessionid?: boolean;
    wallets?: boolean | Prisma.UserProfile$walletsArgs<ExtArgs>;
    transactions?: boolean | Prisma.UserProfile$transactionsArgs<ExtArgs>;
    rebateTransactions?: boolean | Prisma.UserProfile$rebateTransactionsArgs<ExtArgs>;
    operatorInvitations?: boolean | Prisma.UserProfile$operatorInvitationsArgs<ExtArgs>;
    TournamentReward?: boolean | Prisma.UserProfile$TournamentRewardArgs<ExtArgs>;
    gameLaunchLink?: boolean | Prisma.UserProfile$gameLaunchLinkArgs<ExtArgs>;
    TournamentParticipant?: boolean | Prisma.UserProfile$TournamentParticipantArgs<ExtArgs>;
    pastGameSessions?: boolean | Prisma.UserProfile$pastGameSessionsArgs<ExtArgs>;
    currentGameSession?: boolean | Prisma.UserProfile$currentGameSessionArgs<ExtArgs>;
    _count?: boolean | Prisma.UserProfileCountOutputTypeDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["userProfile"]>;
export type UserProfileSelectCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    username?: boolean;
    avatar?: boolean;
    balance?: boolean;
    totalXpFromOperator?: boolean;
    activeCurrencyType?: boolean;
    userId?: boolean;
    isActive?: boolean;
    otherUserid?: boolean;
    role?: boolean;
    operatorId?: boolean;
    currentGameSessionid?: boolean;
    currentGameSession?: boolean | Prisma.UserProfile$currentGameSessionArgs<ExtArgs>;
}, ExtArgs["result"]["userProfile"]>;
export type UserProfileSelectUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    username?: boolean;
    avatar?: boolean;
    balance?: boolean;
    totalXpFromOperator?: boolean;
    activeCurrencyType?: boolean;
    userId?: boolean;
    isActive?: boolean;
    otherUserid?: boolean;
    role?: boolean;
    operatorId?: boolean;
    currentGameSessionid?: boolean;
    currentGameSession?: boolean | Prisma.UserProfile$currentGameSessionArgs<ExtArgs>;
}, ExtArgs["result"]["userProfile"]>;
export type UserProfileSelectScalar = {
    id?: boolean;
    createdAt?: boolean;
    updatedAt?: boolean;
    username?: boolean;
    avatar?: boolean;
    balance?: boolean;
    totalXpFromOperator?: boolean;
    activeCurrencyType?: boolean;
    userId?: boolean;
    isActive?: boolean;
    otherUserid?: boolean;
    role?: boolean;
    operatorId?: boolean;
    currentGameSessionid?: boolean;
};
export type UserProfileOmit<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetOmit<"id" | "createdAt" | "updatedAt" | "username" | "avatar" | "balance" | "totalXpFromOperator" | "activeCurrencyType" | "userId" | "isActive" | "otherUserid" | "role" | "operatorId" | "currentGameSessionid", ExtArgs["result"]["userProfile"]>;
export type UserProfileInclude<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    wallets?: boolean | Prisma.UserProfile$walletsArgs<ExtArgs>;
    transactions?: boolean | Prisma.UserProfile$transactionsArgs<ExtArgs>;
    rebateTransactions?: boolean | Prisma.UserProfile$rebateTransactionsArgs<ExtArgs>;
    operatorInvitations?: boolean | Prisma.UserProfile$operatorInvitationsArgs<ExtArgs>;
    TournamentReward?: boolean | Prisma.UserProfile$TournamentRewardArgs<ExtArgs>;
    gameLaunchLink?: boolean | Prisma.UserProfile$gameLaunchLinkArgs<ExtArgs>;
    TournamentParticipant?: boolean | Prisma.UserProfile$TournamentParticipantArgs<ExtArgs>;
    pastGameSessions?: boolean | Prisma.UserProfile$pastGameSessionsArgs<ExtArgs>;
    currentGameSession?: boolean | Prisma.UserProfile$currentGameSessionArgs<ExtArgs>;
    _count?: boolean | Prisma.UserProfileCountOutputTypeDefaultArgs<ExtArgs>;
};
export type UserProfileIncludeCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    currentGameSession?: boolean | Prisma.UserProfile$currentGameSessionArgs<ExtArgs>;
};
export type UserProfileIncludeUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    currentGameSession?: boolean | Prisma.UserProfile$currentGameSessionArgs<ExtArgs>;
};
export type $UserProfilePayload<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    name: "UserProfile";
    objects: {
        wallets: Prisma.$WalletPayload<ExtArgs>[];
        transactions: Prisma.$TransactionPayload<ExtArgs>[];
        rebateTransactions: Prisma.$RebateTransactionPayload<ExtArgs>[];
        operatorInvitations: Prisma.$OperatorInvitationPayload<ExtArgs>[];
        TournamentReward: Prisma.$TournamentRewardPayload<ExtArgs>[];
        gameLaunchLink: Prisma.$GameLaunchLinkPayload<ExtArgs>[];
        TournamentParticipant: Prisma.$TournamentParticipantPayload<ExtArgs>[];
        pastGameSessions: Prisma.$GameSessionPayload<ExtArgs>[];
        currentGameSession: Prisma.$GameSessionPayload<ExtArgs> | null;
    };
    scalars: runtime.Types.Extensions.GetPayloadResult<{
        id: string;
        createdAt: Date;
        updatedAt: Date;
        username: string;
        avatar: string | null;
        balance: number;
        totalXpFromOperator: number;
        activeCurrencyType: string;
        userId: string;
        isActive: boolean;
        otherUserid: string | null;
        role: $Enums.Role | null;
        operatorId: string | null;
        currentGameSessionid: string | null;
    }, ExtArgs["result"]["userProfile"]>;
    composites: {};
};
export type UserProfileGetPayload<S extends boolean | null | undefined | UserProfileDefaultArgs> = runtime.Types.Result.GetResult<Prisma.$UserProfilePayload, S>;
export type UserProfileCountArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = Omit<UserProfileFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
    select?: UserProfileCountAggregateInputType | true;
};
export interface UserProfileDelegate<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: {
        types: Prisma.TypeMap<ExtArgs>['model']['UserProfile'];
        meta: {
            name: 'UserProfile';
        };
    };
    /**
     * Find zero or one UserProfile that matches the filter.
     * @param {UserProfileFindUniqueArgs} args - Arguments to find a UserProfile
     * @example
     * // Get one UserProfile
     * const userProfile = await prisma.userProfile.findUnique({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUnique<T extends UserProfileFindUniqueArgs>(args: Prisma.SelectSubset<T, UserProfileFindUniqueArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    /**
     * Find one UserProfile that matches the filter or throw an error with `error.code='P2025'`
     * if no matches were found.
     * @param {UserProfileFindUniqueOrThrowArgs} args - Arguments to find a UserProfile
     * @example
     * // Get one UserProfile
     * const userProfile = await prisma.userProfile.findUniqueOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findUniqueOrThrow<T extends UserProfileFindUniqueOrThrowArgs>(args: Prisma.SelectSubset<T, UserProfileFindUniqueOrThrowArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Find the first UserProfile that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {UserProfileFindFirstArgs} args - Arguments to find a UserProfile
     * @example
     * // Get one UserProfile
     * const userProfile = await prisma.userProfile.findFirst({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirst<T extends UserProfileFindFirstArgs>(args?: Prisma.SelectSubset<T, UserProfileFindFirstArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    /**
     * Find the first UserProfile that matches the filter or
     * throw `PrismaKnownClientError` with `P2025` code if no matches were found.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {UserProfileFindFirstOrThrowArgs} args - Arguments to find a UserProfile
     * @example
     * // Get one UserProfile
     * const userProfile = await prisma.userProfile.findFirstOrThrow({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     */
    findFirstOrThrow<T extends UserProfileFindFirstOrThrowArgs>(args?: Prisma.SelectSubset<T, UserProfileFindFirstOrThrowArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Find zero or more UserProfiles that matches the filter.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {UserProfileFindManyArgs} args - Arguments to filter and select certain fields only.
     * @example
     * // Get all UserProfiles
     * const userProfiles = await prisma.userProfile.findMany()
     *
     * // Get first 10 UserProfiles
     * const userProfiles = await prisma.userProfile.findMany({ take: 10 })
     *
     * // Only select the `id`
     * const userProfileWithIdOnly = await prisma.userProfile.findMany({ select: { id: true } })
     *
     */
    findMany<T extends UserProfileFindManyArgs>(args?: Prisma.SelectSubset<T, UserProfileFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>;
    /**
     * Create a UserProfile.
     * @param {UserProfileCreateArgs} args - Arguments to create a UserProfile.
     * @example
     * // Create one UserProfile
     * const UserProfile = await prisma.userProfile.create({
     *   data: {
     *     // ... data to create a UserProfile
     *   }
     * })
     *
     */
    create<T extends UserProfileCreateArgs>(args: Prisma.SelectSubset<T, UserProfileCreateArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Create many UserProfiles.
     * @param {UserProfileCreateManyArgs} args - Arguments to create many UserProfiles.
     * @example
     * // Create many UserProfiles
     * const userProfile = await prisma.userProfile.createMany({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     */
    createMany<T extends UserProfileCreateManyArgs>(args?: Prisma.SelectSubset<T, UserProfileCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Create many UserProfiles and returns the data saved in the database.
     * @param {UserProfileCreateManyAndReturnArgs} args - Arguments to create many UserProfiles.
     * @example
     * // Create many UserProfiles
     * const userProfile = await prisma.userProfile.createManyAndReturn({
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     * // Create many UserProfiles and only return the `id`
     * const userProfileWithIdOnly = await prisma.userProfile.createManyAndReturn({
     *   select: { id: true },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     *
     */
    createManyAndReturn<T extends UserProfileCreateManyAndReturnArgs>(args?: Prisma.SelectSubset<T, UserProfileCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>;
    /**
     * Delete a UserProfile.
     * @param {UserProfileDeleteArgs} args - Arguments to delete one UserProfile.
     * @example
     * // Delete one UserProfile
     * const UserProfile = await prisma.userProfile.delete({
     *   where: {
     *     // ... filter to delete one UserProfile
     *   }
     * })
     *
     */
    delete<T extends UserProfileDeleteArgs>(args: Prisma.SelectSubset<T, UserProfileDeleteArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Update one UserProfile.
     * @param {UserProfileUpdateArgs} args - Arguments to update one UserProfile.
     * @example
     * // Update one UserProfile
     * const userProfile = await prisma.userProfile.update({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     *
     */
    update<T extends UserProfileUpdateArgs>(args: Prisma.SelectSubset<T, UserProfileUpdateArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Delete zero or more UserProfiles.
     * @param {UserProfileDeleteManyArgs} args - Arguments to filter UserProfiles to delete.
     * @example
     * // Delete a few UserProfiles
     * const { count } = await prisma.userProfile.deleteMany({
     *   where: {
     *     // ... provide filter here
     *   }
     * })
     *
     */
    deleteMany<T extends UserProfileDeleteManyArgs>(args?: Prisma.SelectSubset<T, UserProfileDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Update zero or more UserProfiles.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {UserProfileUpdateManyArgs} args - Arguments to update one or more rows.
     * @example
     * // Update many UserProfiles
     * const userProfile = await prisma.userProfile.updateMany({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: {
     *     // ... provide data here
     *   }
     * })
     *
     */
    updateMany<T extends UserProfileUpdateManyArgs>(args: Prisma.SelectSubset<T, UserProfileUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    /**
     * Update zero or more UserProfiles and returns the data updated in the database.
     * @param {UserProfileUpdateManyAndReturnArgs} args - Arguments to update many UserProfiles.
     * @example
     * // Update many UserProfiles
     * const userProfile = await prisma.userProfile.updateManyAndReturn({
     *   where: {
     *     // ... provide filter here
     *   },
     *   data: [
     *     // ... provide data here
     *   ]
     * })
     *
     * // Update zero or more UserProfiles and only return the `id`
     * const userProfileWithIdOnly = await prisma.userProfile.updateManyAndReturn({
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
    updateManyAndReturn<T extends UserProfileUpdateManyAndReturnArgs>(args: Prisma.SelectSubset<T, UserProfileUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>;
    /**
     * Create or update one UserProfile.
     * @param {UserProfileUpsertArgs} args - Arguments to update or create a UserProfile.
     * @example
     * // Update or create a UserProfile
     * const userProfile = await prisma.userProfile.upsert({
     *   create: {
     *     // ... data to create a UserProfile
     *   },
     *   update: {
     *     // ... in case it already exists, update
     *   },
     *   where: {
     *     // ... the filter for the UserProfile we want to update
     *   }
     * })
     */
    upsert<T extends UserProfileUpsertArgs>(args: Prisma.SelectSubset<T, UserProfileUpsertArgs<ExtArgs>>): Prisma.Prisma__UserProfileClient<runtime.Types.Result.GetResult<Prisma.$UserProfilePayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    /**
     * Count the number of UserProfiles.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {UserProfileCountArgs} args - Arguments to filter UserProfiles to count.
     * @example
     * // Count the number of UserProfiles
     * const count = await prisma.userProfile.count({
     *   where: {
     *     // ... the filter for the UserProfiles we want to count
     *   }
     * })
    **/
    count<T extends UserProfileCountArgs>(args?: Prisma.Subset<T, UserProfileCountArgs>): Prisma.PrismaPromise<T extends runtime.Types.Utils.Record<'select', any> ? T['select'] extends true ? number : Prisma.GetScalarType<T['select'], UserProfileCountAggregateOutputType> : number>;
    /**
     * Allows you to perform aggregations operations on a UserProfile.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {UserProfileAggregateArgs} args - Select which aggregations you would like to apply and on what fields.
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
    aggregate<T extends UserProfileAggregateArgs>(args: Prisma.Subset<T, UserProfileAggregateArgs>): Prisma.PrismaPromise<GetUserProfileAggregateType<T>>;
    /**
     * Group by UserProfile.
     * Note, that providing `undefined` is treated as the value not being there.
     * Read more here: https://pris.ly/d/null-undefined
     * @param {UserProfileGroupByArgs} args - Group by arguments.
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
    groupBy<T extends UserProfileGroupByArgs, HasSelectOrTake extends Prisma.Or<Prisma.Extends<'skip', Prisma.Keys<T>>, Prisma.Extends<'take', Prisma.Keys<T>>>, OrderByArg extends Prisma.True extends HasSelectOrTake ? {
        orderBy: UserProfileGroupByArgs['orderBy'];
    } : {
        orderBy?: UserProfileGroupByArgs['orderBy'];
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
    }[OrderFields]>(args: Prisma.SubsetIntersection<T, UserProfileGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetUserProfileGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>;
    /**
     * Fields of the UserProfile model
     */
    readonly fields: UserProfileFieldRefs;
}
/**
 * The delegate class that acts as a "Promise-like" for UserProfile.
 * Why is this prefixed with `Prisma__`?
 * Because we want to prevent naming conflicts as mentioned in
 * https://github.com/prisma/prisma-client-js/issues/707
 */
export interface Prisma__UserProfileClient<T, Null = never, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise";
    wallets<T extends Prisma.UserProfile$walletsArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$walletsArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$WalletPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>;
    transactions<T extends Prisma.UserProfile$transactionsArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$transactionsArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$TransactionPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>;
    rebateTransactions<T extends Prisma.UserProfile$rebateTransactionsArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$rebateTransactionsArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$RebateTransactionPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>;
    operatorInvitations<T extends Prisma.UserProfile$operatorInvitationsArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$operatorInvitationsArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$OperatorInvitationPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>;
    TournamentReward<T extends Prisma.UserProfile$TournamentRewardArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$TournamentRewardArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$TournamentRewardPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>;
    gameLaunchLink<T extends Prisma.UserProfile$gameLaunchLinkArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$gameLaunchLinkArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$GameLaunchLinkPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>;
    TournamentParticipant<T extends Prisma.UserProfile$TournamentParticipantArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$TournamentParticipantArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$TournamentParticipantPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>;
    pastGameSessions<T extends Prisma.UserProfile$pastGameSessionsArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$pastGameSessionsArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$GameSessionPayload<ExtArgs>, T, "findMany", GlobalOmitOptions> | Null>;
    currentGameSession<T extends Prisma.UserProfile$currentGameSessionArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.UserProfile$currentGameSessionArgs<ExtArgs>>): Prisma.Prisma__GameSessionClient<runtime.Types.Result.GetResult<Prisma.$GameSessionPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
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
 * Fields of the UserProfile model
 */
export interface UserProfileFieldRefs {
    readonly id: Prisma.FieldRef<"UserProfile", 'String'>;
    readonly createdAt: Prisma.FieldRef<"UserProfile", 'DateTime'>;
    readonly updatedAt: Prisma.FieldRef<"UserProfile", 'DateTime'>;
    readonly username: Prisma.FieldRef<"UserProfile", 'String'>;
    readonly avatar: Prisma.FieldRef<"UserProfile", 'String'>;
    readonly balance: Prisma.FieldRef<"UserProfile", 'Int'>;
    readonly totalXpFromOperator: Prisma.FieldRef<"UserProfile", 'Int'>;
    readonly activeCurrencyType: Prisma.FieldRef<"UserProfile", 'String'>;
    readonly userId: Prisma.FieldRef<"UserProfile", 'String'>;
    readonly isActive: Prisma.FieldRef<"UserProfile", 'Boolean'>;
    readonly otherUserid: Prisma.FieldRef<"UserProfile", 'String'>;
    readonly role: Prisma.FieldRef<"UserProfile", 'Role'>;
    readonly operatorId: Prisma.FieldRef<"UserProfile", 'String'>;
    readonly currentGameSessionid: Prisma.FieldRef<"UserProfile", 'String'>;
}
/**
 * UserProfile findUnique
 */
export type UserProfileFindUniqueArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * Filter, which UserProfile to fetch.
     */
    where: Prisma.UserProfileWhereUniqueInput;
};
/**
 * UserProfile findUniqueOrThrow
 */
export type UserProfileFindUniqueOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * Filter, which UserProfile to fetch.
     */
    where: Prisma.UserProfileWhereUniqueInput;
};
/**
 * UserProfile findFirst
 */
export type UserProfileFindFirstArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * Filter, which UserProfile to fetch.
     */
    where?: Prisma.UserProfileWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of UserProfiles to fetch.
     */
    orderBy?: Prisma.UserProfileOrderByWithRelationInput | Prisma.UserProfileOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for searching for UserProfiles.
     */
    cursor?: Prisma.UserProfileWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` UserProfiles from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` UserProfiles.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     *
     * Filter by unique combinations of UserProfiles.
     */
    distinct?: Prisma.UserProfileScalarFieldEnum | Prisma.UserProfileScalarFieldEnum[];
};
/**
 * UserProfile findFirstOrThrow
 */
export type UserProfileFindFirstOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * Filter, which UserProfile to fetch.
     */
    where?: Prisma.UserProfileWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of UserProfiles to fetch.
     */
    orderBy?: Prisma.UserProfileOrderByWithRelationInput | Prisma.UserProfileOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for searching for UserProfiles.
     */
    cursor?: Prisma.UserProfileWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` UserProfiles from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` UserProfiles.
     */
    skip?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/distinct Distinct Docs}
     *
     * Filter by unique combinations of UserProfiles.
     */
    distinct?: Prisma.UserProfileScalarFieldEnum | Prisma.UserProfileScalarFieldEnum[];
};
/**
 * UserProfile findMany
 */
export type UserProfileFindManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * Filter, which UserProfiles to fetch.
     */
    where?: Prisma.UserProfileWhereInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/sorting Sorting Docs}
     *
     * Determine the order of UserProfiles to fetch.
     */
    orderBy?: Prisma.UserProfileOrderByWithRelationInput | Prisma.UserProfileOrderByWithRelationInput[];
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination#cursor-based-pagination Cursor Docs}
     *
     * Sets the position for listing UserProfiles.
     */
    cursor?: Prisma.UserProfileWhereUniqueInput;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Take `±n` UserProfiles from the position of the cursor.
     */
    take?: number;
    /**
     * {@link https://www.prisma.io/docs/concepts/components/prisma-client/pagination Pagination Docs}
     *
     * Skip the first `n` UserProfiles.
     */
    skip?: number;
    distinct?: Prisma.UserProfileScalarFieldEnum | Prisma.UserProfileScalarFieldEnum[];
};
/**
 * UserProfile create
 */
export type UserProfileCreateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * The data needed to create a UserProfile.
     */
    data: Prisma.XOR<Prisma.UserProfileCreateInput, Prisma.UserProfileUncheckedCreateInput>;
};
/**
 * UserProfile createMany
 */
export type UserProfileCreateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * The data used to create many UserProfiles.
     */
    data: Prisma.UserProfileCreateManyInput | Prisma.UserProfileCreateManyInput[];
    skipDuplicates?: boolean;
};
/**
 * UserProfile createManyAndReturn
 */
export type UserProfileCreateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the UserProfile
     */
    select?: Prisma.UserProfileSelectCreateManyAndReturn<ExtArgs> | null;
    /**
     * Omit specific fields from the UserProfile
     */
    omit?: Prisma.UserProfileOmit<ExtArgs> | null;
    /**
     * The data used to create many UserProfiles.
     */
    data: Prisma.UserProfileCreateManyInput | Prisma.UserProfileCreateManyInput[];
    skipDuplicates?: boolean;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.UserProfileIncludeCreateManyAndReturn<ExtArgs> | null;
};
/**
 * UserProfile update
 */
export type UserProfileUpdateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * The data needed to update a UserProfile.
     */
    data: Prisma.XOR<Prisma.UserProfileUpdateInput, Prisma.UserProfileUncheckedUpdateInput>;
    /**
     * Choose, which UserProfile to update.
     */
    where: Prisma.UserProfileWhereUniqueInput;
};
/**
 * UserProfile updateMany
 */
export type UserProfileUpdateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * The data used to update UserProfiles.
     */
    data: Prisma.XOR<Prisma.UserProfileUpdateManyMutationInput, Prisma.UserProfileUncheckedUpdateManyInput>;
    /**
     * Filter which UserProfiles to update
     */
    where?: Prisma.UserProfileWhereInput;
    /**
     * Limit how many UserProfiles to update.
     */
    limit?: number;
};
/**
 * UserProfile updateManyAndReturn
 */
export type UserProfileUpdateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the UserProfile
     */
    select?: Prisma.UserProfileSelectUpdateManyAndReturn<ExtArgs> | null;
    /**
     * Omit specific fields from the UserProfile
     */
    omit?: Prisma.UserProfileOmit<ExtArgs> | null;
    /**
     * The data used to update UserProfiles.
     */
    data: Prisma.XOR<Prisma.UserProfileUpdateManyMutationInput, Prisma.UserProfileUncheckedUpdateManyInput>;
    /**
     * Filter which UserProfiles to update
     */
    where?: Prisma.UserProfileWhereInput;
    /**
     * Limit how many UserProfiles to update.
     */
    limit?: number;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.UserProfileIncludeUpdateManyAndReturn<ExtArgs> | null;
};
/**
 * UserProfile upsert
 */
export type UserProfileUpsertArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * The filter to search for the UserProfile to update in case it exists.
     */
    where: Prisma.UserProfileWhereUniqueInput;
    /**
     * In case the UserProfile found by the `where` argument doesn't exist, create a new UserProfile with this data.
     */
    create: Prisma.XOR<Prisma.UserProfileCreateInput, Prisma.UserProfileUncheckedCreateInput>;
    /**
     * In case the UserProfile was found with the provided `where` argument, update it with this data.
     */
    update: Prisma.XOR<Prisma.UserProfileUpdateInput, Prisma.UserProfileUncheckedUpdateInput>;
};
/**
 * UserProfile delete
 */
export type UserProfileDeleteArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    /**
     * Filter which UserProfile to delete.
     */
    where: Prisma.UserProfileWhereUniqueInput;
};
/**
 * UserProfile deleteMany
 */
export type UserProfileDeleteManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Filter which UserProfiles to delete
     */
    where?: Prisma.UserProfileWhereInput;
    /**
     * Limit how many UserProfiles to delete.
     */
    limit?: number;
};
/**
 * UserProfile.wallets
 */
export type UserProfile$walletsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Wallet
     */
    select?: Prisma.WalletSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the Wallet
     */
    omit?: Prisma.WalletOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.WalletInclude<ExtArgs> | null;
    where?: Prisma.WalletWhereInput;
    orderBy?: Prisma.WalletOrderByWithRelationInput | Prisma.WalletOrderByWithRelationInput[];
    cursor?: Prisma.WalletWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.WalletScalarFieldEnum | Prisma.WalletScalarFieldEnum[];
};
/**
 * UserProfile.transactions
 */
export type UserProfile$transactionsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the Transaction
     */
    select?: Prisma.TransactionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the Transaction
     */
    omit?: Prisma.TransactionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TransactionInclude<ExtArgs> | null;
    where?: Prisma.TransactionWhereInput;
    orderBy?: Prisma.TransactionOrderByWithRelationInput | Prisma.TransactionOrderByWithRelationInput[];
    cursor?: Prisma.TransactionWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.TransactionScalarFieldEnum | Prisma.TransactionScalarFieldEnum[];
};
/**
 * UserProfile.rebateTransactions
 */
export type UserProfile$rebateTransactionsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    where?: Prisma.RebateTransactionWhereInput;
    orderBy?: Prisma.RebateTransactionOrderByWithRelationInput | Prisma.RebateTransactionOrderByWithRelationInput[];
    cursor?: Prisma.RebateTransactionWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.RebateTransactionScalarFieldEnum | Prisma.RebateTransactionScalarFieldEnum[];
};
/**
 * UserProfile.operatorInvitations
 */
export type UserProfile$operatorInvitationsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the OperatorInvitation
     */
    select?: Prisma.OperatorInvitationSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the OperatorInvitation
     */
    omit?: Prisma.OperatorInvitationOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.OperatorInvitationInclude<ExtArgs> | null;
    where?: Prisma.OperatorInvitationWhereInput;
    orderBy?: Prisma.OperatorInvitationOrderByWithRelationInput | Prisma.OperatorInvitationOrderByWithRelationInput[];
    cursor?: Prisma.OperatorInvitationWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.OperatorInvitationScalarFieldEnum | Prisma.OperatorInvitationScalarFieldEnum[];
};
/**
 * UserProfile.TournamentReward
 */
export type UserProfile$TournamentRewardArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentReward
     */
    select?: Prisma.TournamentRewardSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentReward
     */
    omit?: Prisma.TournamentRewardOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentRewardInclude<ExtArgs> | null;
    where?: Prisma.TournamentRewardWhereInput;
    orderBy?: Prisma.TournamentRewardOrderByWithRelationInput | Prisma.TournamentRewardOrderByWithRelationInput[];
    cursor?: Prisma.TournamentRewardWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.TournamentRewardScalarFieldEnum | Prisma.TournamentRewardScalarFieldEnum[];
};
/**
 * UserProfile.gameLaunchLink
 */
export type UserProfile$gameLaunchLinkArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
    where?: Prisma.GameLaunchLinkWhereInput;
    orderBy?: Prisma.GameLaunchLinkOrderByWithRelationInput | Prisma.GameLaunchLinkOrderByWithRelationInput[];
    cursor?: Prisma.GameLaunchLinkWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.GameLaunchLinkScalarFieldEnum | Prisma.GameLaunchLinkScalarFieldEnum[];
};
/**
 * UserProfile.TournamentParticipant
 */
export type UserProfile$TournamentParticipantArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the TournamentParticipant
     */
    select?: Prisma.TournamentParticipantSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the TournamentParticipant
     */
    omit?: Prisma.TournamentParticipantOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.TournamentParticipantInclude<ExtArgs> | null;
    where?: Prisma.TournamentParticipantWhereInput;
    orderBy?: Prisma.TournamentParticipantOrderByWithRelationInput | Prisma.TournamentParticipantOrderByWithRelationInput[];
    cursor?: Prisma.TournamentParticipantWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.TournamentParticipantScalarFieldEnum | Prisma.TournamentParticipantScalarFieldEnum[];
};
/**
 * UserProfile.pastGameSessions
 */
export type UserProfile$pastGameSessionsArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameSession
     */
    select?: Prisma.GameSessionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameSession
     */
    omit?: Prisma.GameSessionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameSessionInclude<ExtArgs> | null;
    where?: Prisma.GameSessionWhereInput;
    orderBy?: Prisma.GameSessionOrderByWithRelationInput | Prisma.GameSessionOrderByWithRelationInput[];
    cursor?: Prisma.GameSessionWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.GameSessionScalarFieldEnum | Prisma.GameSessionScalarFieldEnum[];
};
/**
 * UserProfile.currentGameSession
 */
export type UserProfile$currentGameSessionArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    /**
     * Select specific fields to fetch from the GameSession
     */
    select?: Prisma.GameSessionSelect<ExtArgs> | null;
    /**
     * Omit specific fields from the GameSession
     */
    omit?: Prisma.GameSessionOmit<ExtArgs> | null;
    /**
     * Choose, which related nodes to fetch as well
     */
    include?: Prisma.GameSessionInclude<ExtArgs> | null;
    where?: Prisma.GameSessionWhereInput;
};
/**
 * UserProfile without action
 */
export type UserProfileDefaultArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
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
};
export {};
