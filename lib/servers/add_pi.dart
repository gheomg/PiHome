import 'package:flutter/material.dart';
import 'package:pihole_manager/enums/authentication_type.dart';
import 'package:pihole_manager/enums/protocol.dart';
import 'package:pihole_manager/globals.dart';
import 'package:pihole_manager/models/server_details.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/widgets/custom_text_field.dart';

class AddPi extends StatefulWidget {
  const AddPi({super.key});

  @override
  State<StatefulWidget> createState() => _AddPi();
}

class _AddPi extends State<AddPi> {
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  Protocol protocol = Protocol.http;
  AuthenticationType authenticationType = AuthenticationType.token;
  String infoLabel = '';

  @override
  void initState() {
    super.initState();

    _hostController.addListener(() => _updateInfoLabel());
    _portController.addListener(() => _updateInfoLabel());
    _nameController.addListener(() => _updateInfoLabel());
    _tokenController.addListener(() => _updateInfoLabel());
    _userController.addListener(() => _updateInfoLabel());
    _passController.addListener(() => _updateInfoLabel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('New connection'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Server information',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        if (infoLabel.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                infoLabel,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SegmentedButton<Protocol>(
                      multiSelectionEnabled: false,
                      segments: const <ButtonSegment<Protocol>>[
                        ButtonSegment<Protocol>(
                          value: Protocol.http,
                          label: Text('HTTP'),
                          icon: Icon(Icons.lock_open_rounded),
                        ),
                        ButtonSegment<Protocol>(
                          value: Protocol.https,
                          label: Text('HTTPS'),
                          icon: Icon(Icons.https),
                        ),
                      ],
                      selected: <Protocol>{protocol},
                      onSelectionChanged: (value) {
                        setState(() => protocol = value.first);
                        _updateInfoLabel();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _hostController,
                      label: 'Host address',
                      icon: Icons.developer_board_rounded,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _portController,
                      label: 'Port',
                      icon: Icons.numbers,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _nameController,
                      label: 'Name',
                      icon: Icons.edit,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Authentication',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SegmentedButton<AuthenticationType>(
                      multiSelectionEnabled: false,
                      segments: <ButtonSegment<AuthenticationType>>[
                        ButtonSegment<AuthenticationType>(
                          value: AuthenticationType.token,
                          label: Text(AuthenticationType.token.getString()),
                        ),
                        ButtonSegment<AuthenticationType>(
                          value: AuthenticationType.credentials,
                          label:
                              Text(AuthenticationType.credentials.getString()),
                        ),
                      ],
                      selected: <AuthenticationType>{authenticationType},
                      onSelectionChanged: (value) =>
                          setState(() => authenticationType = value.first),
                    ),
                  ),
                  Visibility(
                    visible: authenticationType == AuthenticationType.token,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _tokenController,
                        label: 'Token',
                        helperText:
                            'In the Pi-hole web interface, go to Settings > API/Web interface to find the API token.',
                        icon: Icons.code,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        authenticationType == AuthenticationType.credentials,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _userController,
                        label: 'User',
                        icon: Icons.person,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        authenticationType == AuthenticationType.credentials,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: _passController,
                        label: 'Password',
                        icon: Icons.password_rounded,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        obscureText: true,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (isButtonEnabled) addConnection();
                  },
                  style: !isButtonEnabled
                      ? ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.grey.shade400),
                        )
                      : null,
                  child: const Text('SAVE'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addConnection() async {
    ServerDetails server = ServerDetails(
      host: _hostController.text,
      port: _portController.text,
      name: _nameController.text,
      protocol: protocol,
      authToken: _tokenController.text,
      user: _userController.text,
      password: _passController.text,
    );

    Pihole piHole = Pihole(
      protocol: server.protocol,
      address: server.address,
      user: server.user,
      password: server.password,
      token: server.authToken,
    );

    bool success = await piHole.checkConnection();

    if (success) {
      Navigator.of(context).pop(server);
    } else {
      snackBarKey.currentState?.showSnackBar(SnackBar(
        content: Text(
          'Could not access the RaspberryPi hosted at ${server.address}',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.red,
        showCloseIcon: true,
      ));
    }
  }

  void _updateInfoLabel() {
    String host = _hostController.text;
    String port = _portController.text;

    if (host.isEmpty && port.isEmpty) {
      setState(() => infoLabel = '');
      return;
    }

    setState(() {
      infoLabel =
          '${protocol.getString()}://$host${port.isNotEmpty ? ':$port' : ''}';
    });
  }

  bool get isButtonEnabled =>
      _hostController.text.isNotEmpty && _tokenController.text.isNotEmpty;
}
