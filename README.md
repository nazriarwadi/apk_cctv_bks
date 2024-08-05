# Aplikasi Mobile CCTV Bengkalis

## Deskripsi

Aplikasi Mobile CCTV Bengkalis menyediakan streaming video real-time dari berbagai kamera CCTV yang terletak di sekitar Bengkalis. Aplikasi ini memungkinkan pengguna untuk melihat beberapa tampilan kamera secara bersamaan dan beralih antara tampilan kamera dengan mudah. Aplikasi ini juga menyediakan antarmuka pengguna yang intuitif untuk menangani masalah konektivitas dan memastikan pemutaran video yang lancar.

## Fitur

- **Streaming Video Real-Time**: Menonton streaming video langsung dari kamera CCTV.
- **Tampilan Multi-Kamera**: Melihat beberapa tampilan kamera dalam satu layar.
- **Penanganan Orientasi**: Mendukung orientasi potret dan lanskap, dengan perubahan orientasi otomatis.
- **Penanganan Konektivitas**: Menampilkan pesan yang sesuai dan opsi ketika tidak ada koneksi internet.
- **Penanganan Kesalahan**: Menampilkan pesan ketika video tidak dapat ditampilkan karena masalah atau pemeliharaan.
- **Tarik untuk Menyegarkan**: Memungkinkan pengguna untuk menyegarkan daftar video dengan menarik layar ke bawah.

## Instalasi

1. **Clone repositori**:

    ```bash
    git clone https://github.com/usernameanda/cctv-bengkalis-app.git
    ```

2. **Masuk ke direktori proyek**:

    ```bash
    cd cctv-bengkalis-app
    ```

3. **Instal dependensi**:

    ```bash
    flutter pub get
    ```

## Penggunaan

1. **Jalankan aplikasi**:

    ```bash
    flutter run
    ```

2. **Build APK**:

    ```bash
    flutter build apk --release
    ```

## Struktur Proyek

lib/
|-- api/
| |-- models_video.dart
| |-- video_service.dart
|-- widgets/
| |-- footer.dart
| |-- no_internet_widget.dart
| |-- status_message_widget.dart
| |-- video_card_widget.dart
| |-- video_info_widget.dart
| |-- video_player_widget.dart
| |-- navigation_buttons_widget.dart
|-- pages/
| |-- video_list_page.dart
| |-- video_detail_page.dart
| |-- multi_camera_view_page.dart
main.dart

## Dependensi

- `flutter_boxicons`
- `cached_network_image`
- `loading_animation_widget`
- `connectivity_plus`
- `youtube_player_flutter`
- `flutter_html`

## Kontribusi

1. Fork repositori.
2. Buat branch baru (`git checkout -b feature-branch`).
3. Lakukan perubahan.
4. Commit perubahan (`git commit -m 'Tambah fitur tertentu'`).
5. Push ke branch (`git push origin feature-branch`).
6. Buka pull request.

## Penghargaan

- Terima kasih kepada semua pengembang dan kontributor yang telah membuat proyek ini mungkin.
- Terima kasih khusus kepada komunitas Flutter yang telah menyediakan paket dan dukungan yang luar biasa.

---

Jangan ragu untuk berkontribusi dan memberikan masukan!
