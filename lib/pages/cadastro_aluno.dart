import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kanoevaa/repositories/cadastro_aluno_repository.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroAluno extends StatefulWidget {
  @override
  _CadastroAlunoState createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
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
  final tratamentoMedicoController = TextEditingController();
  final obsGeraisController = TextEditingController();
  final sexoController = TextEditingController();
  final valorMensalidadeController = TextEditingController();
  final diaVencimentoController = TextEditingController();
  final mensalidadesEmAtrasoController = TextEditingController();
  final termoResponsabilidadeController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Aluno',
          style: TextStyle(
            fontSize: 16, // Tamanho da fonte
            fontWeight: FontWeight.bold, // Fonte em negrito
            color: Colors.white, // Cor da fonte branca
          ),
        ),
        backgroundColor: Colors.blue, // Cor de fundo azul
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: telefoneController,
                inputFormatters: [
                  telefoneMaskFormatter
                ], // Aplica a máscara ao campo
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
                keyboardType: TextInputType
                    .number, // Define o tipo de teclado como numérico
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: cpfController,
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Informe uma senha',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: dtNascimentoController,
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: profissaoController,
                decoration: InputDecoration(
                  labelText: 'Profissão',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: dtInicioController,
                decoration: InputDecoration(
                  labelText: 'Data de Início na Kanoê',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
                keyboardType: TextInputType.datetime,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: numEmergenciaController,
                decoration: InputDecoration(
                  labelText: 'Número de Emergência',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: nomeEmergenciaController,
                decoration: InputDecoration(
                  labelText: 'Contato de emergência',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Observações patológicas',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  ),
                ),
              ),
            ],
            SizedBox(height: 10),
            Divider(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
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
                'Informe o plano de saúde',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Plano de saúde',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  ),
                ),
              ),
            ],
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
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
                'Informe qual o tratamento de saúde',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Descrição do tratamento de saúde',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  ),
                ),
              ),
            ],
            SizedBox(height: 10),
            Divider(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              child: TextField(
                controller: obsGeraisController,
                decoration: InputDecoration(
                  labelText: 'Observações gerais',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Coletar dados dos controllers
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
                      : null;
                  final tratamentoMedico = mostrarCampoTratamento
                      ? tratamentoMedicoController.text
                      : null;
                  final obsGerais = obsGeraisController.text;
                  final sexo = sexoController.text;
                  final valorMensalidade =
                      double.tryParse(valorMensalidadeController.text) ?? 0.0;
                  final diaVencimento =
                      int.tryParse(diaVencimentoController.text) ?? 0;
                  final mensalidadesEmAtraso =
                      int.tryParse(mensalidadesEmAtrasoController.text) ?? 0;
                  final termoResponsabilidade = mostrarCampoDescricao;

                  // Chamar o método de cadastro
                  final response = await cadastroAlunoRepository.cadAluno(
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
                    tratamentoMedico: tratamentoMedico,
                    obsGerais: obsGerais,
                    sexo: sexo,
                    valorMensalidade: valorMensalidade,
                    diaVencimento: diaVencimento,
                    mensalidadesEmAtraso: mensalidadesEmAtraso,
                    termoResponsabilidade: termoResponsabilidade,
                  );

                  // Tratar a resposta aqui, exibir mensagem de sucesso ou erro, etc.
                  if (response['statusCode'] == 201) {
                    // Sucesso
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Cadastro realizado com sucesso!')));
                  } else {
                    // Erro
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Erro ao realizar o cadastro.')));
                  }
                },
                child: Container(
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
    );
  }
}
