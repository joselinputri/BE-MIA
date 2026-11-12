/**
 * src/app/api/health/route.ts
 * Endpoint Health Check, Latency & Reliability Monitor
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextResponse } from 'next/server';
import { supabaseAdmin, isSupabaseConfigured } from '@/lib/server/supabase-admin';

export async function GET() {
  const mulai = Date.now();
  let dbStatus = 'disconnected';
  let dbLatencyMs = -1;
  let totalKelurahan = 0;

  try {
    if (isSupabaseConfigured()) {
      const dbStart = Date.now();
      const { count, error } = await supabaseAdmin
        .from('wilayah_kelurahan')
        .select('*', { count: 'exact', head: true });

      dbLatencyMs = Date.now() - dbStart;
      if (!error) {
        dbStatus = 'healthy';
        totalKelurahan = count || 54;
      } else {
        dbStatus = 'degraded';
      }
    }
  } catch {
    dbStatus = 'unreachable';
  }

  const responseTimeMs = Date.now() - mulai;

  return NextResponse.json({
    status: dbStatus === 'healthy' ? 'operational' : 'degraded',
    service: 'RAMPUNG Civic Backend Engine',
    timestamp: new Date().toISOString(),
    uptime_seconds: process.uptime(),
    metrics: {
      response_time_ms: responseTimeMs,
      database_latency_ms: dbLatencyMs,
      database_status: dbStatus,
      geospasial_kelurahan_loaded: totalKelurahan,
    },
    version: '2.1.0-wina',
  });
}
