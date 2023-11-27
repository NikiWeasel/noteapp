import 'package:flutter/material.dart';

class Stuff{
  String name = 'Unknown';
  String info = 'Unknown';

  Stuff(String name, String info){
    this.name = name;
    this.info = info;
  }
}


class ThirdRoute extends StatelessWidget {
  ThirdRoute({super.key});

  void addStuff(){

  }
  void editStuff(){

  }
  void loadPhoto(){

  }

  var stuff = [Stuff('name', 'info'), Stuff('name1', 'info1'), Stuff('name', 'info'), Stuff('name1', 'info1'),
    Stuff('name', 'info'), Stuff('name1', 'info1'), Stuff('name', 'info'), Stuff('name1', 'info1'),
    Stuff('name', 'info'), Stuff('name1', 'info1'), Stuff('name', 'info'), Stuff('name1', 'info1'),
    Stuff('name', 'info'), Stuff('name1', 'info1'), Stuff('name', 'info'), Stuff('name1', 'info1')];


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
      body:ListView.separated(
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(
              stuff[position].name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: Text(stuff[position].info),//date?
            subtitle:Text(stuff[position].info),
            leading: Icon(//TODO: сделать кнопку для ув. фото
              Icons.add_a_photo,
              color: Colors.blue[500],
            ),
            onLongPress: (){
              openDialog();
              editStuff();
            },
          );

        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: stuff.length,
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