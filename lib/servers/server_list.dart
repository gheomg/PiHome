import 'package:flutter/material.dart';
import 'package:pihole_manager/database/database_helper.dart';
import 'package:pihole_manager/models/server_details.dart';
import 'package:pihole_manager/servers/add_pi.dart';

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
          shrinkWrap: true,
          itemCount: servers.length,
          itemBuilder: (context, index) {
            ServerDetails server = servers.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.lan_rounded),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                server.address,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                server.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white),
                              elevation: WidgetStatePropertyAll(0),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Icon(Icons.link_rounded),
                                ),
                                Text(
                                  'Connect',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onPressed() {
    Navigator.of(context)
        .push(
      MaterialPageRoute<ServerDetails>(
        builder: (BuildContext context) => const AddPi(),
      ),
    )
        .then((value) {
      if (value != null) DatabaseHelper.instance.addServer(value);
      loadServers();
    });
  }
}
