import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Components
import 'components/main_button.dart';

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text("Inventor",
              textAlign: TextAlign.center, style: GoogleFonts.roboto()),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, bottom: 10),
              ),
              GridView.count(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
