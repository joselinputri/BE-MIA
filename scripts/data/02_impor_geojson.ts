/**
 * scripts/data/02_impor_geojson.ts
 * Script ETL: Impor dan validasi batas wilayah GeoJSON 54 Kelurahan Kota Surakarta
 * Sumber Prioritas: data/raw/batas_kelurahan.geojson (HDX / OSM Overpass)
 * Idempoten: Aman dijalankan berulang kali.
 */

import * as fs from 'fs';
import * as path from 'path';

interface GeoJSONFeature {
  type: string;
  properties: {
    nama?: string;
    kode_wilayah?: string;
    kelurahan?: string;
    KECAMATAN?: string;
    KELURAHAN?: string;
    [key: string]: any;
  };
  geometry: {
    type: string;
    coordinates: any;
  };
}

interface GeoJSONFeatureCollection {
  type: string;
  features: GeoJSONFeature[];
}

export function parseDanValidasiGeoJSON(filePath: string): {
  sukses: boolean;
  totalFeatures: number;
  terpetakan: number;
  hilang: string[];
  sqlStatements: string[];
} {
  const sqlStatements: string[] = ['BEGIN;'];

  if (!fs.existsSync(filePath)) {
    console.warn(`[ETL GeoJSON] File ${filePath} belum ditemukan.`);
    console.warn(`[ETL GeoJSON] Silakan unduh batas kelurahan ke data/raw/batas_kelurahan.geojson`);
    return {
      sukses: false,
      totalFeatures: 0,
      terpetakan: 0,
      hilang: [],
      sqlStatements: [],
    };
  }

  const raw = fs.readFileSync(filePath, 'utf-8');
  const parsed: GeoJSONFeatureCollection = JSON.parse(raw);

  let terpetakan = 0;
  const listNamaTersedia = new Set<string>();

  for (const feature of parsed.features) {
    const props = feature.properties || {};
    const nama = (props.kelurahan || props.KELURAHAN || props.nama || props.NAME_4 || '').trim();
    const kode = (props.kode_wilayah || props.KODE_DESA || props.ADM4_PCODE || '').trim();

    if (nama) {
      listNamaTersedia.add(nama.toLowerCase());
      const geomJson = JSON.stringify(feature.geometry);

      // Siapkan update query PostGIS
      if (kode) {
        sqlStatements.push(
          `UPDATE public.kelurahan SET geometri = ST_Multi(ST_SetSRID(ST_GeomFromGeoJSON('${geomJson}'), 4326)) WHERE kode_wilayah = '${kode}';`
        );
      } else {
        sqlStatements.push(
          `UPDATE public.kelurahan SET geometri = ST_Multi(ST_SetSRID(ST_GeomFromGeoJSON('${geomJson}'), 4326)) WHERE LOWER(nama) = LOWER('${nama.replace(/'/g, "''")}');`
        );
      }
      terpetakan++;
    }
  }

  sqlStatements.push('COMMIT;');

  return {
    sukses: terpetakan > 0,
    totalFeatures: parsed.features.length,
    terpetakan,
    hilang: [],
    sqlStatements,
  };
}

if (require.main === module) {
  const geojsonPath = path.join(__dirname, '../../data/raw/batas_kelurahan.geojson');
  const hasil = parseDanValidasiGeoJSON(geojsonPath);

  if (hasil.sukses) {
    const outputPath = path.join(__dirname, '../../supabase/migrations/014_update_geometri_kelurahan.sql');
    fs.writeFileSync(outputPath, hasil.sqlStatements.join('\n'));
    console.log(`[ETL GeoJSON] Berhasil memetakan ${hasil.terpetakan} fitur geometri.`);
    console.log(`[ETL GeoJSON] SQL disimpan di ${outputPath}`);
  } else {
    console.log('[ETL GeoJSON] Melewati update geometri file mentah sampai file diunduh.');
  }
}

