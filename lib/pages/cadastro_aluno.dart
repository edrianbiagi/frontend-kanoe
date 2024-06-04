import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/pages/login.dart';
import 'package:kanoevaa/repositories/cadastro_aluno_repository.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroAluno extends StatefulWidget {
  @override
  _CadastroAlunoState createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  final passwordController = TextEditingController();
  final cpfController = TextEditingController();
  final dtNascimentoController = TextEditingController();
  final profissaoController = TextEditingController();
  final dtInicioController = TextEditingController();
  final numEmergenciaController = TextEditingController();
  final nomeEmergenciaController = TextEditingController();
  final obsPatologicaController = TextEditingController();
  final planoSaudeController = TextEditingController();
  final tratamentoMedicoController = TextEditingController();
  final obsGeraisController = TextEditingController();
  final sexoController = TextEditingController();
  final valorMensalidadeController = TextEditingController();
  final diaVencimentoController = TextEditingController();
  final mensalidadesEmAtrasoController = TextEditingController();
  final termoResponsabilidadeController = TextEditingController();

  String? _nameError = '';
  String? _emailError = '';
  String? _telefoneError = '';
  String? _passwordError = '';
  String? _cpfError = '';
  String? _dtNascimentoError = '';
  String? _profissaoError = '';
  String? _dtInicioError = '';
  String? _numEmergenciaError = '';
  String? _nomeEmergenciaError = '';
  String? _obsPatologicaError = '';
  String? _planoSaudeError = '';
  String? _tratamentoMedicoError = '';
  String? _sexoError = '';
  String? _valorMensalidadeError = '';
  String? _termoResponsabilidadeError = '';

  String dropdownPatologicasValue = 'Não';
  bool mostrarCampoDescricao = false;

  String dropdownPlanoSaudeValue = 'Não';
  bool mostrarCampoPlanoSaude = false;

  String dropdownTratamentoValue = 'Não';
  bool mostrarCampoTratamento = false;

  var telefoneMaskFormatter = MaskTextInputFormatter(
    mask: "(##) #####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cadastroAlunoRepository =
      CadastroAlunoRepository(armazenamentoSeguro: FlutterSecureStorage());

  void _validarFormulario() {
    setState(() {
      _nameError =
          nomeController.text.isEmpty ? 'Campo "Nome" obrigatório' : null;
      _emailError =
          emailController.text.isEmpty ? 'Por favor, preencha o email' : null;
      _telefoneError = telefoneController.text.isEmpty
          ? 'Campo "Telefone" obrigatório'
          : null;
      _passwordError =
          passwordController.text.isEmpty ? 'Campo "Senha" obrigatório' : null;
      _cpfError = cpfController.text.isEmpty ? 'Campo "CPF" obrigatório' : null;
      _dtNascimentoError = dtNascimentoController.text.isEmpty
          ? 'Campo "Data de Nascimento" obrigatório'
          : null;
      _profissaoError = profissaoController.text.isEmpty
          ? 'Campo "Profissão" obrigatório'
          : null;
      _dtInicioError = dtInicioController.text.isEmpty
          ? 'Campo "Data de Início na Kanoê" obrigatório'
          : null;
      _numEmergenciaError = numEmergenciaController.text.isEmpty
          ? 'Campo "Número de Emergência" obrigatório'
          : null;
      _nomeEmergenciaError = nomeEmergenciaController.text.isEmpty
          ? 'Campo "Contato de Emergência" obrigatório'
          : null;
      _obsPatologicaError =
          mostrarCampoDescricao && obsPatologicaController.text.isEmpty
              ? 'Campo "Observações Patológicas" obrigatório'
              : null;
      _planoSaudeError =
          mostrarCampoPlanoSaude && planoSaudeController.text.isEmpty
              ? 'Campo "Plano de Saúde" obrigatório'
              : null;
      _tratamentoMedicoError =
          mostrarCampoTratamento && tratamentoMedicoController.text.isEmpty
              ? 'Campo "Descrição do Tratamento de Saúde" obrigatório'
              : null;

      _sexoError =
          sexoController.text.isEmpty ? 'Campo "Sexo" obrigatório' : null;
      _valorMensalidadeError = valorMensalidadeController.text.isEmpty
          ? 'Campo "Valor da Mensalidade" obrigatório'
          : null;

      _termoResponsabilidadeError = termoResponsabilidadeController.text.isEmpty
          ? 'Campo "Termo de Responsabilidade" obrigatório'
          : null;
    });

    if (_nameError != null ||
        _emailError != null ||
        _telefoneError != null ||
        _passwordError != null ||
        _cpfError != null ||
        _dtNascimentoError != null ||
        _profissaoError != null ||
        _dtInicioError != null ||
        _numEmergenciaError != null ||
        _nomeEmergenciaError != null ||
        _obsPatologicaError != null ||
        _planoSaudeError != null ||
        _tratamentoMedicoError != null ||
        _sexoError != null ||
        _valorMensalidadeError != null ||
        _termoResponsabilidadeError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Por favor, preencha todos os campos obrigatórios"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Aluno',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey, // Chave global associada ao formulário
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  errorText: _nameError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha o nome';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha o email';
                  }
                  if (!RegExp(r"[a-zA-Z0-9.+_-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                      .hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  errorText: _telefoneError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha o telefone';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  errorText: _cpfError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha o cpf';
                  }

                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Cadastre sua senha',
                  errorText: _passwordError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha a senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: dtNascimentoController,
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  errorText: _dtNascimentoError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha a data de nascimento';
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: profissaoController,
                decoration: InputDecoration(
                  labelText: 'Profissão',
                  errorText: _profissaoError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha a profissão';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: dtInicioController,
                decoration: InputDecoration(
                  labelText: 'Data de início na Kanoê',
                  errorText: _dtInicioError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha a data de início';
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: numEmergenciaController,
                inputFormatters: [telefoneMaskFormatter],
                decoration: InputDecoration(
                  labelText: 'Número de Emergência',
                  errorText: _numEmergenciaError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha o número de emergência';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nomeEmergenciaController,
                decoration: InputDecoration(
                  labelText: 'Contato de Emergência',
                  errorText: _nomeEmergenciaError,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, preencha o contato de emergência';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Possui observações patológicas?',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        value: dropdownPatologicasValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownPatologicasValue = newValue!;
                            mostrarCampoDescricao = newValue == 'Sim';
                          });
                        },
                        items: <String>['Sim', 'Não']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const Text('Ex: Alergia, Doenças cardíacas, Diabetes, etc.'),
              if (mostrarCampoDescricao) ...[
                SizedBox(height: 20),
                Text(
                  'Informe as observações patológicas:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: obsPatologicaController,
                  decoration: InputDecoration(
                    labelText: 'Observações Patológicas',
                    errorText: _obsPatologicaError,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, preencha as observações patológicas';
                    }
                    return null;
                  },
                ),
              ],
              SizedBox(height: 10),
              Divider(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Possui plano de saúde?',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        value: dropdownPlanoSaudeValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownPlanoSaudeValue = newValue!;
                            mostrarCampoPlanoSaude = newValue == 'Sim';
                          });
                        },
                        items: <String>['Sim', 'Não']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              if (mostrarCampoPlanoSaude) ...[
                SizedBox(height: 20),
                Text(
                  'Informe o plano de saúde:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: planoSaudeController,
                  decoration: InputDecoration(
                    labelText: 'Plano de Saúde',
                    errorText: _planoSaudeError,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, preencha o plano de saúde';
                    }
                    return null;
                  },
                ),
              ],
              SizedBox(height: 10),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Está em tratamento de saúde?',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        value: dropdownTratamentoValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownTratamentoValue = newValue!;
                            mostrarCampoTratamento = newValue == 'Sim';
                          });
                        },
                        items: <String>['Sim', 'Não']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              if (mostrarCampoTratamento) ...[
                SizedBox(height: 20),
                Text(
                  'Informe qual o tratamento de saúde:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: tratamentoMedicoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição do tratamento de saúde',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  ),
                ),
                SizedBox(height: 20),
              ],
              SizedBox(height: 10),
              Divider(),
              TextFormField(
                controller: obsGeraisController,
                decoration: InputDecoration(
                  labelText: 'Observações Gerais',
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      final nome = nomeController.text;
                      final email = emailController.text;
                      final telefone = telefoneController.text;
                      final password = passwordController.text;
                      final cpf = cpfController.text;
                      final dtNascimento = dtNascimentoController.text;
                      final profissao = profissaoController.text;
                      final dtInicio = dtInicioController.text;
                      final numEmergencia = numEmergenciaController.text;
                      final nomeEmergencia = nomeEmergenciaController.text;

                      final obsPatologica = mostrarCampoDescricao
                          ? obsPatologicaController.text
                          : "Não";

                      final tratamentoMedico = mostrarCampoTratamento
                          ? tratamentoMedicoController.text
                          : "Não";
                      final planoSaude = mostrarCampoPlanoSaude
                          ? planoSaudeController.text
                          : "Não";
                      final obsGerais = obsGeraisController.text;
                      final sexo = sexoController.text;
                      final valorMensalidade =
                          double.tryParse(valorMensalidadeController.text) ??
                              0.0;
                      final diaVencimento =
                          int.tryParse(diaVencimentoController.text) ?? 0;
                      final mensalidadesEmAtraso =
                          int.tryParse(mensalidadesEmAtrasoController.text) ??
                              0;
                      final termoResponsabilidade = mostrarCampoDescricao;

                      final response = await cadastroAlunoRepository.cadAluno(
                        context: context,
                        nome: nome,
                        email: email,
                        telefone: telefone,
                        password: password,
                        cpf: cpf,
                        dtNascimento: dtNascimento,
                        profissao: profissao,
                        dtInicio: dtInicio,
                        numEmergencia: numEmergencia,
                        nomeEmergencia: nomeEmergencia,
                        obsPatologica: obsPatologica,
                        planoSaude: planoSaude,
                        tratamentoMedico: tratamentoMedico,
                        obsGerais: obsGerais,
                        sexo: sexo,
                        valorMensalidade: valorMensalidade,
                        diaVencimento: diaVencimento,
                        mensalidadesEmAtraso: mensalidadesEmAtraso,
                        termoResponsabilidade: termoResponsabilidade,
                      );

                      setState(() {
                        isLoading = false;
                      });

                      if (response['statusCode'] == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Cadastro realizado com sucesso!'),
                            backgroundColor:
                                const Color.fromARGB(255, 42, 77, 44),
                          ),
                        );
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      } else {
                        String errorMessage = 'Erro ao realizar o cadastro.';
                        if (response['errorMessage'] != null) {
                          // Tentando extrair mensagem detalhada do servidor
                          if (response['errorMessage'] is String) {
                            errorMessage = response['errorMessage'];
                          } else if (response['errorMessage'] is Map &&
                              response['errorMessage']['message'] != null) {
                            errorMessage = response['errorMessage']['message'];
                          }
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(errorMessage),
                        ));
                      }
                    } else {
                      _validarFormulario();
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Container(
                          width: double.infinity,
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
