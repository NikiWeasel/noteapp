import 'package:flutter/material.dart';
import 'stuff.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Users> fetchUser() async {
  final response = await http.get(Uri.parse('https://my-json-server.typicode.com/NikiWeasel/demo1/users/1'));
  //https://my-json-server.typicode.com/NikiWeasel/demo1/users/1
  //http://192.168.0.106/users/1
  //http://localhost:3000/users/1
  //https://my-json-server.typicode.com/NikiWeasel/demo/users/1

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Users.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}


class SignUpWidget extends StatefulWidget {
  @override
  State<SignUpWidget> createState() => ThirdRoute();

}

class ThirdRoute extends State<SignUpWidget> {
  late Future<Users> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  void addStuff(){

  }
  void editStuff(){

  }
  void loadPhoto(){

  }

  @override
  Widget build(BuildContext context) {

    Future openDialog()=> showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: const Text('Add stuff'),
        content: SizedBox(
          height: 250,
          child: Column(
            children: [
              TextButton(
                child:const Icon(
                  Icons.add_a_photo,
                ),
                onPressed: (){loadPhoto();},
              ),
              const TextField(
                  keyboardType: TextInputType.none,
                  obscureText: false,
                  autofocus: false,
                  maxLength: 15,
                  enabled: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name of stuff',
                  )
              ),
              const TextField(
                  keyboardType: TextInputType.none,
                  obscureText: false,
                  autofocus: false,
                  maxLength: 15,
                  enabled: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Info of stuff',
                  )
              ),
            ],
          ),
        ),

        actions: [
          TextButton(
              onPressed: (){
                //TODO: return values
                Navigator.of(context).pop();
              },
              child: const Text('Submit'))
        ],
      ),

    );


    return Scaffold(
      appBar: AppBar(
        title: const Text('Stuff List'),
      ),
      body:
      FutureBuilder<Users>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              // context, position,
              separatorBuilder: (BuildContext context, int index) => const Divider(),

              itemCount: snapshot.data!.stuffList!.length,

              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data!.stuffList![index].name!,
                    // snapshot.data!.username!,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Text(snapshot.data!.stuffList![index].date!),//date?
                  // trailing: Text(snapshot.data!.email!),//date?

                  subtitle:Text(snapshot.data!.stuffList![index].info!),
                  // subtitle:Text(snapshot.data!.id.toString()),

                  leading: Icon(//TODO: ув. фото
                    Icons.add_a_photo,
                    color: Colors.blue[500],
                  ),
                  onLongPress: (){
                    openDialog();
                    editStuff();
                  },

                );

              },
            );



          } else if (snapshot.hasError) {

            return AlertDialog(
              title: const Text('Unexpected Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Error : ${snapshot.error}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );

          }


          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialog();
          addStuff();},
        child: const Icon(Icons.add),
      ),
    );

  }

}