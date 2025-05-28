"use strict";
// Event payload types, matching those defined in server/src/events.ts
// It's good practice to have these shared if clients also need to understand event structures,
// or if you have a stricter separation where server event definitions live in shared/dist.
// For now, I'm assuming the primary definitions are in server/src/events.ts and
// these would be re-exports or mirrors.
Object.defineProperty(exports, "__esModule", { value: true });
