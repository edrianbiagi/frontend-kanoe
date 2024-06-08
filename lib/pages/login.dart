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

  bool cpfErrorVisible = false;
  bool passwordErrorVisible = false;

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // Altura da imagem de fundo
              child: backgroundImage(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 380,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(66, 221, 219, 219),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: cpfController,
                    onChanged: (value) {
                      setState(() {
                        cpf = value;
                        cpfErrorVisible = false;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "CPF",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: SvgPicture.asset(
                        "assets/icons/Iconemail.svg",
                        color: Color.fromARGB(66, 14, 79, 220),
                        width: 15,
                      ),
                      border: InputBorder.none,
                      errorText: cpfErrorVisible ? 'CPF obrigatório' : null,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 380,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(66, 221, 219, 219),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: passwordController,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                        passwordErrorVisible = value.isEmpty;
                      });
                    },
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
                      errorText:
                          passwordErrorVisible ? 'Senha obrigatória' : null,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 380, // Define a largura fixa para o botão
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (cpfController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          setState(() {
                            cpfErrorVisible = cpfController.text.isEmpty;
                            passwordErrorVisible =
                                passwordController.text.isEmpty;
                          });
                          return;
                        }
                        Map<String, dynamic>? result =
                            await authRepository.login(context,
                                cpfController.text, passwordController.text);
                        if (result != null && result['success']) {
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
                              MaterialPageRoute(builder: (context) => Turmas()),
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
                      icon: Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(380, 50),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(114, 114, 14, 1)),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 380, // Define a largura fixa para o botão
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
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(380, 50),
                        ),
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
          ],
        ),
      ),
    );
  }
}
