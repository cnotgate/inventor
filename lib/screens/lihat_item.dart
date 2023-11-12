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