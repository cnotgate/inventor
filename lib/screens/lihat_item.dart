import 'dart:convert';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:inventor/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'detail_item.dart';

class LihatItem extends StatefulWidget {
  const LihatItem({super.key});

  @override
  State<LihatItem> createState() => _LihatItemState();
}

class _LihatItemState extends State<LihatItem> {
  Future<List<Item>> fetchItem(CookieRequest request) async {
    var url = Uri.parse('http://10.0.2.2:8000/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Item> listItem = [];
    for (var d in data) {
      if (d != null) {
        listItem.add(Item.fromJson(d));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lihat Item", textAlign: TextAlign.center, style: GoogleFonts.roboto()),
      ),
      body: FutureBuilder(
        future: fetchItem(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada data produk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    return Card(
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailItem(data: snapshot.data![index].fields)));
                        },
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
                                        "${snapshot.data![index].fields.name}",
                                        style: const TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${snapshot.data![index].fields.amount.toString()}x",
                                    style: const TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("${snapshot.data![index].fields.description}"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }
        },
      ),
    );
  }
}
