# Inventor

# Tugas 8

## Checklists

- [x] Membuat minimal satu halaman baru pada aplikasi, yaitu halaman formulir tambah item baru dengan ketentuan sebagai berikut:
    - [x] Memakai minimal tiga elemen input, yaitu name, amount, description. Tambahkan elemen input sesuai dengan model pada aplikasi tugas Django yang telah kamu buat.
    - [x] Memiliki sebuah tombol Save.
    - [x] Setiap elemen input di formulir juga harus divalidasi dengan ketentuan sebagai berikut:
        - [x] Setiap elemen input tidak boleh kosong.
        - [x]  Setiap elemen input harus berisi data dengan tipe data atribut modelnya.
- [x] Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama.
- [x] Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman formulir tambah item baru.
- [x] Membuat sebuah drawer pada aplikasi dengan ketentuan sebagai berikut:
    - [x] Drawer minimal memiliki dua buah opsi, yaitu Halaman Utama dan Tambah Item.
    - [x] Ketika memiih opsi Halaman Utama, maka aplikasi akan mengarahkan pengguna ke halaman utama.
    - [x] Ketika memiih opsi (Tambah Item), maka aplikasi akan mengarahkan pengguna ke halaman form tambah item baru.
- [x] Menjawab beberapa pertanyaan berikut pada README.md pada root folder (silakan modifikasi README.md yang telah kamu buat sebelumnya; tambahkan subjudul untuk setiap tugas).
    - [x] Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!
    - [x] Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!
    - [x] Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
    - [x] Bagaimana penerapan clean architecture pada aplikasi Flutter?
    - [x] Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)
- [x] Melakukan add-commit-push ke GitHub.

## Membuat halaman `TambahItem`

- Membuat folder `screens` di dalam folder `lib`

- Membuat folder `widgets` di dalam folder `lib`

- Membuat file `generic_button.dart` di dalam folder `widgets` lalu isi dengan kode berikut

```dart
import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  const GenericButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.onLongPress,
      this.height,
      this.width,
      this.padding});

  final String text;
  final double? height;
  final double? width;
  final double? padding;
  final void Function() onPressed;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Set a uniform padding around the button
      padding: EdgeInsets.all(padding ?? 8),
      child: SizedBox(
        // SizedBox for determining button size
        height: height ?? 50,
        width: width ?? 120,
        child: ElevatedButton(
          onPressed: onPressed,
          onLongPress: onLongPress ?? () {},
          child: Text(
            text,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
```

- Di dalam folder `screens` buat file `tambah_item.dart` lalu isi `tambah_item.dart` dengan kode berikut

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventor/widgets/generic_button.dart';

class TambahItem extends StatefulWidget {
  const TambahItem({super.key});

  @override
  State<TambahItem> createState() => _TambahItemState();
}

class _TambahItemState extends State<TambahItem> {
  final _formKey = GlobalKey<FormState>();
  final _rarityList = ['Common', 'Uncommon', 'Rare', 'Very rare', 'Epic', 'Legendary'];
  final _namaController = TextEditingController();
  final _amountController = TextEditingController();
  final _rarityController = TextEditingController();
  final _deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Tambah Item", textAlign: TextAlign.center, style: GoogleFonts.roboto()),
      ),
      body: GestureDetector(
        // Gesture detector to unfocus TextFormField when tapped outside
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          // Set a uniform padding for all descendant widgets
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              child: Form(
            //     Form with key attribute for validation purposes
            key: _formKey,
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          label: Text("Nama"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        })),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text("Amount"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final number = int.tryParse(value!);
                          if (value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          if (number == null) {
                            return 'Hanya boleh bilangan bulat';
                          }
                          return null;
                        })),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: _deskripsiController,
                        minLines: 1,
                        maxLines: null,
                        decoration: const InputDecoration(
                          label: Text("Deskripsi"),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        })),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu(
                      controller: _rarityController,
                      initialSelection: "Common",
                      label: const Text("Rarity"),
                      dropdownMenuEntries: _rarityList.map((val) {
                        return DropdownMenuEntry(value: val, label: val);
                      }).toList()),
                ),
                GenericButton(
                    text: "Save",
                    padding: 15,
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        // If the form is valid, display a popup dialog.
                        _showFormDataDialog(context, _namaController.text, _amountController.text,
                            _deskripsiController.text, _rarityController.value.text);
                      }
                    })
              ],
            ),
          )),
        ),
      ),
    );
  }
}

Future<void> _showFormDataDialog(
    BuildContext context, String nama, String amount, String deskripsi, String rarity) {
  // Builder function to show a popup dialog.
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Data Form"),
          actions: [
            Center(
                child: GenericButton(
                    text: "OK", height: 40, width: 100, onPressed: () => Navigator.pop(context))),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nama: $nama"),
                Text("Amount: $amount"),
                Text("Rarity: $rarity"),
                Text("Deskrpisi: $deskripsi")
              ],
            ),
          ),
        );
      });
}

```



## Routing dari `MyHomePage` ke `TambahItem`

- Tambahkan import berikut pada file `home_page.dart`

```dart
import 'package:inventor/screens/lihat_item.dart';
```

- Pada `MainButton` untuk `Tambah Item` tambahkan atribut fungsi onTap berikut

```dart
Navigator.push(context, MaterialPageRoute(builder: (context) => const TambahItem()));
```

## Memunculkan popup data pada halaman `TambahItem` ketika tombol save ditekan

- Pada file `tambah_item.dart` tambahkan kode berikut

```dart
Future<void> _showFormDataDialog(
    BuildContext context, String nama, String amount, String deskripsi, String rarity) {
    // Builder function to show a popup dialog.
    return showDialog(
        context: context,
        builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("Data Form"),
            actions: [
            Center(
                child: GenericButton(
                    text: "OK", height: 40, width: 100, onPressed: () => Navigator.pop(context))),
            ],
            content: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Nama: $nama"),
                Text("Amount: $amount"),
                Text("Rarity: $rarity"),
                Text("Deskrpisi: $deskripsi")
                ],
            ),
            ),
        );
    });
}
```

- Pada `GenericButton` untuk `save` tambahkan atribut fungsi onPressed berikut

```dart
// Validate returns true if the form is valid, or false otherwise.
if (_formKey.currentState!.validate()) {
    FocusScope.of(context).requestFocus(FocusNode());
    // If the form is valid, display a popup dialog.
    _showFormDataDialog(context, _namaController.text, _amountController.text,
        _deskripsiController.text, _rarityController.value.text);
}
```

## Membuat drawer

- Pada folder `widgets` baut file baru bernama `generic_drawer.dart`, lalu isi dengan kode berikut

```dart
import 'package:flutter/material.dart';
import 'package:inventor/screens/home_page.dart';
import 'package:inventor/screens/lihat_item.dart';
import 'package:inventor/screens/tambah_item.dart';

class GenericDrawer extends StatelessWidget {
  const GenericDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 30),
          InkWell(
            onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
                (Route<dynamic> route) => false),
            child: const ListTile(
              leading: Icon(Icons.home),
              title: Text("Halaman Utama"),
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LihatItem())),
            child: const ListTile(
              leading: Icon(Icons.checklist),
              title: Text("Lihat Item"),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const TambahItem())),
            child: const ListTile(
              leading: Icon(Icons.add),
              title: Text("Tambah Item"),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
```

- Pada `home_page.dart` tambahkan import berikut

```dart
import 'package:inventor/widgets/generic_drawer.dart';
```

- Pada widget `Scaffold` di `home_page.dart` tambahkan atribut `drawer` sebagai berikut

```dart
drawer: const GenericDrawer(),
```

## Pengerjaan bonus

- Di dalam folder `screens` buat file `lihat_item.dart` lalu isi dengan kode berikut

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LihatItem extends StatefulWidget {
  const LihatItem({super.key});

  @override
  State<LihatItem> createState() => _LihatItemState();
}

class _LihatItemState extends State<LihatItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lihat Item", textAlign: TextAlign.center, style: GoogleFonts.roboto()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: listItem
              .map((val) => Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    val.nama,
                                    style:
                                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(val.rarity),
                                  ),
                                ],
                              ),
                              Text(
                                "${val.amount.toString()}x",
                                style: const TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(val.deskripsi),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class Item {
  String nama, deskripsi, rarity;
  int amount;

  Item(this.nama, this.amount, this.deskripsi, this.rarity);
}

List<Item> listItem = [
  Item("Dummy1", 12, "Deskripsi dummy 1", "Rare"),
  Item("Dummy2", 333, "Deskripsi dummy 2", "Uncommon"),
  Item("Dummy3", 1, "Deskripsi dummy 3", "Legendary"),
];
```

- Tambahkan import berikut pada file `home_page.dart`

```dart
import 'package:inventor/screens/lihat_item.dart';
import 'package:inventor/screens/tambah_item.dart';
```

- Pada `MainButton` untuk `Lihat Item` tambahkan atribut fungsi onTap berikut

```dart
Navigator.push(context, MaterialPageRoute(builder: (context) => const LihatItem()));
```

## Perbedaan antara Navigator.push() dan Navigator.pushReplacement()

- Navigator.push() akan menambahkan screen baru di atas screen sekarang pada navigation stack.

    - contoh:
    Navigation Stack saat ini: A -> B -> C (Top of stack)

    Lalu akan dipush D menggunakan Navigator.push()

    Navigation Stack setelah D dipush: A -> B -> C -> D (Top of stack)

- Navigator.pushReplacement() akan *mengganti* screen sekarang dengan screen baru pada navigation stack.

    - contoh:
    Navigation Stack saat ini: A -> B -> C (Top of stack)

    Lalu akan dipush D menggunakan Navigator.pushReplacement()

    Navigation Stack setelah D dipush: A -> B -> D (Top of stack)

## Layout widget pada Flutter

- Align
    Widget yang akan memberikan alignment pada child widgetnya.


- Column
    Berfungsi sebagai wrapper kepada widget-widget childrennya agar widget-widget tersebut tersusun sebagai kolom.

- Row
    Berfungsi sebagai wrapper kepada widget-widget childrennya agar widget-widget tersebut tersusun sebagai baris.

- Center
    Membuat child dari widget ini memiliki layout rata tengah

- Expanded
    Membuat child mengisi penuh space yang ada

- Padding
    Membuat inset pada child widgetnya.

- GridView
    Widget yang memberikan layout grid pada childrennya.

- Table
    Widget yang memberikan layout tabel

## Elemen input pada form yang saya gunakan

- TextFormField
    Digunakan karena memberikan akses kepada validator untuk memvalidasi input dari pengguna

- DropdownMenu
    Digunakan untuk memberikan selection box agar dapat membatasi pilihan pengguna sesuai dengan model pada Django

## Clean architecture pada aplikasi Flutter

- Clean architecture pada Flutter merupakan struktur atau workflow pengembangan perangkat lunak yang menerapkan prinsip separation of concerns. Clean architecture memisahkan layer-layer yang terdapat pada aplikasi agar memudahkan proses pengembangan dan debugging. Clean architecture juga menitikberatkan pada code reusability.

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
