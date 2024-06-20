import 'package:flutter/material.dart';
import 'package:powerupdata/models/Client.dart';
import 'package:powerupdata/screens/DetailsClientPage.dart';

class SearchScreen extends StatefulWidget {
    final List<Client> clients;
    const SearchScreen(this.clients,{super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Cliente'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width:  MediaQuery.of(context).size.width * 0.8,
                  child: SearchBar(
                    leading: IconButton(onPressed: () {
                      showSearch(context: context, 
                      delegate: CustomSearchDelegate(widget.clients));
                    },
                    icon: Icon(Icons.search),
                    ),
                    controller: _controllerName,
                   ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}

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
