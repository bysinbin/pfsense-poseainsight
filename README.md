# PoseaInsight for pfSense &bull; Derin Ağ Analitiği & Canlı Trafik İstihbaratı

PoseaInsight, kurumsal ağınızdaki her cihazın ne zaman, nereye, hangi protokolle ve ne kadar bant genişliğiyle bağlandığını gerçek zamanlı analiz eder. CDN'leri, cihaz modellerini (Android, iPhone, Windows) ve sıra dışı trafik patlamalarını anında tespit eder.

## 🚀 Özellikler
- **Canlı Göstergeler:** Toplam Anlık Download/Upload, Aktif İstemci Sayısı ve Bant Genişliği Alarm Eşiği.
- **CDN & Servis Tanıma:** Amazon CloudFront, Google/YouTube, Meta/WhatsApp, Turkcell Superonline, Akamai, Cloudflare, Apple vb. servis tespiti.
- **Cihaz Parmak İzi (Fingerprinting):** TTL ve MAC OUI analiziyle işletim sistemi ve donanım üreticisini algılama.
- **DNS Telemetrisi:** Cihazların en son bağlandığı alan adlarını tek tabloda izleme.
- **Aç/Kapa Anahtarı:** İçindeki enable seçeneği ile dilediğiniz zaman tek tıkla aktif veya pasif edilebilir.

## 📦 Kurulum (Tek Komut)
pfSense SSH konsolunda root olarak çalıştırın:
```sh
curl -sSL https://raw.githubusercontent.com/bysinbin/pfsense-poseainsight/main/scripts/install.sh | sh
```
Kurulum tamamlandığında pfSense WebGUI üzerinde **Status > PoseaInsight** menüsü belirecektir.
