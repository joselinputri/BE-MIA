'use client';

import { useState, useEffect } from 'react';
import { supabaseBrowser } from '@/lib/client/supabase';
import { Bell, CheckCircle2, AlertCircle, X } from 'lucide-react';

interface NotifikasiItem {
  id: string;
  tipe: 'aduan_baru' | 'aduan_selesai';
  judul: string;
  pesan: string;
  waktu: string;
}

export default function NotifikasiToastLive() {
  const [daftarNotifikasi, setDaftarNotifikasi] = useState<NotifikasiItem[]>([]);

  useEffect(() => {
    if (!supabaseBrowser) return;

    const channel = supabaseBrowser
      .channel('notifikasi_toast_global')
      .on(
        'postgres_changes',
        { event: 'INSERT', schema: 'public', table: 'laporan' },
        (payload: any) => {
          const baru = payload.new;
          tambahNotifikasi({
            id: `notif-${Date.now()}-${Math.random()}`,
            tipe: 'aduan_baru',
            judul: 'Aduan Warga Baru Masuk',
            pesan: `${baru.judul || 'Laporan infrastruktur baru'} #${baru.kode_lacak || ''}`,
            waktu: 'Baru saja',
          });
        }
      )
      .on(
        'postgres_changes',
        { event: 'UPDATE', schema: 'public', table: 'laporan' },
        (payload: any) => {
          const update = payload.new;
          if (update.status === 'selesai') {
            tambahNotifikasi({
              id: `notif-${Date.now()}-${Math.random()}`,
              tipe: 'aduan_selesai',
              judul: 'Aduan Selesai Ditangani',
              pesan: `Tiket #${update.kode_lacak} telah tuntas diperbaiki oleh tim lapangan.`,
              waktu: 'Baru saja',
            });
          }
        }
      )
      .subscribe();

    return () => {
      supabaseBrowser?.removeChannel(channel);
    };
  }, []);

  function tambahNotifikasi(notif: NotifikasiItem) {
    setDaftarNotifikasi((prev) => [notif, ...prev.slice(0, 2)]);
    setTimeout(() => {
      hapusNotifikasi(notif.id);
    }, 6000);
  }

  function hapusNotifikasi(id: string) {
    setDaftarNotifikasi((prev) => prev.filter((item) => item.id !== id));
  }

  if (daftarNotifikasi.length === 0) return null;

  return (
    <div className="fixed bottom-5 right-5 z-50 flex flex-col gap-2.5 max-w-sm w-full pointer-events-none px-4 sm:px-0">
      {daftarNotifikasi.map((item) => (
        <div
          key={item.id}
          className="pointer-events-auto bg-white/95 backdrop-blur-md rounded-2xl border-2 p-3.5 shadow-xl flex items-start gap-3 animate-in slide-in-from-bottom-5 duration-300 border-navy/15 text-navy"
        >
          <div
            className={`p-2 rounded-xl text-white shrink-0 ${
              item.tipe === 'aduan_selesai' ? 'bg-emerald-600' : 'bg-crimson'
            }`}
          >
            {item.tipe === 'aduan_selesai' ? (
              <CheckCircle2 className="w-4 h-4" />
            ) : (
              <Bell className="w-4 h-4 animate-bounce" />
            )}
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex items-center justify-between gap-2">
              <p className="text-xs font-extrabold text-navy truncate">{item.judul}</p>
              <span className="text-[10px] text-navy/50">{item.waktu}</span>
            </div>
            <p className="text-[11px] text-navy/70 line-clamp-2 mt-0.5 leading-snug">
              {item.pesan}
            </p>
          </div>
          <button
            type="button"
            onClick={() => hapusNotifikasi(item.id)}
            className="text-navy/40 hover:text-navy p-1"
          >
            <X className="w-3.5 h-3.5" />
          </button>
        </div>
      ))}
    </div>
  );
}

