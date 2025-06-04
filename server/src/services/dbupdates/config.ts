import { ev } from './utils/env'

export default {
  DEBUG: false, //['false', true].includes(ev('DEBUG')),
  defaults: {
    DB_USER: 'postgres.acqrudqzutnwrvmvlshc',
    DB_PASSWORD: 'acqrudqzutnwrvmvlshc',
    DB_HOST: 'aws-0-us-east-2.pooler.supabase.com',
    DB_P0RT: 6543,
    DB_NAME: 'postgres',
    MIN_POOL_CONNECTIONS: 2,
    MAX_POOL_CONNECTIONS: 10,
    CHANNEL: 'spec_data_change',
    BUFFER_INTERVAL: 0, // ms
    MAX_BUFFER_SIZE: 1000,
    TABLE_SCHEMA: 'public',
  },
}
