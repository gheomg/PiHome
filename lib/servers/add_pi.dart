import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pihole_manager/database/database_helper.dart';
import 'package:pihole_manager/enums/authentication_type.dart';
import 'package:pihole_manager/enums/protocol.dart';
import 'package:pihole_manager/globals.dart';
import 'package:pihole_manager/home.dart';
import 'package:pihole_manager/models/server_details.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/pihole_api/pihole_dummy.dart';
import 'package:pihole_manager/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPi extends StatefulWidget {
  final ServerDetails? server;

  const AddPi({
    super.key,
    this.server,
  });

  @override
  State<StatefulWidget> createState() => _AddPi();
}

class _AddPi extends State<AddPi> {
  ServerDetails? get server => widget.server;

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

    loadOnEdit();

    _hostController.addListener(() => _updateInfoLabel());
    _portController.addListener(() => _updateInfoLabel());
    _nameController.addListener(() => _updateInfoLabel());
    _tokenController.addListener(() => _updateInfoLabel());
    _userController.addListener(() => _updateInfoLabel());
    _passController.addListener(() => _updateInfoLabel());
  }

  void loadOnEdit() {
    if (server != null) {
      _hostController.text = server?.host ?? '';
      _portController.text = server?.port ?? '';
      _nameController.text = server?.name ?? '';
      _tokenController.text = server?.authToken ?? '';
      _userController.text = server?.user ?? '';
      _passController.text = server?.password ?? '';
      protocol = server!.protocol;
      if (server!.authToken!.isNotEmpty) {
        authenticationType = AuthenticationType.token;
      } else {
        authenticationType = AuthenticationType.credentials;
      }
      _updateInfoLabel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.newConnection ?? ''),
          centerTitle: false,
          actions: [
            if (server != null)
              IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                onPressed: () {
                  DatabaseHelper.instance.deleteServer(server!.host);
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
          ],
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
                        Text(
                          AppLocalizations.of(context)?.serverInfo ?? '',
                          style: const TextStyle(
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
                      segments: <ButtonSegment<Protocol>>[
                        ButtonSegment<Protocol>(
                          value: Protocol.http,
                          label: Text(Protocol.http.getString().toUpperCase()),
                          icon: const Icon(Icons.lock_open_rounded),
                        ),
                        ButtonSegment<Protocol>(
                          value: Protocol.https,
                          label: Text(Protocol.https.getString().toUpperCase()),
                          icon: const Icon(Icons.https),
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
                      label: AppLocalizations.of(context)?.hostAddress,
                      icon: Icons.developer_board_rounded,
                      enabled: server == null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _portController,
                      label: AppLocalizations.of(context)?.port,
                      icon: Icons.numbers,
                      keyboardType: TextInputType.number,
                      enabled: server == null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextField(
                      controller: _nameController,
                      label: AppLocalizations.of(context)?.name,
                      icon: Icons.edit,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)?.authentication ?? '',
                      style: const TextStyle(
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
                        label: AppLocalizations.of(context)?.tokenLabel,
                        helperText:
                            AppLocalizations.of(context)?.tokenDescription,
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
                        label: AppLocalizations.of(context)?.user,
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
                        label: AppLocalizations.of(context)?.password,
                        icon: Icons.password_rounded,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        obscureText: true,
                      ),
                    ),
                  ),
                ],
              ),
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
                  child: Text(
                    (AppLocalizations.of(context)?.save ?? '').toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool checkDummyPi(ServerDetails server) {
    if (server.host == 'pihome.dummy' &&
        server.protocol == Protocol.https &&
        server.port == '0000' &&
        server.authToken == 'masterkey') {
      Pihole pihole = PiholeDummy(protocol: server.protocol, host: server.host);
      GetIt.instance.registerSingleton<Pihole>(pihole);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute<ServerDetails>(
          builder: (BuildContext context) => const Home(),
        ),
      );

      return true;
    }
    return false;
  }

  Future<void> addConnection() async {
    ServerDetails server = ServerDetails(
      host: _hostController.text,
      port: _portController.text,
      name: _nameController.text,
      protocol: protocol,
      authToken: _tokenController.text,
      user: _userController.text,
      password: _passController.text,
    );

    if (checkDummyPi(server)) return;

    Pihole piHole = Pihole(
      host: server.host,
      port: server.port,
      protocol: server.protocol,
      user: server.user,
      password: server.password,
      token: server.authToken,
    );

    await piHole.checkConnection().then(
      (success) {
        if (!mounted) return;
        if (success) {
          Navigator.of(context).pop(server);
        } else {
          snackBarKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(
                '${AppLocalizations.of(context)?.couldNotConnect} ${piHole.address}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              backgroundColor: Colors.red,
              showCloseIcon: true,
            ),
          );
        }
      },
    );
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
      _hostController.text.isNotEmpty &&
      (_tokenController.text.isNotEmpty ||
          _userController.text.isNotEmpty && _passController.text.isNotEmpty);
}
