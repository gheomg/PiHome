import 'package:flutter/material.dart';
import 'package:pihole_manager/models/server_details.dart';

class ServerCard extends StatefulWidget {
  final ServerDetails server;
  final Function() onPressed;
  final Function() onConnect;

  const ServerCard({
    super.key,
    required this.onPressed,
    required this.onConnect,
    required this.server,
  });

  @override
  State<ServerCard> createState() => _ServerCardState();
}

class _ServerCardState extends State<ServerCard> {
  ServerDetails get server => widget.server;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    elevation: WidgetStatePropertyAll(0),
                  ),
                  onPressed: widget.onPressed,
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
                  onPressed: widget.onConnect,
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
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
    );
  }
}
