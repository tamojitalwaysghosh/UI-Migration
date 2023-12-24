// edit_page.dart
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final String buttonNumber;

  EditPage({required this.buttonNumber});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController labelController = TextEditingController();
  TextEditingController onPressedController = TextEditingController();
  TextEditingController releasedController = TextEditingController();

  bool triggerButtonReleased = false;

  @override
  void initState() {
    super.initState();

    // Initialize text field values
    labelController.text = widget.buttonNumber;
    onPressedController.text = "${widget.buttonNumber}/1";
    releasedController.text = "${widget.buttonNumber}/1";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.buttonNumber}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: labelController,
              decoration: InputDecoration(labelText: "Label"),
            ),
            TextField(
              controller: onPressedController,
              decoration: InputDecoration(labelText: "Button Pressed"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 3),
              child: Text(
                "Button Released",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: triggerButtonReleased,
                  onChanged: (value) {
                    setState(() {
                      triggerButtonReleased = value ?? false;
                    });
                  },
                ),
                Text("Trigger Button Released"),
              ],
            ),
            TextField(
              controller: releasedController,
              enabled: triggerButtonReleased,
              decoration: InputDecoration(
                labelText: "Button Released Text",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement SAVE functionality
                  },
                  child: Text("SAVE"),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Close the edit page on cancel
                  },
                  child: Text("CANCEL"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
