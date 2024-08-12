import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pihole_manager/pihole_api/pihole.dart';

class Network extends StatefulWidget {
  final Widget drawer;
  const Network({
    super.key,
    required this.drawer,
  });

  @override
  State<StatefulWidget> createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  Pihole pihole = GetIt.instance.get<Pihole>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Network',
        ),
      ),
      drawer: widget.drawer,
      body: FutureBuilder(
        future: pihole.getNetwork(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<String, dynamic> data = snapshot.data ?? {};
          List<dynamic> network = [];
          if (data.containsKey('network')) {
            network = data['network'];
          }

          return ListView.builder(
            itemCount: network.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> itemData = network[index];

              return ListTile(
                title: Text(
                  itemData['macVendor'].toString(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
