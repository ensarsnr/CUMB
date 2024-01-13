import 'package:cumb/constants/texts/constant_texts.dart';
import 'package:cumb/model/items_model.dart';
import 'package:cumb/model/words_model.dart';
import 'package:cumb/widgets/buttons/button_widget.dart';
import 'package:cumb/widgets/texts/button_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OwnDetails extends StatefulWidget {
  final String title;

  const OwnDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<OwnDetails> createState() => _OwnDetailsState();
}

class _OwnDetailsState extends State<OwnDetails> {
  late Box<ItemModel> itemBox;
  late Box<WordsModel> wordsBox;

  @override
  void initState() {
    super.initState();
    openItemBox();
    openWordsBox();
  }

  void openItemBox() async {
    // itemBox'u açma işlemi, daha önce açılmadıysa
    if (!Hive.isBoxOpen("itemBox")) {
      await Hive.openBox<ItemModel>("itemBox");
    }
    // itemBox'ı referans al
    itemBox = Hive.box<ItemModel>("itemBox");
  }

  void deleteWord(int index) async {
    if (index >= 0 && index < wordsBox.length) {
      // wordsBox'dan ilgili WordsModel'ı al
      WordsModel? deletedWordsModel = wordsBox.getAt(index);

      // Eğer WordsModel bulunduysa silme işlemini gerçekleştir
      if (deletedWordsModel != null) {
        wordsBox.deleteAt(wordsBox.length - index - 1);
        setState(() {});
      }
    }
  }

  void openWordsBox() async {
    // wordsBox'ı açma işlemi, daha önce açılmadıysa
    if (!Hive.isBoxOpen("wordsBox")) {
      await Hive.openBox<WordsModel>("wordsBox");
    }
    // wordsBox'ı referans al
    wordsBox = Hive.box<WordsModel>("wordsBox");
  }

  List<WordsModel?> getWordsForItem(int itemId) {
    // Seçilen öğe için wordsBox'tan ilgili WordsModel'ları al
    return wordsBox.values
        .where((wordsModel) => wordsModel.itemId == itemId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    ItemModel? selectedItem;
    try {
      // widget.title ile eşleşen ItemModel'ı seç
      selectedItem =
          itemBox.values.firstWhere((item) => item.title == widget.title);
    } catch (e) {
      // Eğer seçilen öğe yoksa selectedItem'yi null olarak ayarla
      selectedItem = null;
    }

    if (selectedItem != null) {
      // Seçilen öğenin ID'si ile ilişkili WordsModel'ları al
      List<WordsModel?> wordsForItem = getWordsForItem(selectedItem.hashCode);
      return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: wordsForItem.length,
          itemBuilder: (context, index) {
            // wordsForItem[index] elemanını al
            WordsModel? currentWordsModel = wordsForItem[index];

            return ListTile(
              title: Text("Kelime: ${currentWordsModel?.words[0] ?? ''}"),
              subtitle: Text("Anlamı: ${currentWordsModel?.words[1] ?? ''}"),
              trailing: IconButton(
                onPressed: () {
                  deleteWord(index);
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                String firstWord = "";
                String secondWord = "";

                return AlertDialog(
                  title: const Text("Kelime Ekle"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          firstWord = value;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: OwnWordDialog.word,
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          secondWord = value;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: OwnWordDialog.word2,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ButtonWT(
                      onPressed: () {
                        if (firstWord.isNotEmpty && secondWord.isNotEmpty) {
                          int itemId = selectedItem.hashCode;
                          WordsModel newWordsModel =
                              WordsModel([firstWord, secondWord], itemId);
                          wordsBox.add(newWordsModel);
                          Navigator.pop(context);
                        }
                      },
                      height: screenHeight * 0.08,
                      width: screenWidth,
                      backgroundColor: Colors.red,
                      child: ButtonText(
                        text: "Tamamla",
                        fontSize: screenWidth * 0.05,
                      ),
                    )
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          color: Colors.cyan.shade400,
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.print,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.people,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("Item not found"),
        ),
      );
    }
  }
}
