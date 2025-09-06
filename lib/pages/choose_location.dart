import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: "London", flag: "uk.png", url: "Europe/London"),
    WorldTime(location: "Berlin", flag: "germany.png", url: "Europe/Berlin"),
    WorldTime(location: "Cairo", flag: "egypt.jpg", url: "Africa/Egypt"),
    WorldTime(location: "New York", flag: "usa.png", url: "America/New_York"),
    WorldTime(location: "Athens", flag: "greece.png", url: "Europe/Greece"),
  ];

  void updateTime(index) async { // é assincrona porque é chamado
    WorldTime instance = locations[index]; // armazena uma instancia
    await instance.getTime(); // temos de esperar até estar pronto

    // Navigate to home screen
    Navigator.pop(context, {
      "location": instance.location,
      "flag": instance.flag,
      "time": instance.time,
      "isDaytime": instance.isDaytime,
    }); // no pop passa-se diretamente um map sem ter de usar arguments

  }

  @override
  Widget build(BuildContext context) { // corre sempre que corremos a janela
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData( // muda a cor da seta para ficar da mesma cor que o texto
          color: Colors.white
        ),
        backgroundColor: Colors.blue[900],
        title: Text("Choose a Location",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index){
           return Padding(
             padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
             child: Card(
               child: ListTile(
                 onTap: () {
                   updateTime(index);
                 },
                 title: Text(locations[index].location),
                 leading: CircleAvatar(
                   backgroundImage: AssetImage("assets/${locations[index].flag}"),
                 ),
               ),
             ),
           );
        }
      ),
    );
  }
}
