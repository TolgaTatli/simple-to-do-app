// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "TodoCreate",
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  const Iskele({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(249, 0, 0, 0),
          titleTextStyle: TextStyle(
            fontSize: 41.4,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          title: const Text(
            "Add an Do",
          ), // Başlık "TodoCreate" olan AppBar
          centerTitle: true, // Başlığı ortalamak için
          toolbarHeight: 80.0,
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: const [Colors.black26, Colors.white])),
          child: const AnaEkran(),
        ));
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController baslikController = TextEditingController();
  TextEditingController metinController = TextEditingController();
  List<Map<String, String>> todoListesi = [];

  void elemanEkle() {
    if (baslikController.text.trim().isEmpty ||
        metinController.text.trim().isEmpty) {
      // Boş başlık veya metin girişi yapılırsa uyarı ver
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Title and text fields cannot be left blank."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      setState(() {
        todoListesi.add({
          'baslik': baslikController.text,
          'metin': metinController.text,
        });
        baslikController.clear();
        metinController.clear();
      });
    }
  }

  void elemanSil(int index) {
    setState(() {
      todoListesi.removeAt(index);
      baslikController.clear();
      metinController.clear();
    });
  }

  void elemaniDuzenle(int index) {
    baslikController.text = todoListesi[index]['baslik']!;
    metinController.text = todoListesi[index]['metin']!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Set Task"),
          content: SingleChildScrollView(
            // Kaydırma çubuğu ekleyerek tüm metinleri göster
            child: Column(
              children: [
                TextField(
                  controller: baslikController,
                  decoration: InputDecoration(
                    labelText: "Set the title",
                  ),
                ),
                TextField(
                  controller: metinController,
                  maxLines: null, // Metin alanını genişlet
                  decoration: InputDecoration(
                    labelText: "Set the task",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                baslikController.clear();
                metinController.clear();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  todoListesi[index]['baslik'] = baslikController.text;
                  todoListesi[index]['metin'] = metinController.text;

                  baslikController.clear();
                  metinController.clear();
                });
                Navigator.pop(context);
              },
              child: const Text("Apply"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: double.infinity, // Ekranın genişliği kadar geniş bir container
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Başlık ekranın ortasında
            Text(
              "# Your Tasks",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Başlık girişi için TextField
            TextField(
              controller: baslikController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(height: 8.0),
            // Metin girişi için TextField
            TextField(
              controller: metinController,
              decoration: InputDecoration(
                labelText: "Enter your task....",
              ),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: ListView.builder(
                itemCount: todoListesi.length,
                itemBuilder: (context, indexNum) => Card(
                  child: ListTile(
                    title: Text(
                      todoListesi[indexNum]['baslik']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(todoListesi[indexNum]['metin']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            elemaniDuzenle(indexNum);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            elemanSil(indexNum);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Ekle butonu
            ElevatedButton(
              onPressed: elemanEkle,
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                      50.0), // Ekran genişliğinin yüzde 70'i
                  backgroundColor: Colors.black),
              child: Text(
                "Add this task",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
