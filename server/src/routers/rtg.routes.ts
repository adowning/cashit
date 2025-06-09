import { Context, Hono } from 'hono'
import { 
  rtgSpinCached, 
  rtgSettings, 
  rtgSpin, 
  rtgSpinWithPerformanceMetrics, 
  rtgSpinOptimized 
} from '../services/rtg.service'
import type { User, Session } from '@/generated/index'

// Debouncing mechanism
interface DebounceEntry {
  lastCall: number
  timeout?: NodeJS.Timeout
}

class Debouncer {
  private entries = new Map<string, DebounceEntry>()
  private readonly DEBOUNCE_TIME_MS = 1000 // 1 second debounce

  isDebounced(key: string): boolean {
    const entry = this.entries.get(key)
    if (!entry) return false

    const now = Date.now()
    const timeSinceLastCall = now - entry.lastCall

    return timeSinceLastCall < this.DEBOUNCE_TIME_MS
  }

  markCall(key: string): void {
    const now = Date.now()
    const entry = this.entries.get(key)

    if (entry?.timeout) {
      clearTimeout(entry.timeout)
    }

    this.entries.set(key, {
      lastCall: now,
      timeout: setTimeout(() => {
        this.entries.delete(key)
      }, this.DEBOUNCE_TIME_MS * 2), // Clean up after 2x debounce time
    })
  }
}

const debouncer = new Debouncer()

export class RtgApi {
  public app: Hono

  constructor(app) {
    this.app = app
    this.setupRoutes()
  }
  private setupRoutes() {
    this.app.post(
      '/rtg/games/rtg/platform/:token/:gameName/game/settings',
      this.rtgSettings.bind(this)
    )
    // Cached version (main route - fastest)
    this.app.post('/rtg/games/rtg/platform/:id/:token/game/spin', this.rtgSpinCached.bind(this))
    // Optimized Bun.sql version
    this.app.post(
      '/rtg/games/rtg/platform/:id/:token/game/spin-optimized',
      this.rtgSpinOptimized.bind(this)
    )
    // Performance measurement version
    this.app.post(
      '/rtg/games/rtg/platform/:id/:token/game/spin-perf',
      this.rtgSpinWithPerformance.bind(this)
    )
    // Keep original route for comparison
    this.app.post('/rtg/games/rtg/platform/:id/:token/game/spin-original', this.rtgSpin.bind(this))
  }

  private async rtgSettings(c: Context) {
    try {
      const user = c.env.context?.user as User | undefined;
      const gameName = c.req.param('gameName');

      if (!gameName) {
        return c.json({ success: false, error: 'GAME_NAME_MISSING' }, 400);
      }

      if (!user?.id) {
        return c.json({ success: false, error: 'USER_NOT_AUTHENTICATED' }, 401);
      }

      // Create debounce key using user ID and endpoint
      const debounceKey = `rtgSettings:${user.id}:${gameName}`;

      if (debouncer.isDebounced(debounceKey)) {
        return c.json(
          {
            success: false,
            error: 'TOO_MANY_REQUESTS',
            message: 'Please wait before making another request',
          },
          429
        );
      }

      // Mark this call to start debouncing
      debouncer.markCall(debounceKey);

      return rtgSettings(c,  gameName);
    } catch (error) {
      console.error('Error in rtgSettings route:', error);
      return c.json({ success: false, error: 'Internal server error' }, 500);
    }
  }

  private async rtgSpin(c: Context) {
    try {
      const user = c.env.context?.user as User | undefined;
      const session = c.env.context?.session as Session | undefined;
      const token = c.req.param('token');

      if (!user?.id) {
        return c.json({ success: false, error: 'USER_NOT_AUTHENTICATED' }, 401);
      }

      if (!token) {
        return c.json({ success: false, error: 'TOKEN_MISSING' }, 400);
      }

      if (!session) {
        return c.json({ success: false, error: 'SESSION_NOT_FOUND' }, 400);
      }

      // Create debounce key using user ID and endpoint
      const debounceKey = `rtgSpin:${user.id}:${token}`;

      if (debouncer.isDebounced(debounceKey)) {
        return c.json(
          {
            success: false,
            error: 'TOO_MANY_REQUESTS',
            message: 'Please wait before making another spin request',
          },
          429
        );
      }

      // Mark this call to start debouncing
      debouncer.markCall(debounceKey);

      return rtgSpin(c, user, session, token);
    } catch (error) {
      console.error('Error in rtgSpin route:', error);
      return c.json({ success: false, error: 'Internal server error' }, 500);
    }
  }

  private async rtgSpinWithPerformance(c: Context) {
    try {
      const user = c.env.context?.user as User | undefined;
      const session = c.env.context?.session as Session | undefined;
      const token = c.req.param('token');

      if (!user?.id) {
        return c.json({ success: false, error: 'USER_NOT_AUTHENTICATED' }, 401);
      }

      if (!token) {
        return c.json({ success: false, error: 'TOKEN_MISSING' }, 400);
      }

      if (!session) {
        return c.json({ success: false, error: 'SESSION_NOT_FOUND' }, 400);
      }

      // Create debounce key using user ID and endpoint
      const debounceKey = `rtgSpinPerf:${user.id}:${token}`;

      if (debouncer.isDebounced(debounceKey)) {
        return c.json(
          {
            success: false,
            error: 'TOO_MANY_REQUESTS',
            message: 'Please wait before making another spin request',
          },
          429
        );
      }

      // Mark this call to start debouncing
      debouncer.markCall(debounceKey);

      return rtgSpinWithPerformanceMetrics(c, user, session, token);
    } catch (error) {
      console.error('Error in rtgSpinWithPerformance route:', error);
      return c.json({ success: false, error: 'Internal server error' }, 500);
    }
  }

  private async rtgSpinOptimized(c: Context) {
    try {
      const user = c.env.context?.user as User | undefined;
      const session = c.env.context?.session as Session | undefined;
      const token = c.req.param('token');
      
      // Extract gameName from the URL path
      let gameName: string | undefined;
      const platformSplit = c.req.path.split('platform/');
      
      if (platformSplit.length > 1 && platformSplit[1] !== undefined) {
        const gameSplit = platformSplit[1].split('/game');
        if (gameSplit.length > 0) {
          gameName = gameSplit[0]?.split('/')[1];
        }
      }

      if (!user?.id) {
        return c.json({ success: false, error: 'USER_NOT_AUTHENTICATED' }, 401);
      }

      if (!token) {
        return c.json({ success: false, error: 'TOKEN_MISSING' }, 400);
      }
      
      if (!session) {
        return c.json({ success: false, error: 'SESSION_NOT_FOUND' }, 400);
      }

      if (!gameName) {
        return c.json({ success: false, error: 'GAME_NAME_MISSING' }, 400);
      }

      // Create debounce key using user ID and endpoint
      const debounceKey = `rtgSpinOptimized:${user.id}:${token}`;

      if (debouncer.isDebounced(debounceKey)) {
        return c.json(
          {
            success: false,
            error: 'TOO_MANY_REQUESTS',
            message: 'Please wait before making another request',
          },
          429
        );
      }

      // Mark this call to start debouncing
      debouncer.markCall(debounceKey);

      return rtgSpinOptimized(c, user, session, gameName);
    } catch (error) {
      console.error('Error in rtgSpinOptimized route:', error);
      return c.json({ success: false, error: 'Internal server error' }, 500);
    }
  }

  private async rtgSpinCached(c: Context) {
    try {
      const user = c.env.context?.user as User | undefined;
      const session = c.env.context?.session as Session | undefined;
      const token = c.req.param('token');
      
      // Extract gameName from the URL path
      let gameName: string | undefined;
      const platformSplit = c.req.path.split('platform/');
      
      if (platformSplit.length > 1 && platformSplit[1] !== undefined) {
        const gameSplit = platformSplit[1].split('/game');
        if (gameSplit.length > 0) {
          gameName = gameSplit[0]?.split('/')[1] + 'RTG';
        }
      }

      if (!user?.id) {
        return c.json({ success: false, error: 'USER_NOT_AUTHENTICATED' }, 401);
      }

      if (!token) {
        return c.json({ success: false, error: 'TOKEN_MISSING' }, 400);
      }
      
      if (!session) {
        return c.json({ success: false, error: 'SESSION_NOT_FOUND' }, 400);
      }

      // Create debounce key using user ID and endpoint
      const debounceKey = `rtgSpinCached:${user.id}:${token}`;

      if (debouncer.isDebounced(debounceKey)) {
        return c.json(
          {
            success: false,
            error: 'TOO_MANY_REQUESTS',
            message: 'Please wait before making another request',
          },
          429
        );
      }

      // Mark this call to start debouncing
      debouncer.markCall(debounceKey);

      return rtgSpinCached(c, user, session, gameName || 'default');
    } catch (error) {
      console.error('Error in rtgSpinCached route:', error);
      return c.json({ success: false, error: 'Internal server error' }, 500);
    }
  }
}
