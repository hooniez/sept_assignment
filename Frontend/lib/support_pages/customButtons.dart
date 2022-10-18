import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  MenuButton({
    this.buttonWidth = 200,
    this.buttonHeight = 50,
    this.itemColor = Colors.blue,
    this.itemTitleFontSize = 12,
    this.buttonText = '',
    this.fontSize = 20,
    this.buttonIcon = Icons.access_alarm,
    this.iconSize = 40,
    required this.onPressed,
  });

  final Function onPressed;
  final double iconSize;
  final IconData buttonIcon;
  final double fontSize;
  final String buttonText;
  final double buttonWidth;
  final double buttonHeight;
  final Color itemColor;
  final double itemTitleFontSize;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: OutlinedButton.icon(
          label: Align(
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: TextStyle(fontSize: fontSize, color: itemColor),
                textAlign: TextAlign.center,
              )),
          icon: Icon(buttonIcon, size: iconSize, color: itemColor),
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}

class SymptomsButton extends StatelessWidget {
  SymptomsButton({
    this.buttonWidth = 100,
    this.buttonHeight = 50,
    this.itemColor = Colors.blue,
    this.itemTitleFontSize = 12,
    this.buttonText = '',
    this.fontSize = 20,
    this.buttonIcon = Icons.access_alarm,
    this.iconSize = 20,
    required this.onPressed,
  });

  final Function onPressed;
  final double iconSize;
  final IconData buttonIcon;
  final double fontSize;
  final String buttonText;
  final double buttonWidth;
  final double buttonHeight;
  final Color itemColor;
  final double itemTitleFontSize;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
      child: SizedBox(
        width: buttonWidth, // <-- match_parent
        height: buttonHeight, // <-- match-parent
        child: OutlinedButton.icon(
          style: ButtonStyle(),
          label: Align(
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: TextStyle(fontSize: fontSize, color: itemColor),
                textAlign: TextAlign.center,
              )),
          icon: Icon(buttonIcon, size: iconSize, color: itemColor),
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}

class DefaultAppbar extends StatelessWidget with PreferredSizeWidget {

  @override
  DefaultAppbar({
    this.appbarText = '',
    required this.onPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final Function onPressed;
  final String appbarText;

  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 28, 93),
        title: Center(child: Text(appbarText)),
        leading: InkWell(
            onTap: () {
              onPressed();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushNamed("/frontPage");
                },
                child: Icon(
                  Icons.home,
                  size: 26.0,
                ),
              )),
        ]);
  }
}

class AppointmentsButton extends StatelessWidget {
  AppointmentsButton({
    this.buttonWidth = 200,
    this.buttonHeight = 50,
    this.itemColor = Colors.blue,
    this.itemTitleFontSize = 12,
    this.buttonText = '',
    this.fontSize = 20,
    this.buttonIcon = Icons.access_alarm,
    this.iconSize = 20,
    required this.onPressed,
  });

  final Function onPressed;
  final double iconSize;
  final IconData buttonIcon;
  final double fontSize;
  final String buttonText;
  final double buttonWidth;
  final double buttonHeight;
  final Color itemColor;
  final double itemTitleFontSize;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
      child: SizedBox(
        width: buttonWidth, // <-- match_parent
        height: buttonHeight, // <-- match-parent
        child: OutlinedButton.icon(
          style: ButtonStyle(),
          label: Align(
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: TextStyle(fontSize: fontSize, color: itemColor),
                textAlign: TextAlign.center,
              )),
          icon: Icon(buttonIcon, size: iconSize, color: itemColor),
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}