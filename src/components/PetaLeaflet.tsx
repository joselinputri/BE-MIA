'use client';

import { MapContainer, TileLayer, Marker, Popup, ZoomControl } from 'react-leaflet';
import { useEffect, useMemo } from 'react';
import type { Map as LeafletMap } from 'leaflet';
import { useMap } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import { Laporan } from '@/lib/client/data';
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
function createCustomMarker(status: string, isSelected: boolean = false) {
  const info = statusDari(status);
  const color = info.warna;
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

export default function PetaLeaflet({
  laporan,
  selectedId,
  onSelect,
  kategoriFilter,
  kecamatanFilter,
  statusFilter,
}: PetaLeafletProps) {
  // Filter titik laporan
  const filtered = useMemo(
    () =>
      laporan.filter((item) => {
        if (kategoriFilter && kategoriFilter !== 'semua' && item.kategori_slug !== kategoriFilter) {
          return false;
        }
        if (
          kecamatanFilter &&
          kecamatanFilter !== 'semua' &&
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

        {filtered.map((item) => {
          const isSelected = selectedId === item.id;
          const icon = createCustomMarker(item.status, isSelected);

          return (
            <Marker
              key={item.id}
              position={[item.latitude, item.longitude]}
              icon={icon}
              eventHandlers={{
                click: () => onSelect && onSelect(item),
              }}
            >
              <Popup className="custom-leaflet-popup">
                <div className="p-2 max-w-[240px] text-navy">
                  <div className="flex items-center justify-between gap-2 mb-1.5">
                    <span className="text-[10px] font-mono font-bold bg-navy text-white px-1.5 py-0.5 rounded">
                      #{item.kode_lacak}
                    </span>
                    <span className="text-[10px] font-semibold text-slate">
                      {item.kelurahan}, {item.kecamatan}
                    </span>
                  </div>
                  <h4 className="text-xs font-bold leading-snug line-clamp-2 text-navy mb-1">
                    {item.judul}
                  </h4>
                  <p className="text-[11px] text-navy/70 line-clamp-2 mb-2">
                    {item.deskripsi}
                  </p>
                  <div className="flex items-center justify-between pt-1 border-t border-navy/10">
                    <span className="text-[10px] font-semibold text-navy/70">
                      {statusDari(item.status).label}
                    </span>
                    <Link
                      href={`/riwayat?kode=${item.kode_lacak}`}
                      className="text-[11px] font-bold text-crimson hover:underline inline-flex items-center gap-0.5"
                    >
                      Lacak <ArrowRight className="w-2.5 h-2.5" />
                    </Link>
                  </div>
                </div>
              </Popup>
            </Marker>
          );
        })}
      </MapContainer>
    </div>
  );
}
