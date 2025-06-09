import { PrismaClient } from '@prisma/client';

// Add prisma to the NodeJS global type
interface CustomNodeJsGlobal {
  prisma?: PrismaClient;
}

// Prevent multiple instances of Prisma Client in development
declare const global: CustomNodeJsGlobal;

const prisma = global.prisma || new PrismaClient({
  log: process.env.NODE_ENV === 'development' ? ['query', 'error', 'warn'] : ['error'],
});

if (process.env.NODE_ENV === 'development') {
  global.prisma = prisma;
}

export { prisma };

// Export Prisma types
export * from '@prisma/client';
