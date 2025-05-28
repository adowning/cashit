"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TournamentStatus = void 0;
// export { Role, UserStatus /*, etc. */ } from '../prisma/interfaces' // Assuming shared is your Prisma client package
// Or define them manually if you don't want to expose Prisma directly
var TournamentStatus;
(function (TournamentStatus) {
    TournamentStatus["PENDING"] = "PENDING";
    TournamentStatus["ACTIVE"] = "ACTIVE";
    TournamentStatus["COMPLETED"] = "COMPLETED";
    TournamentStatus["CANCELLED"] = "CANCELLED";
})(TournamentStatus || (exports.TournamentStatus = TournamentStatus = {}));
