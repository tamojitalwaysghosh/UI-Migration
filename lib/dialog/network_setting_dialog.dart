// network_settings_dialog.dart
import 'package:flutter/material.dart';

class NetworkSettingsDialog extends StatefulWidget {
  @override
  _NetworkSettingsDialogState createState() => _NetworkSettingsDialogState();
}

class _NetworkSettingsDialogState extends State<NetworkSettingsDialog> {
  bool isListening = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Network Settings"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSection("Outgoing", [
              _buildTextField("IP Address", "127.0.0.1"),
              _buildTextField("Port", "8000"),
              _buildTextField("Start Path", "/"),
            ]),
            _buildSection("Incoming", [
              _buildCheckboxWithText("Listen for incoming messages"),
              _buildTextField("IP Address", "192.168.0.103", enabled: false),
              _buildTextField("Port", "8090"),
            ]),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Add logic to handle SAVE button
            // For example, you can retrieve the entered values and save them
            // to use in your application.
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ...fields,
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildTextField(String label, String defaultValue,
      {bool enabled = true}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
      ),
      keyboardType: TextInputType.number,
      enabled: enabled,
      controller: TextEditingController(text: defaultValue),
    );
  }

  Widget _buildCheckboxWithText(String text) {
    return CheckboxListTile(
      title: Text(text),
      controlAffinity: ListTileControlAffinity.leading,
      value: isListening,
      onChanged: (value) {
        setState(() {
          isListening = value ?? false;
        });
      },
    );
  }
}
