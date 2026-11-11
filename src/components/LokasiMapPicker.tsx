'use client';

import { useEffect, useMemo } from 'react';
import L from 'leaflet';
import { MapContainer, Marker, TileLayer, ZoomControl, useMap, useMapEvents } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';

interface LokasiMapPickerProps {
  latitude: number;
  longitude: number;
  onChange: (latitude: number, longitude: number) => void;
}

const BATAS_SURAKARTA: L.LatLngBoundsExpression = [
  [-7.6, 110.77],
  [-7.52, 110.87],
];

function PerubahanPeta({ onChange }: { onChange: LokasiMapPickerProps['onChange'] }) {
  useMapEvents({
    click(event) {
      onChange(event.latlng.lat, event.latlng.lng);
    },
  });

  return null;
}

function PosisikanPeta({ latitude, longitude }: Pick<LokasiMapPickerProps, 'latitude' | 'longitude'>) {
  const map = useMap();

  useEffect(() => {
    map.setView([latitude, longitude], map.getZoom(), { animate: true });
  }, [latitude, longitude, map]);

  return null;
}

export default function LokasiMapPicker({ latitude, longitude, onChange }: LokasiMapPickerProps) {
  const icon = useMemo(
    () =>
      L.divIcon({
        className: 'rampung-location-marker',
        html: '<span></span>',
        iconSize: [28, 36],
        iconAnchor: [14, 34],
      }),
    []
  );

  return (
    <div className="h-56 overflow-hidden rounded-2xl border border-navy/15">
      <MapContainer
        center={[latitude, longitude]}
        zoom={15}
        minZoom={12}
        maxZoom={19}
        maxBounds={BATAS_SURAKARTA}
        maxBoundsViscosity={1}
        scrollWheelZoom
        zoomControl={false}
        className="h-full w-full tile-gelap"
      >
        <ZoomControl position="topright" />
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        <PosisikanPeta latitude={latitude} longitude={longitude} />
        <PerubahanPeta onChange={onChange} />
        <Marker
          position={[latitude, longitude]}
          icon={icon}
          draggable
          eventHandlers={{
            dragend(event) {
              const { lat, lng } = event.target.getLatLng();
              onChange(lat, lng);
            },
          }}
        />
      </MapContainer>
    </div>
  );
}
