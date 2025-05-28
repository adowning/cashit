export * from './types/index';
import type { UserProfile as PrismaUserProfile } from '../../server/prisma/generated';
export type UserProfile = PrismaUserProfile & {};
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
