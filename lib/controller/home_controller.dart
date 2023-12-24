// controller/home_controller.dart
import 'package:flutter/material.dart';
import 'package:laser_slides/model/home_model.dart';
import 'package:laser_slides/view/edit_page.dart';

class HomeController extends ChangeNotifier {
  final HomeModel model = HomeModel();

  void onHelpButtonPressed() {
    // Business logic for help button
  }

  void onNetworkButtonPressed() {
    // Business logic for network button
  }

  void onEditModeButtonPressed() {
    model.editMode = !model.editMode;
    notifyListeners();
  }

  void onPlayModeButtonPressed() {
    // Add your logic for handling play mode button pressed
    // For example, you can set the editMode to false
    model.editMode = false;
    notifyListeners();
  }

  void onButtonPressed(BuildContext context, int buttonIndex) {
    // Calculate the corresponding button number considering the skip pattern
    int buttonNumber = buttonIndex;

    // Adjust for skipped buttons
    if (buttonNumber >= 4) {
      buttonNumber++; // Skip btn4
    }
    if (buttonNumber >= 8) {
      buttonNumber++; // Skip btn8
    }
    if (buttonNumber >= 12) {
      buttonNumber++; // Skip btn12
    }

    if (model.editMode) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPage(buttonNumber: "btn$buttonNumber"),
        ),
      );
    } else {
      // Handle button press in play mode
      // Show a popup to inform the user to switch to edit mode
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Switch to Edit Mode'),
          content: Text('To change button settings, switch to Edit Mode.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
