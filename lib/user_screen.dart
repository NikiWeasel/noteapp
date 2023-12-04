import 'package:flutter/material.dart';
import 'stuff.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';



Future<Users> fetchUser() async {
  final response = await http.get(Uri.parse
    ('https://my-json-server.typicode.com/NikiWeasel/demo1/users/1'));
  
  //https://my-json-server.typicode.com/NikiWeasel/demo1/users/1
  //http://192.168.0.106/users/1
  //http://localhost:3000/users/1

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

  void imagePicker() async {
    ImagePicker picker = ImagePicker();
    XFile? fileData = await picker.pickImage(source: ImageSource.gallery);
    // if (fileData=!null){return;}


    var imageBytes = await fileData?.readAsBytes();
    // print(imageBytes);
    String base64Image = base64Encode(imageBytes!);
    print(base64Image);
    // Fluttertoast.showToast(
    //     msg: base64Image,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  child:const Icon(
                    Icons.add_a_photo,
                    size: 50,
                  ),
                  onPressed: (){imagePicker();},
                ),
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

    Future openListtile()=> showDialog(
      context: context,
      builder: (context)=> Container(
        width: 200,
        height: 500,
        child: Column(
          children:[
            Row(
              children: [
                Image.asset('assets/images/cat.png',width:80,height:80),

              ],
            )

          ]
        ),
      )

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
                return GFListTile(
                    avatar:Image.asset('assets/images/cat.png',width:80,height:80),
                    titleText:snapshot.data!.stuffList![index].title!,
                    subTitleText:snapshot.data!.stuffList![index].date!,
                    icon: Icon(Icons.favorite,color:Colors.red),
                  description: Text(snapshot.data!.stuffList![index].info!),

                  onLongPress: (){
                    openDialog();
                    editStuff();
                  },
                );

                //   ListTile(
                //   title: Text(
                //     snapshot.data!.stuffList![index].name!,
                //     style: const TextStyle(fontWeight: FontWeight.w500),
                //   ),
                //   trailing: Text(snapshot.data!.stuffList![index].date!),
                //   subtitle:Text(snapshot.data!.stuffList![index].info!),
                //   leading: Icon(//TODO: ув. фото
                //     Icons.add_a_photo,
                //     color: Colors.blue[500],
                //   ),
                //   onLongPress: (){
                //     openDialog();
                //     editStuff();
                //   },
                //
                // );

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