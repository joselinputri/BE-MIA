/**
 * src/lib/server/response.ts
 * Helper Pembuat Respons Standar API (Data, Meta, Error)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextResponse } from 'next/server';
import { ApiResponse, ErrorCode, MetaType } from '../contracts/common';

const STATUS_CODE_MAP: Record<ErrorCode, number> = {
  VALIDATION_ERROR: 422,
  UNAUTHORIZED: 401,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  RATE_LIMITED: 429,
  INVALID_STATUS_TRANSITION: 400,
  CONFLICT: 409,
  SERVICE_UNAVAILABLE: 503,
  INTERNAL_ERROR: 500,
};

export function apiSukses<T>(data: T, meta?: MetaType, status: number = 200) {
  const body: ApiResponse<T> = { data };
  if (meta) {
    body.meta = meta;
  }
  return NextResponse.json(body, { status });
}

export function apiError(
  kode: ErrorCode,
  pesan: string,
  detail?: Record<string, any>
) {
  const status = STATUS_CODE_MAP[kode] || 400;
  const body: ApiResponse<never> = {
    error: {
      kode,
      pesan,
      ...(detail ? { detail } : {}),
    },
  };
  return NextResponse.json(body, { status });
}
