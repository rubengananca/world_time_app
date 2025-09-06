import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: "Berlin", flag: "germany.png", url: "Europe/Berlin");
    await instance.getTime();

    // em vez de meter a página em cima da pilha de páginas substitui
    // Os arguments são as variáveis que vão junto com a mudança de página
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      "location": instance.location,
      "flag": instance.flag,
      "time": instance.time,
      "isDaytime": instance.isDaytime,
    });

  }

  @override
  void initState() { // corre a primeira vez que abrimos a janela e corre 1º
    super.initState(); // run the initial function
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 80.0,
        ),
      )
    );
  }
}



// Exemplo de código assincrono
// O Future.delayed faz com que a linha especifica de codigo espere um tempo
// O await obriga a que o codigo tudo da seccao espere por este valor

/*
// simulate a network request for a username
String username = await Future.delayed(Duration(seconds: 3), // ao usar o await n corre as linhas seguintes sem ter terminado esta
() {
return "yoshi" ;
}
);

// simulate a network request to get his bio
String bio = await Future.delayed(Duration(seconds: 2),
() {
return "vegan and musician";
}
);

print("$username - $bio");

*/