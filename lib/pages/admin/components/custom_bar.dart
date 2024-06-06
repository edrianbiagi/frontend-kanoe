import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/constants.dart';
import 'package:kanoevaa/pages/login.dart';

class CustomBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CustomBar> createState() => _CustomBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomBarState extends State<CustomBar> {
  late final FlutterSecureStorage _secureStorage;

  @override
  void initState() {
    super.initState();
    _secureStorage = FlutterSecureStorage();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_left,
          color: kWhiteColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 16,
          color: kWhiteColor,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: kWhiteColor,
            ),
            onPressed: () async {
              if (_secureStorage != null) {
                await _secureStorage.delete(key: 'token');
                await _secureStorage.delete(key: 'aluno');

                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              }
            },
          ),
        ),
      ],
      backgroundColor: kSecondaryColor,
    );
  }
}
