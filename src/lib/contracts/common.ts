/**
 * src/lib/contracts/common.ts
 * Kontrak Standar Respons API & Tipe Data Dasar
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { z } from 'zod';

export type ErrorCode =
  | 'VALIDATION_ERROR'
  | 'UNAUTHORIZED'
  | 'FORBIDDEN'
  | 'NOT_FOUND'
  | 'RATE_LIMITED'
  | 'INVALID_STATUS_TRANSITION'
  | 'CONFLICT'
  | 'INTERNAL_ERROR';

export const ProvenanceEnum = z.enum([
  'asli',
  'agregat_resmi',
  'simulasi_terkalibrasi',
  'simulasi',
]);
export type ProvenanceType = z.infer<typeof ProvenanceEnum>;

export const SumberMetaSchema = z.object({
  provenance: ProvenanceEnum,
  nama_sumber: z.string(),
  waktu_pembaruan: z.string(),
  url: z.string().optional(),
});
export type SumberMeta = z.infer<typeof SumberMetaSchema>;

export const MetaSchema = z.object({
  cursor_berikutnya: z.string().nullable().optional(),
  total: z.number().int().nonnegative().optional(),
  sumber: z.array(SumberMetaSchema),
  waktu_query: z.string(),
});
export type MetaType = z.infer<typeof MetaSchema>;

export const ApiErrorSchema = z.object({
  kode: z.enum([
    'VALIDATION_ERROR',
    'UNAUTHORIZED',
    'FORBIDDEN',
    'NOT_FOUND',
    'RATE_LIMITED',
    'INVALID_STATUS_TRANSITION',
    'CONFLICT',
    'INTERNAL_ERROR',
  ]),
  pesan: z.string(),
  detail: z.record(z.any()).optional(),
});
export type ApiErrorType = z.infer<typeof ApiErrorSchema>;

export interface ApiResponse<T> {
  data?: T;
  meta?: MetaType;
  error?: ApiErrorType;
}

export const PaginationQuerySchema = z.object({
  cursor: z.string().optional(),
  limit: z.coerce.number().int().min(1).max(100).default(20),
  fields: z.string().optional(), // 'ringkas' | 'lengkap' | 'id,judul,status'
});
export type PaginationQuery = z.infer<typeof PaginationQuerySchema>;

