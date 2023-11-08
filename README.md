# Inventor

# Tugas 7

## Checklists

- [x] Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya.

- [x] Membuat tiga tombol sederhana dengan ikon dan teks untuk:
    - [x] Melihat daftar item (Lihat Item)
    - [x] Menambah item (Tambah Item)
    - [x] Logout (Logout)
- [x] Memunculkan Snackbar dengan tulisan:
    - [x] "Kamu telah menekan tombol Lihat Item" ketika tombol Lihat Item ditekan.
    - [x] "Kamu telah menekan tombol Tambah Item" ketika tombol Tambah Item ditekan.
    - [x] "Kamu telah menekan tombol Logout" ketika tombol Logout ditekan.
- [x] Menjawab beberapa pertanyaan berikut pada README.md pada root folder.
    - [x] Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
    - [x] Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.
    - [x] Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)
- [x] Melakukan add-commit-push ke GitHub.

### Prerequisites

- Merapikan struktur file proyek flutter sesuai tutorial
- Pada `home_page.dart` pada argumen `body` widget `Scaffold` tambahkan kode berikut

```dart
Padding(
    padding: const EdgeInsets.only(top: 10),
    child: SingleChildScrollView(
        child: Column(
        children: [
            const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10)),
            GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: [
                    // Akan diisi oleh tombol
                ],
            ),
        ],
        ),
    ),
),
```

### Membuat sebuah program Flutter baru dengan tema inventory seperti tugas-tugas sebelumnya

- Menjalankan command berikut

```bash
flutter create inventor 
```

### Membuat tiga tombol yang memunculkan snackbar sesuai ketentuan

- Membuat folder baru bernama `components` pada folder `lib`
- Membuat file baru bernama `main_button.dart` pada folder `components` yang baru saja dibuat
- Isi file tersebut dengan kode berikut

```dart
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key, required this.icon, required this.text, required this.onTap, this.color});

  // This widget is for generating button in the home page

  final IconData? icon;
  final String text;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

> Kode di atas berfungsi sebagai "template" untuk tombol-tombol yang akan ditampilkan.

- Pada `home_page.dart` import `main_button.dart`

```dart
import 'components/main_button.dart';
```

- Pada widget `GridView.count`, isi atribut `children` dengan kode berikut

```dart
[
    MainButton(
        icon: Icons.checklist,
        text: "Lihat Item",
        color: Colors.blueAccent,
        onTap: () {
        ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(
                    "Kamu telah menekan tombol Lihat Item!")));
        }),
    MainButton(
        icon: Icons.add,
        text: "Tambah Item",
        color: Colors.indigo,
        onTap: () {
        ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(
                    "Kamu telah menekan tombol Tambah Item!")));
        }),
    MainButton(
        icon: Icons.logout,
        text: "Logout",
        color: Colors.redAccent,
        onTap: () {
        ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content:
                    Text("Kamu telah menekan tombol Logout!")));
        }),
]
```

> Kode di atas berfungsi untuk menampilkan widget `MainButton` yang telah kita buat sebelumnya pada `main_button.dart`, beserta fungsi yang akan dijalankan ketika tombol ditekan.

### Perbedaan utama stateless dan stateful widget pada Flutter

- Stateless widget

    Stateless merupakan widget yang pada seluruh widget lifecyclenya tidak memiliki perubahan data. Dengan kata lain, widget tersebut tidak memiliki data yang dapat berubah. Sehingga pada keseluruhan lifecycle widget tersebut, widget tidak akan memiliki perubahan tampilan atau data.

- Stateful widget

    Stateful widget merupakan widget yang memiliki data yang dapat berubah (dinamis). Perubahan data tersebut disebabkan oleh interaksi user.

### Penjelasan widget yang digunakan

- MaterialApp

    Merupakan widget yang men-generate Material App yang menggunakan Material Design sebagai dasar UI nya.

- Scaffold

    Merupakan struktur dasar dari Material App. Widget ini memberikan akses untuk membuat drawer dan bottom sheets.

- AppBar

    AppBar merupakan widget yang memberikan layout untuk title, actions, toolbar sesuai dengan Material Design.

- Center

    Berfungsi untuk memberikan layout tengah untuk child widgetnya.

- Column

    Berfungsi sebagai wrapper kepada widget-widget childrennya agar widget-widget tersebut tersusun sebagai kolom.

- Padding

    Berfungsi untuk memberikan padding.

- GridView

    Berfungsi untuk memberikan layout Grid

- MainButton

    Stateless widget custom yang saya buat sendiri untuk menampilkan tombol yang memiliki icon, nama, dan fungsi yang akan dijalankan ketika tombol ditekan.

- Material

    Befungsi untuk menampilkan material dari Material Design. Material ini dapat diwarnai, dibentuk, diberikan shadow, dan di dalamnya dapat diisi oleh widget lain.

- InkWell

    Berfungsi untuk menampilkan area yang interaktif ketika disentuh, menyediakan atribut untuk meberikan fungsi yang akan dijalankan ketika area InkWell ditekan. InkWell juga memberikan animasi ripple ketika area InkWell ditekan.

- Container

    Berfungsi sebagai widget yang membungkus widget yang lain.

- Icon

    Berfungsi untuk menampilkan icon.

- Text

    Berfungsi untuk menampilkan teks.

- TextAlign

    Berfungsi untuk men-define alignment dari text.

- TextStyle

    Berfungsi untuk men-define style dari text.
