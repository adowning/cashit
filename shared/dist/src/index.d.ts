export * from './types/index';
import type { User as SharedUserType, Profile, Settings, VipInfo } from './types/index';
export type UserProfile = SharedUserType & {
    profile: Profile | null;
    settings: Settings | null;
    vipInfo: VipInfo | null;
};
export interface PaginatedResponse<T> {
    items: T[];
    total: number;
    page: number;
    limit: number;
    totalPages: number;
    hasNextPage?: boolean;
    hasPrevPage?: boolean;
}
export type GenericApiResponse<T = any> = {
    success: boolean;
    data: T | null;
    error?: string | null;
    errorCode?: string | number | null;
};
export type GenericError = {
    code: number | string;
    message: string;
    details?: any;
};
//# sourceMappingURL=index.d.ts.map