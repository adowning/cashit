import 'dotenv/config' //uncomment this to load .env
import path from 'node:path'
// import type { PrismaConfig } from "prisma";

export default {
  earlyAccess: true,
  schema: path.join('prisma', 'schema'),
}
