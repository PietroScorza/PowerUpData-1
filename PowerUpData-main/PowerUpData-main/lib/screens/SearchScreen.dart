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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width:  MediaQuery.of(context).size.width * 0.8,
                  child: SearchBar(
                    leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back),),
                    controller: _controllerName,
                   ),
                ),
     
                   ListView.builder(
                      itemCount: widget.clients.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(widget.clients[index].nombre),
                          subtitle: Text(widget.clients[index].importe.toString()),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsClient(client: widget.clients[index])));
                          },
                        );
                      },
                    )
                  
                
              ],
            )
          ),
        ),
      ),
    );
  }
}
