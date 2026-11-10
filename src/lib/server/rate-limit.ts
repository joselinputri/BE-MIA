/**
 * src/lib/server/rate-limit.ts
 * Rate Limiter Sisi Server (Sliding Window In-Memory)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { createHash } from 'crypto';

interface RateLimitRecord {
  count: number;
  resetAt: number;
}

// In-memory bucket cache
const rateLimitStore = new Map<string, RateLimitRecord>();

// Bersihkan record expired setiap 5 menit untuk hemat memori
setInterval(() => {
  const now = Date.now();
  for (const [key, value] of rateLimitStore.entries()) {
    if (value.resetAt <= now) {
      rateLimitStore.delete(key);
    }
  }
}, 5 * 60 * 1000).unref();

export function hashIP(ip: string): string {
  return createHash('sha256').update(ip + (process.env.SUPABASE_SERVICE_ROLE_KEY || 'rampung_salt')).digest('hex');
}

export interface RateLimitCheckResult {
  allowed: boolean;
  limit: number;
  remaining: number;
  resetSeconds: number;
}

export function periksaRateLimit(
  identifier: string,
  prefix: string,
  maxLimit: number,
  windowSeconds: number
): RateLimitCheckResult {
  const key = `${prefix}:${identifier}`;
  const now = Date.now();
  const windowMs = windowSeconds * 1000;

  let record = rateLimitStore.get(key);

  if (!record || record.resetAt <= now) {
    record = {
      count: 1,
      resetAt: now + windowMs,
    };
    rateLimitStore.set(key, record);
    return {
      allowed: true,
      limit: maxLimit,
      remaining: maxLimit - 1,
      resetSeconds: windowSeconds,
    };
  }

  if (record.count >= maxLimit) {
    return {
      allowed: false,
      limit: maxLimit,
      remaining: 0,
      resetSeconds: Math.ceil((record.resetAt - now) / 1000),
    };
  }

  record.count += 1;
  return {
    allowed: true,
    limit: maxLimit,
    remaining: maxLimit - record.count,
    resetSeconds: Math.ceil((record.resetAt - now) / 1000),
  };
}

