import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kanoevaa/pages/admin/home.dart';
import 'package:kanoevaa/pages/cadastro_aluno.dart';
import 'package:kanoevaa/pages/alunos/turma.dart';
import 'package:kanoevaa/repositories/auth_repository.dart';
import 'package:kanoevaa/widgets/background_image.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthRepository authRepository = AuthRepository();
  late FlutterSecureStorage secureStorage;

  final TextEditingController cpfController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepository();
    secureStorage = FlutterSecureStorage();
  }

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
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(66, 221, 219, 219),
                    borderRadius: BorderRadius.circular(20),
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(66, 221, 219, 219),
                    borderRadius: BorderRadius.circular(20),
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
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic>? result = await authRepository
                              .login(context, cpf, password);
                          if (result != null && result['success']) {
                            // Obtendo os papéis do usuário salvos no secureStorage
                            String? roles =
                                await secureStorage.read(key: 'roles');

                            if (roles!.contains('ROLE_ADMIN')) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InicialPageAdmin()),
                              );
                            } else if (roles.contains('ROLE_ALUNO')) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Turmas()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Papel do usuário não reconhecido'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(result!['message']),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: SvgPicture.asset(
                          "assets/icons/Goarrow.svg",
                          color: Color.fromARGB(66, 7, 29, 79),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CadastroAluno(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Criar Conta",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
