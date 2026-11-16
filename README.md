# TechStore — Mini Teknoloji Kataloğu Mobil Uygulaması

Flutter ve Dart kullanılarak geliştirilmiş; temel widget ağacı, GridView tabanlı ürün vitrini, anlık arama filtresi, sayfalar arası navigasyon (`Navigator.push`) ve dinamik sepet sayacı (`setState`) özelliklerini barındıran mobil katalog uygulamasıdır.

## Kullanılan Teknolojiler ve Sürüm Bilgisi
- **Flutter SDK:** 3.x (Stable)
- **Dart SDK:** 3.x
- **UI Kütüphanesi:** Material Design (`package:flutter/material.dart`)

## Proje Özellikleri
- **Ürün Kataloğu (Ana Sayfa):** `GridView.builder` ile kart tabanlı 2 sütunlu ürün listeleme ve anlık arama çubuğu.
- **Ürün Detay Sayfası:** Seçilen ürünün kategori, fiyat ve açıklama bilgilerinin gösterimi.
- **Sepet Yönetimi:** Ürün detay sayfasından "Sepete Ekle" butonuna tıklandığında üst çubuktaki sepet sayacının anlık güncellenmesi.

## Kurulum ve Çalıştırma Adımları
1. Projeyi bilgisayarınıza indirin veya klonlayın:
   ```bash
   git clone [https://github.com/kullaniciadi/techstore-catalog.git](https://github.com/kullaniciadi/techstore-catalog.git)
