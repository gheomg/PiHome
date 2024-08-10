import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pihole_manager/database/database_helper.dart';
import 'package:pihole_manager/home.dart';
import 'package:pihole_manager/models/server_details.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';
import 'package:pihole_manager/servers/add_pi.dart';
import 'package:pihole_manager/widgets/server_card.dart';

class ServerList extends StatefulWidget {
  const ServerList({super.key});

  @override
  State<ServerList> createState() => _ServerListState();
}

class _ServerListState extends State<ServerList> {
  List<ServerDetails> servers = [];

  @override
  void initState() {
    super.initState();
    loadServers();
  }

  void loadServers() {
    DatabaseHelper.instance.getAllServer().then((value) {
      setState(() => servers = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servers'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: servers.length,
          itemBuilder: (context, index) {
            ServerDetails server = servers.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ServerCard(
                server: server,
                onPressed: () => onPressed(server: server),
                onConnect: () => connect(server: server),
              ),
            );
          },
        ),
      ),
    );
  }

  void onPressed({ServerDetails? server}) {
    Navigator.of(context)
        .push(
      MaterialPageRoute<ServerDetails>(
        builder: (BuildContext context) => AddPi(
          server: server,
        ),
      ),
    )
        .then((value) {
      if (value != null) DatabaseHelper.instance.addServer(value);
      loadServers();
    });
  }

  void connect({required ServerDetails server}) {
    Pihole pihole = Pihole.fromServer(server: server);
    pihole.checkConnection().then(
      (value) {
        if (value) {
          GetIt.instance.registerSingleton<Pihole>(pihole);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute<ServerDetails>(
              builder: (BuildContext context) => const Home(),
            ),
          );
        }
      },
    );
  }
}
