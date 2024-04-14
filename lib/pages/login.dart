import 'package:auth_screen/pages/turma.dart';
import 'package:auth_screen/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:auth_screen/constants.dart';
import 'package:auth_screen/widgets/background_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatelessWidget {
  final AuthService authService;

  Login({required this.authService});

  final TextEditingController cpfController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    controller: cpfController,
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
                    keyboardType: TextInputType
                        .number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter
                          .digitsOnly, 
                    ],
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
                    controller: passwordController,
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
                              await authService.signIn(context, cpf, password);

                          cpfController.clear();
                          passwordController.clear();
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
