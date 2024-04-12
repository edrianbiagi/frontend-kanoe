import 'package:auth_screen/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:auth_screen/constants.dart';
import 'package:auth_screen/widgets/background_image.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatelessWidget {
  final AuthService authService;

  Login({required this.authService});

  @override
  Widget build(BuildContext context) {
    String cpf = "";
    String password = "";

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: backgroundImage(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(66, 221, 219, 219),
                    borderRadius:
                        BorderRadius.circular(20), // Define o raio dos cantos
                  ),
                  child: TextField(
                    onChanged: (value) => cpf = value,
                    decoration: InputDecoration(
                      hintText: "CPF",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: SvgPicture.asset(
                        "assets/icons/Iconemail.svg",
                        color: Color.fromARGB(66, 14, 79, 220),
                        width: 15,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(66, 221, 219, 219),
                    borderRadius:
                        BorderRadius.circular(20), // Define o raio dos cantos
                  ),
                  child: TextField(
                    onChanged: (value) => password = value,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Senha",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: SvgPicture.asset(
                        "assets/icons/Iconlock.svg",
                        color: Color.fromARGB(66, 14, 79, 220),
                        width: 15,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "SIGN IN\n",
                            ),
                            TextSpan(
                              text: "Esqueceu a senha?",
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: kSecondaryColor),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic>? userData =
                              await authService.signIn(cpf, password);
                          if (userData != null) {
                            // login bem sucedido
                          } else {
                            // login falhou
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/icons/Goarrow.svg",
                          color: Color.fromARGB(66, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
