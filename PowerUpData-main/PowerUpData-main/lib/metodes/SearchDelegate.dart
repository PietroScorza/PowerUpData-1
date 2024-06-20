import 'package:flutter/material.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/screens/DetailsClientPage.dart';

class CustomSearchDelegate extends SearchDelegate {
  
  List<Client> clientes = [];

  CustomSearchDelegate(this.clientes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   List<Client> results = clientes.where((client) => client.nombre.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].nombre),
          subtitle: Text(results[index].importe.toString()),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsClient(client: results[index])));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   List<Client> results = clientes.where((client) => client.nombre.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].nombre),
          subtitle: Text(results[index].importe.toString()),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsClient(client: results[index])));
          },
        );
      },
    );
     
  }
}
