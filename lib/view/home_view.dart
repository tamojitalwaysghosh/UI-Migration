// view/home_view.dart
import 'package:flutter/material.dart';
import 'package:laser_slides/controller/home_controller.dart';
import 'package:laser_slides/dialog/network_setting_dialog.dart';
import 'package:laser_slides/view/help_view.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text("LaserSlides"),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<HomeController>(context, listen: false)
                  .onHelpButtonPressed();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpScreen()),
              );
            },
            child: Text('HELP'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<HomeController>(context, listen: false)
                  .onNetworkButtonPressed();
              _showNetworkSettingsDialog(context);
            },
            child: Text('NETWORK'),
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit_mode') {
                Provider.of<HomeController>(context, listen: false)
                    .onEditModeButtonPressed();
                _showToast("Switched to Edit Mode", context);
              } else if (value == 'play_mode') {
                Provider.of<HomeController>(context, listen: false)
                    .onPlayModeButtonPressed();
                _showToast("Switched to Play Mode", context);
              }
            },
            itemBuilder: (context) {
              final value = Provider.of<HomeController>(context, listen: false)
                      .model
                      .editMode
                  ? 'play_mode'
                  : 'edit_mode';

              return [
                PopupMenuItem(
                  value: value,
                  child: Text(
                    value == 'edit_mode'
                        ? 'Change to Edit Mode'
                        : 'Change to Play Mode',
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Container(
            color: controller.model.editMode ? Colors.black : Colors.white,
            padding: EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
              ),
              itemCount: controller.model.buttonNames.length,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        controller.onButtonPressed(context, index + 1);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          controller.model.buttonNames[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Helper method to show the network settings dialog
  void _showNetworkSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => NetworkSettingsDialog(),
    );
  }

  // Helper method to show toast messages
  void _showToast(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // Show popup message
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text("State Change"),
    //       content: Text(message),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('OK'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
