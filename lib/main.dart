import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> titles = [];
  List<String> descriptions = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int selectedItemIndex = -1;

  TextEditingController editTitleController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [Icon(Icons.search, color: Colors.cyan)],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Add Description',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addItem();
            },
            child: Text('Add'),
          ),
          SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.grey,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.redAccent,
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      title: Text(titles[index]),
                      subtitle: Text(descriptions[index]),
                      onLongPress: () {
                        _showEditDeleteOptions(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addItem() {
    setState(() {
      titles.add(titleController.text);
      descriptions.add(descriptionController.text);
      titleController.clear();
      descriptionController.clear();
    });
  }

  void _showEditDeleteOptions(int index) {
    selectedItemIndex = index;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alart"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showEditDialog();
              },
              child: Text("Edit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteItem();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog() {
    editTitleController.text = titles[selectedItemIndex];
    editDescriptionController.text = descriptions[selectedItemIndex];

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: editTitleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: editDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  _saveEdits();
                  Navigator.pop(context);
                },
                child: Text("Edit Done"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveEdits() {
    setState(() {
      titles[selectedItemIndex] = editTitleController.text;
      descriptions[selectedItemIndex] = editDescriptionController.text;
    });
  }

  void _deleteItem() {
    setState(() {
      titles.removeAt(selectedItemIndex);
      descriptions.removeAt(selectedItemIndex);
    });
  }
}