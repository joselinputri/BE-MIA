'use client';

import { MapContainer, TileLayer, Marker, Popup, ZoomControl } from 'react-leaflet';
import { useEffect, useMemo } from 'react';
import type { Map as LeafletMap } from 'leaflet';
import { useMap } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import { Laporan } from '@/lib/client/data';
import { KATEGORI } from '@/lib/kategori';
import { statusDari } from '@/lib/status';
import Link from 'next/link';
import { ArrowRight } from 'lucide-react';

interface PetaLeafletProps {
  laporan: Laporan[];
  selectedId?: string | null;
  onSelect?: (lap: Laporan) => void;
  kategoriFilter?: string;
  kecamatanFilter?: string;
  statusFilter?: string;
  warnaBerdasarkan?: 'status' | 'kategori';
}

const PUSAT_KECAMATAN: Record<string, [number, number]> = {
  banjarsari: [-7.541, 110.824],
  jebres: [-7.55, 110.85],
  laweyan: [-7.568, 110.795],
  'pasar kliwon': [-7.581, 110.831],
  serengan: [-7.578, 110.813],
};

function SesuaikanViewport({
  laporan,
  kecamatanFilter,
}: {
  laporan: Laporan[];
  kecamatanFilter: string;
}) {
  const map = useMap();

  useEffect(() => {
    if (kecamatanFilter !== 'semua' && PUSAT_KECAMATAN[kecamatanFilter.toLowerCase()]) {
      const titikKecamatan = laporan.filter(
        (item) => item.kecamatan?.toLowerCase() === kecamatanFilter.toLowerCase()
      );

      if (titikKecamatan.length > 0) {
        geserKeTitik(map, titikKecamatan);
      } else {
        map.flyTo(PUSAT_KECAMATAN[kecamatanFilter.toLowerCase()], 14, { duration: 0.8 });
      }
      return;
    }

    if (laporan.length > 0) {
      geserKeTitik(map, laporan);
      return;
    }

    map.flyTo([-7.5684, 110.825], 13, { duration: 0.8 });
  }, [kecamatanFilter, laporan, map]);

  return null;
}

function geserKeTitik(map: LeafletMap, laporan: Laporan[]) {
  const bounds = L.latLngBounds(laporan.map((item) => [item.latitude, item.longitude]));
  if (!bounds.isValid()) return;

  if (bounds.getNorthEast().equals(bounds.getSouthWest())) {
    map.flyTo(bounds.getCenter(), 15, { duration: 0.8 });
    return;
  }

  map.flyToBounds(bounds, { padding: [40, 40], maxZoom: 15, duration: 0.8 });
}

// Marker icon generator berbasis SVG murni
function createCustomMarker(
  status: string,
  isSelected: boolean = false,
  kategoriSlug?: string,
  warnaBerdasarkan: 'status' | 'kategori' = 'status'
) {
  const color =
    warnaBerdasarkan === 'kategori'
      ? KATEGORI.find((kategori) => kategori.slug === kategoriSlug)?.warna || '#64748B'
      : statusDari(status).warna;
  const size = isSelected ? 36 : 28;

  const svg = `
    <svg xmlns="http://www.w3.org/2000/svg" width="${size}" height="${size}" viewBox="0 0 32 32">
      <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
        <feDropShadow dx="0" dy="2" stdDeviation="3" flood-color="#000" flood-opacity="0.4"/>
      </filter>
      <circle cx="16" cy="16" r="${isSelected ? 14 : 11}" fill="${color}" stroke="#ffffff" stroke-width="${isSelected ? 3 : 2}" filter="url(#shadow)" />
      ${
        isSelected
          ? `<circle cx="16" cy="16" r="5" fill="#ffffff" />`
          : `<circle cx="16" cy="16" r="3.5" fill="#ffffff" />`
      }
    </svg>
  `;

  return L.divIcon({
    html: svg,
    className: 'custom-leaflet-pin',
    iconSize: [size, size],
    iconAnchor: [size / 2, size / 2],
    popupAnchor: [0, -size / 2],
  });
}

function createClusterMarker(laporan: Laporan[], warnaBerdasarkan: 'status' | 'kategori') {
  const warna = Array.from(
    new Set(
      laporan.map((item) =>
        warnaBerdasarkan === 'kategori'
          ? KATEGORI.find((kategori) => kategori.slug === item.kategori_slug)?.warna || '#64748B'
          : statusDari(item.status).warna
      )
    )
  );
  const warnaLatar = warna.length === 1 ? warna[0] : '#28264B';

  return L.divIcon({
    html: `<span style="display:grid;place-items:center;width:34px;height:34px;border:3px solid #fff;border-radius:50%;background:${warnaLatar};box-shadow:0 2px 8px #28264b66;color:#fff;font-size:12px;font-weight:800">${laporan.length}</span>`,
    className: 'custom-leaflet-pin',
    iconSize: [34, 34],
    iconAnchor: [17, 17],
  });
}

export default function PetaLeaflet({
  laporan,
  selectedId,
  onSelect,
  kategoriFilter,
  kecamatanFilter,
  statusFilter,
  warnaBerdasarkan = 'status',
}: PetaLeafletProps) {
  // Filter titik laporan
  const filtered = useMemo(
    () =>
      laporan.filter((item) => {
        if (kategoriFilter && kategoriFilter !== 'semua' && item.kategori_slug !== kategoriFilter) {
          return false;
        }
        if (
          kecamatanFilter === 'tanpa-kecamatan' &&
          item.kecamatan
        ) {
          return false;
        }
        if (
          kecamatanFilter &&
          kecamatanFilter !== 'semua' &&
          kecamatanFilter !== 'tanpa-kecamatan' &&
          item.kecamatan?.toLowerCase() !== kecamatanFilter.toLowerCase()
        ) {
          return false;
        }
        if (statusFilter && statusFilter !== 'semua' && item.status !== statusFilter) {
          return false;
        }
        return true;
      }),
    [kategoriFilter, kecamatanFilter, laporan, statusFilter]
  );
  const kelompokLokasi = useMemo(() => {
    const groups = new Map<string, Laporan[]>();
    filtered.forEach((item) => {
      const key = `${item.latitude.toFixed(5)},${item.longitude.toFixed(5)}`;
      const group = groups.get(key);
      if (group) group.push(item);
      else groups.set(key, [item]);
    });
    return Array.from(groups.values());
  }, [filtered]);

  // Titik pusat Kota Surakarta (Balai Kota / Gladag)
  const centerPosition: [number, number] = [-7.5684, 110.825];

  return (
    <div className="relative w-full h-[540px] rounded-2xl overflow-hidden border border-navy/20 shadow-inner">
      <MapContainer
        center={centerPosition}
        zoom={13}
        scrollWheelZoom={false}
        zoomControl={false}
        className="w-full h-full tile-gelap"
      >
        <ZoomControl position="topleft" />
        {/* OpenStreetMap Tile Layer dengan styling tone redup yang ramah kontras gelap */}
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        <SesuaikanViewport laporan={filtered} kecamatanFilter={kecamatanFilter || 'semua'} />

        {kelompokLokasi.map((group) => {
          const item = group[0];
          const isSelected = group.some((laporanItem) => laporanItem.id === selectedId);
          const icon =
            group.length > 1
              ? createClusterMarker(group, warnaBerdasarkan)
              : createCustomMarker(item.status, isSelected, item.kategori_slug, warnaBerdasarkan);

          return (
            <Marker
              key={`${item.latitude.toFixed(5)},${item.longitude.toFixed(5)}`}
              position={[item.latitude, item.longitude]}
              icon={icon}
              eventHandlers={{
                click: () => onSelect && onSelect(item),
              }}
            >
              <Popup className="custom-leaflet-popup">
                <div className="p-2 max-w-[240px] text-navy">
                  {group.length > 1 && (
                    <p className="mb-2 text-[10px] font-bold text-navy/70">
                      {group.length} laporan di lokasi yang sama
                    </p>
                  )}
                  {group.map((laporanItem) => (
                    <div key={laporanItem.id} className="border-t border-navy/10 py-2 first:border-0 first:pt-0">
                      <button
                        type="button"
                        onClick={() => onSelect?.(laporanItem)}
                        className="block text-left"
                      >
                        <span className="text-[10px] font-mono font-bold text-navy">
                          #{laporanItem.kode_lacak}
                        </span>
                        <span className="ml-2 text-[10px] font-semibold text-slate">
                          {laporanItem.kelurahan || laporanItem.kecamatan || 'Wilayah belum dipetakan'}
                        </span>
                        <span className="mt-0.5 block text-xs font-bold leading-snug text-navy">
                          {laporanItem.judul}
                        </span>
                        <span className="mt-0.5 block text-[10px] font-semibold text-navy/70">
                          {statusDari(laporanItem.status).label}
                        </span>
                      </button>
                      <Link
                        href={`/riwayat?kode=${laporanItem.kode_lacak}`}
                        className="mt-1 inline-flex items-center gap-0.5 text-[11px] font-bold text-crimson hover:underline"
                      >
                        Lacak <ArrowRight className="h-2.5 w-2.5" />
                      </Link>
                    </div>
                  ))}
                </div>
              </Popup>
            </Marker>
          );
        })}
      </MapContainer>
    </div>
  );
}
