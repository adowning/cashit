"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.NETWORK_CONFIG = void 0;
//Event Macro Definition
var NETWORK_CONFIG;
(function (NETWORK_CONFIG) {
    //Login Related News
    class LOGIN {
        static LOGIN = '/auth/login'; //Login
        static LOGOUT = '/auth/logout'; //Login
        static REGISTER = '/auth/register'; //Registration
        static GOOGLE = '/auth/google'; //Registration
        static GET_SESSION = '/auth/session';
        static REFRESH_TOKEN = '/auth/refresh';
    }
    NETWORK_CONFIG.LOGIN = LOGIN;
    class OPERATOR {
        static GET_ALL = '/operator/user'; //Login
        static PROFILES_BY_OPERATOR = '/operator/:operatorId/users';
    }
    NETWORK_CONFIG.OPERATOR = OPERATOR;
    //Business logic after entering the home page
    class HOME_PAGE {
        static HEALTH = '/home/health'; //Login
    }
    NETWORK_CONFIG.HOME_PAGE = HOME_PAGE;
    // user profile info api config group
    class PERSONAL_INFO_PAGE {
        static USER_AMOUNT = '/user/amount'; // get user amount
        static USER_INFO = '/user/info'; // get user profile
        static USER_BALANCE = '/user/balance'; // get user balance
        static USER_CHANGE = '/user/change'; // update user info
        static USER_EMAIL = '/user/email'; // update email
        static USER_CASHTAG = '/user/cashtag';
        static USER_PASSWORD = '/user/password'; // update password
        static USER_SUSPEND = '/user/suspend'; // suspend user
        static USER_CHECK = '/user/check'; // user check
        static USER_EMAIL_VERIFY = '/user/verifyemail'; // user email verify
        static SET_USER_CURRENCY = '/user/currency';
    }
    NETWORK_CONFIG.PERSONAL_INFO_PAGE = PERSONAL_INFO_PAGE;
    class PRAGMATIC {
        static GAME_RUN = '/game_start.do';
        static GAME_DEMO = '/game_start.do';
        static GAME_LIST = '/game_list.do';
        static GAME_MAINTENANCE = '/game_maintenance.do';
        static GAME_WITH_PATTERN = '/games_with_pattern.do';
        static GAME_STATUS = '/game_change_status';
    }
    NETWORK_CONFIG.PRAGMATIC = PRAGMATIC;
    // NETWORK_CONFIG.PRAGMATIC.GENERATE;
    // NETWORK_CONFIG.PRAGMATIC.IS_ALIVE;
    // NETWORK_CONFIG.PRAGMATIC.MINILOBBY.GAMES;
    // NETWORK_CONFIG.PRAGMATIC.MINILOBBY.START;
    // NETWORK_CONFIG.PRAGMATIC.MINILOBBY.GAMES;
    // NETWORK_CONFIG.PRAGMATIC.RELOAD_BALANCE;
    // NETWORK_CONFIG.PRAGMATIC.STATS;
    // NETWORK_CONFIG.PRAGMATIC.SAVE_SETTINGS;
    // NETWORK_CONFIG.PRAGMATIC.GAME_HISTORY.LAST;
    // NETWORK_CONFIG.PRAGMATIC.GAME_HISTORY.DETAILS;
    // NETWORK_CONFIG.PRAGMATIC.GAME_HISTORY.PLAY_SESSION.LAST_ITEMS;
    // NETWORK_CONFIG.PRAGMATIC.GAME_HISTORY.SETTINGS.generalGameHistory;
    // NETWORK_CONFIG.PRAGMATIC.GAME_HISTORY.PLAY_SESSION.childrenHistory;
    // NETWORK_CONFIG.PRAGMATIC.GAME_HISTORY.PLAY_SESSION.generalGameHistory;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.PLAY_SESSION.childrenHistory;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.race.details;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.race.prizes;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.race.prizes;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.race.winners;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.race.player.CHOICE.OPTIN;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.TOURNAMENT.DETAILS;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.TOURNAMENT.V3.LEADER_BOARD;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.TOURNAMENT.V2.LEADER_BOARD;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.TOURNAMENT.player.CHOICE.OPTIN;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.TOURNAMENT.scores;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.TOURNAMENT.scores;
    // NETWORK_CONFIG.PRAGMATIC.PROMO.FRB.AVAILABLE;
    // NETWORK_CONFIG.PRAGMATIC.ReplayService.api.top.WINNINGS.LIST;
    // NETWORK_CONFIG.PRAGMATIC.ReplayService.api.share.link;
    // NETWORK_CONFIG.PRAGMATIC.ReplayService.api.REPLAY.data;
    // NETWORK_CONFIG.PRAGMATIC.ReplayService.REPLAY_GAME;
    // NETWORK_CONFIG.PRAGMATIC.SHARED_REPLAY;
    // NETWORK_CONFIG.PRAGMATIC.VERIFY.API.SESSION;
    // NETWORK_CONFIG.PRAGMATIC.VERIFY;
    // deposit api
    class DEPOSIT_PAGE {
        static CONFIG = '/user/depositcfg'; // get user deposit configuration
        static SUBMIT = '/user/depositsubmit'; // user deposit submit
        static HISTORY = '/user/deposithistory'; // user deposit history
        static PRODUCTS = '/user/depositproducts'; // user deposit history
        static OPERATOR_DATA = '/user/operator_data'; // user deposit history
        static GET_CURRENT_USER_TRANSACTIONS = '/user/transactions'; // user deposit history
        static CANCEL_PENDING = '/user/cancelpending';
    }
    NETWORK_CONFIG.DEPOSIT_PAGE = DEPOSIT_PAGE;
    // withdraw api
    class WITHDRAW_PAGE {
        static WITHDRAWAL_CONFIG = '/user/withdrawalcfg'; // get user withdraw configuration
        static WITHDRAWAL_SUBMIT = '/user/withdrawalsubmit'; // user withdraw submit
        static WITHDRAWAL_HISTORY = '/user/withdrawalhistory'; // withdrawal history
        static WITHDRAWAL_REFUND = '/user/withdrawalrefund'; // withdrawal history
    }
    NETWORK_CONFIG.WITHDRAW_PAGE = WITHDRAW_PAGE;
    // invite api
    class INVITE_PAGE {
        static INVITE_INFO = '/user/invite'; // get user invite information
        static INVITER_AWARD = '/user/inviter/award'; // receive invitation achievement commission
        static INVITE_SELF = '/user/invite/self'; // personal invitation information
        static INVITE_HISTORY_CONFIG = '/user/invite/historycfg'; // invitation event commission record configuration
        static INVITE_HISTORY = '/user/invite/history'; //
        static SET_REFERRER = '/user/refferer'; //
    }
    NETWORK_CONFIG.INVITE_PAGE = INVITE_PAGE;
    // game api
    class GAME_INFO {
        static GAME_LIST = '/games/gamelist'; // get game category
        static GAME_CATEGORY = '/games/categories'; // get game category
        static GAME_SEARCH = '/games/search'; // game search
        static GAME_ENTER = '/user/enter/game'; // game enter
        static USER_GAME = '/user/games'; // user game
        static FAVORITE_GAME = '/user/setup/game'; // favorite game
        static FAVORITE_GAME_LIST = '/user/setup/game/list'; // favorite game
        static GAME_HISTORY = '/user/gamehistory'; // game history
        static GAME_BIGWIN = '/user/bigwin';
        static GAME_DETAIL = '/games/detail';
        static PROVIDERS = '/games/providers';
        static SPIN = '/user/spin';
        static SPINPAGE = '/user/spin/page';
        static RTG_SETTINGS = '/game/settings';
        static RTG_SETTINGS2 = '/public/:token/game/settings';
        static RTG_SETTINGS3 = '/games/rtg/platform/:userid/:gameName/game/settings';
        static RTG_SPIN = '/games/rtg/platform/:userid/:gameName/game/settings';
        // static RTG_SPIN = '/game/:token/game/settings'
        // http://localhost:3000/api/games/rtg/platform/H5N9xV70HKorWvAcqzTb0hGg26ansypu/777Strike/game/spin
        static NETENT_SPIN = '/games/netent/platform/userId/gameName/game/spin';
    }
    NETWORK_CONFIG.GAME_INFO = GAME_INFO;
    // vip api
    class VIP_INFO {
        static USER_VIP_INFO = '/user/vipinfo'; // vip info
        static USER_VIP_LEVEL = '/viplevels'; // vip levels
        static VIP_TASKS = 'user/viptasks'; // vip tasks
        static VIP_LEVEL_AWARD = '/user/viplevel/award'; // vip level award
        static VIP_REBATE_AWARD = '/user/viprebate/award'; // vip rebate award
        static VIP_REBATE_HISTORY = '/user/viprebatehistory'; // get vip coding record
        static VIP_LEVEL_AWARD_HISTORY = '/user/viplevelawardhistory'; // Obtain VIP level reward record
        static VIP_TIMES_HISTORY = '/user/viptimeshistory'; // Get VIP weekly and monthly reward records
        static VIP_SIGNIN_REWARDS = '/user/vipsignin/award'; // Receive VIP sign-in rewards
        // static VIP_SIGNIN = '/user/vipsignin'; // Get VIP check-in content
        static VIP_SIGNIN = '/user/vip/signinaward/list'; // Get VIP check-in content  获取签到奖励
        static VIP_SIGNINAWARD_RECEIVE = '/user/vip/signinaward/receive'; // Get sign-in rewards  领取签到奖励
        static VIP_LEVELUP_LIST = '/user/viplevelup/list'; // Get VIP upgrade reward information
        static VIP_LEVELUP_RECEIVE = '/user/viplevelup/receive'; // Receive VIP upgrade rewards
        static USER_VIP_CYCLEAWARD_LIST = '/user/vip/cycleaward/list'; // Get periodic rewards  获取周期性奖励
        static USER_VIP_CYCLEAWARD_RECEIVE = '/user/vip/cycleaward/receive'; // Receive periodic rewards  领取周期性奖励
        static USER_VIP_LEVELAWARD_LIST = '/user/vip/levelaward/list'; // Get level-related rewards  获取等级相关奖励
        static USER_VIP_LEVELAWARD_RECEIVE = '/user/vip/levelaward/receive'; // Receive level-related rewards  领取等级相关奖励
        static USER_VIP_BETAWARD_LIST = '/user/vip/betaward/list'; // Get coding rebates  获取打码返利
        static USER_VIP_BETAWARD_RECEIVE = '/user/vip/betaward/receive'; // Get coding rebates  领取打码返利
    }
    NETWORK_CONFIG.VIP_INFO = VIP_INFO;
    // websocket api
    class WEB_SOCKET {
        static SOCKET_CONNECT = '/user/connect/websocket';
    }
    NETWORK_CONFIG.WEB_SOCKET = WEB_SOCKET;
    class ACTIVITY {
        static USER_ACTIVITY_LIST = '/activity/list';
    }
    NETWORK_CONFIG.ACTIVITY = ACTIVITY;
    // transaction api
    class TRANSACTION_PAGE {
        static TRANSACTION_HISTORY = '/user/transactionshistory';
    }
    NETWORK_CONFIG.TRANSACTION_PAGE = TRANSACTION_PAGE;
    // bonus api
    class BONUS_PAGE {
        static USER_BONUS = '/user/bonuses';
        static BONUS_CANCEL = '/user/bonusescancel';
    }
    NETWORK_CONFIG.BONUS_PAGE = BONUS_PAGE;
    //Listening events sent actively
    class UNSOLICITED {
    }
    NETWORK_CONFIG.UNSOLICITED = UNSOLICITED;
    class CURRENCY {
        static CURRENCY_LIST = '/currency';
    }
    NETWORK_CONFIG.CURRENCY = CURRENCY;
    // bonus api
    class REWARD_ROUTES {
        static RECIEVE_ACHIV_BONUS = '/reward/achivbonus';
        static REWARD_LIST = '/reward/list';
    }
    NETWORK_CONFIG.REWARD_ROUTES = REWARD_ROUTES;
    class ACHIEVEMENT_ROUTES {
        static ACHIEVEMENT_LIST = '/achievement/achivbonus';
        static ACHIEVEMENT_CONFIG = '/achievement/achivconfig';
        static RECIEVE_ACHIV_BONUS = '/achievement/receiveachivbonus';
        static STAGE_AWARD = '/achievement/stageaward';
        static ACHIEVEMENT_AWARD = '/achievement/achivaward';
    }
    NETWORK_CONFIG.ACHIEVEMENT_ROUTES = ACHIEVEMENT_ROUTES;
    class TOURNAMENTS {
        static LIST = '/'; // GET /tournaments
        static DETAILS = '/:id'; // GET /tournaments/:id
        static LEADERBOARD = '/:id/leaderboard'; // GET /tournaments/:id/leaderboard
        static JOIN = '/:id/join'; // POST /tournaments/:id/join
    }
    NETWORK_CONFIG.TOURNAMENTS = TOURNAMENTS;
    class ADMIN_TOURNAMENTS {
        static CREATE = '/'; // POST /admin/tournaments
        static UPDATE = '/:id'; // PUT /admin/tournaments/:id
        static START = '/:id/start'; // POST /admin/tournaments/:id/start
        static END = '/:id/end'; // POST /admin/tournaments/:id/end
    }
    NETWORK_CONFIG.ADMIN_TOURNAMENTS = ADMIN_TOURNAMENTS;
})(NETWORK_CONFIG || (exports.NETWORK_CONFIG = NETWORK_CONFIG = {}));
