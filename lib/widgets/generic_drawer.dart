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
