import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // crio o map que vai receber a info da página loading
  Map data = {};

  @override
  Widget build(BuildContext context) {


    // Declara bgImage com um valor padrão
    //String bgImage = "night.jpg"; // Valor padrão para evitar erros antes de carregar os dados
    //Color bgColor = Colors.white; // valor padrao

    // Verifica se ModalRoute.of(context) não é nulo
    final routeData = ModalRoute.of(context);
    if (routeData != null && routeData.settings.arguments != null && data.isEmpty) {
      // Converte settings.arguments para Map
      data = routeData.settings.arguments as Map;

    }

    String bgImage = data["isDaytime"] ? "day.png" : "night.jpg";
    Color bgColor = data["isDaytime"]
        ? const Color(0xFFB4EFE0) // Cor específica para o dia
        : const Color(0xFF0D1226);


    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$bgImage"),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(onPressed: () async {
                  // importante porque tem de esperar pela informacao de volta
                  dynamic result = await Navigator.pushNamed(context, "/location");

                  // acontece quando recebe informação do choose_location
                  setState(() {
                    data = {
                      "time": result["time"],
                      "location": result["location"],
                      "isDaytime": result["isDaytime"],
                      "flag": result["flag"]
                    };
                  });
                },

                  icon: Icon(Icons.edit_location,
                    color: data["isDaytime"] ? Colors.lightBlue : Colors.grey[300],
                  ),
                  label: Text("Edit Location",
                    style: TextStyle(
                      color: data["isDaytime"] ? Colors.lightBlue : Colors.grey[300],
                    ),
                  )
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: data["isDaytime"] ? Colors.indigo : Colors.white
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.0,),
                Text(data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: data["isDaytime"] ? Colors.indigo : Colors.white
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
