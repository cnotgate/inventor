import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventor/screens/lihat_item.dart';
import 'package:inventor/screens/tambah_item.dart';
import 'package:inventor/widgets/generic_drawer.dart';
import 'package:inventor/widgets/main_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of the app.

  // This class is the configuration for the state.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Inventor", textAlign: TextAlign.center, style: GoogleFonts.roboto()),
        centerTitle: true,
      ),
      drawer: const GenericDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          // To make the screen scrollable (if the widgets inside overflows)
          child: Column(
            children: [
              GridView.count(
                // To make a grid layout, with fixed number of tiles in the cross axis
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: [
                  MainButton(
                      icon: Icons.checklist,
                      text: "Lihat Item",
                      color: Colors.blueAccent,
                      number: 1,
                      onTap: () {
                        // Pushes LihatItem to the navigation stack when button is clicked
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const LihatItem()));
                      }),
                  MainButton(
                      icon: Icons.add,
                      text: "Tambah Item",
                      color: Colors.indigo,
                      number: 2,
                      onTap: () {
                        // Pushes AddItem to the navigation stack when button is clicked
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const TambahItem()));
                      }),
                  MainButton(
                      icon: Icons.logout,
                      text: "Logout",
                      color: Colors.redAccent,
                      number: 3,
                      onTap: () {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                              const SnackBar(content: Text("Kamu telah menekan tombol Logout!")));
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
