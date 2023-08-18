import 'package:apptestewillians/pages/login.page.dart';
import 'package:flutter/material.dart';

import '../services/background_service.dart';
import '../services/geo_pos.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Localização em Segundo Plano'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Política de Privacidade',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'O nosso aplicativo coleta e utiliza informações de localização em segundo plano. A sua privacidade é importante para nós, e garantimos que essas informações serão usadas somente para os fins mencionados.',
            ),
            SizedBox(height: 20),
            Text(
              'Como usamos as informações de localização:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Fornecer serviços de localização em tempo real para o monitoramento da viagem pela gertran.',
            ),
            SizedBox(height: 20),
            Text(
              'Você pode gerenciar as permissões de localização a qualquer momento nas configurações do aplicativo. Se tiver dúvidas sobre a nossa política de privacidade, entre em contato conosco.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    await GeoPos.autorizaLocalizacao();

                    bool a = await BackGroound.verificarLocalizacaoAparelho();
                    if (a) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  child:
                      const Text("Liberar Acesso a localização do aparelho")),
            )
          ],
        ),
      ),
    );
  }
}
