import { withAccelerate } from '@prisma/extension-accelerate';
import { performance } from 'perf_hooks';
import * as util from 'util';
import { Prisma, PrismaClient } from '../src/generated/index.js';
// Define the findUniqueDetailsExtension (this definition is correct)
const findUniqueDetailsExtension = Prisma.defineExtension((client) => {
    return client.$extends({
        client: {
            async findUniqueDetails(modelName, args) {
                const dmmfObject = client.$dmmf;
                if (!dmmfObject?.datamodel?.models) {
                    throw new Error('DMMF object or datamodel not found on the Prisma client instance. ' +
                        'Ensure you are using a compatible Prisma version and the client is correctly generated.');
                }
                const modelDmmf = dmmfObject.datamodel.models.find((m) => m.name === modelName);
                if (!modelDmmf) {
                    const availableModels = dmmfObject.datamodel.models
                        .map((m) => m.name)
                        .join(', ');
                    throw new Error(`Model "${modelName}" not found in Prisma DMMF. Available models are: ${availableModels}`);
                }
                const includeClause = {};
                for (const field of modelDmmf.fields) {
                    if (field.kind === 'object' && field.relationName) {
                        includeClause[field.name] = true;
                    }
                }
                const typedIncludeClause = includeClause;
                const delegate = this[(modelName.charAt(0).toLowerCase() + modelName.slice(1))];
                if (!delegate?.findUnique) {
                    throw new Error(`Prisma delegate for model "${modelName}" not found on the client or it does not have a findUnique method.`);
                }
                const result = await delegate.findUnique({
                    ...args,
                    include: typedIncludeClause,
                });
                return result; // Cast to any or ensure full type matches promise
            },
        },
    });
});
// Function to create a new PrismaClient and apply ALL extensions
const createExtendedClient = () => {
    console.log('Creating and extending new PrismaClient instance.');
    const client = new PrismaClient();
    return (client
        .$extends(findUniqueDetailsExtension) // Your custom extension first
        .$extends(withAccelerate()) // Then Accelerate
        .$extends({
        // Logging extension
        query: {
            $allModels: {
                async $allOperations({ operation, model, args, query }) {
                    const start = performance.now();
                    const result = await query(args);
                    const end = performance.now();
                    const time = end - start;
                    console.log(util.inspect({ model, operation, args, time }, { showHidden: false, depth: null, colors: true }));
                    return result;
                },
            },
        },
    })
        .$extends({
        // Exists extension
        model: {
            $allModels: {
                async exists(where) {
                    const context = Prisma.getExtensionContext(this);
                    const result = await context.findFirst({ where });
                    return result !== null;
                },
            },
        },
    })
        // .$extends({
        //   model: {
        //     user: {
        //       async create(args: Prisma.UserCreateArgs) {
        //         // Create the user first
        //         const user = await client.user.create(args)
        //         // Then, create the UserProfile with the same ID and username
        //         // and other relevant details from the user.
        //         // The 'userId' field in UserProfile refers to the User's id.
        //         await client.userProfile.create({
        //           data: {
        //             id: user.id, // Use the User's id as the UserProfile's id
        //             username: user.name, // Set username from the created user
        //             userId: user.id, // Link UserProfile to User via the userId field
        //             // Set default values for other UserProfile fields as needed,
        //             // or ensure your schema has appropriate defaults.
        //             // For example:
        //             // avatar: 'avatar-10.webp', // Default from your schema
        //             // balance: 0, // Default from your schema
        //             // totalXpFromOperator: 0, // Default from your schema
        //             // activeCurrencyType: 'USD', // Default from your schema
        //             // lastDailySpin: new Date('1970-01-01T00:00:00Z'), // Default from your schema
        //             // isActive: false, // Default from your schema
        //             // role: 'USER', // Default from your schema
        //           },
        //         })
        //         return user
        //       },
        //     },
        //   },
        // })
        .$extends({
        // User result extension
        result: {
            user: {
                profileId: {
                    compute(user) {
                        return user.id;
                    },
                },
            },
        },
    })
        .$extends({
        // UserProfile result extension
        result: {
            userProfile: {
                userId: {
                    compute(userProfile) {
                        return userProfile.id;
                    },
                },
            },
        },
    }));
};
// Singleton pattern for Prisma Client
const globalForPrisma = globalThis;
// Instantiate the prisma client, reusing the instance in development
const prisma = globalForPrisma.prisma ?? createExtendedClient();
// Export the fully extended client
export default prisma;
// Cache the instance in development environments.
if (process.env.NODE_ENV !== 'production') {
    globalForPrisma.prisma = prisma;
}
