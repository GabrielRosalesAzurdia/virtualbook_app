import 'package:biblioteca_virtualbook_app/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca_virtualbook_app/modelos/crear_usuario.dart';
import 'package:biblioteca_virtualbook_app/widgets/text_field.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CrearCuenta extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CrearCuentaState();
  }

}

class _CrearCuentaState extends State<CrearCuenta>{ 

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle= Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear cuenta"), 
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(child:Column(
          children: <Widget>[

            Text("Crear cuenta", style: textStyle,),

            Padding(
              padding: EdgeInsets.all(20),
              child: null,
            ),

            CampoDeTexto("Email",emailController,TextInputType.emailAddress),

            Padding(
              padding: EdgeInsets.all(20),
              child: null,
            ),

            CampoDeTexto("Contraseña",passwordController,TextInputType.text),

            Padding(
              padding: EdgeInsets.all(20),
              child: null,
            ),

            CampoDeTexto("Confirmacion de contraseña",passwordConfirmationController,TextInputType.text),

            Padding(
              padding: EdgeInsets.all(20),
              child: null,
            ),

            CampoDeTexto("Nombre",nameController,TextInputType.text),

            Padding(
              padding: EdgeInsets.all(20),
              child: null,
            ),

            CampoDeTexto("Apellido", lastNameController,TextInputType.text),

            Padding(
              padding: EdgeInsets.all(20),
              child: null,
            ),

            CampoDeTexto("Pais", countryController,TextInputType.text),

            Padding(
              padding: EdgeInsets.all(20),
              child: null,
            ),

            // RaisedButton(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(24),
            //   ),
            //   child: Text("Crear"),
            //   padding: EdgeInsets.all(12),
            //   color: Colors.lightBlueAccent,
            //   onPressed: () async{
            //     CreateUser newUser = new CreateUser(
            //       password1:passwordController.text, password2: passwordConfirmationController.text, email:emailController.text, 
            //       country:countryController.text, firstName:nameController.text,lastName: lastNameController.text
            //     );
            //     await createUser("https://virtualbook-backend.herokuapp.com/api/accounts/register/",body: newUser.toMap());
            //   },
            // ),

            Container(padding:EdgeInsets.only(bottom: 20.0), width: 320.0,child:
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text("Crear"),
              padding: EdgeInsets.all(12),
              color: Colors.lightBlueAccent,
              onPressed: () async{
                CreateUser newUser = new CreateUser(
                  password1:passwordController.text, password2: passwordConfirmationController.text, email:emailController.text, 
                  country:countryController.text, firstName:nameController.text,lastName: lastNameController.text
                );
                await createUser("https://virtualbook-backend.herokuapp.com/api/accounts/register/",body: newUser.toMap());
              },
            )),

          ],
        )),
      ),
    );
  }

  Future<String> createUser(String url, {Map body}) async {
    return http.put(url, body: body).then((http.Response response){
      final int statusCode = response.statusCode;
  
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      var valor = json.decode(response.body);

      if(valor == "False"){
        bookFlight(context,"La informacion es incorrecta","Porfavor revisa los datos");
        return "Mal";
      }else{
        bookFlight(context,"Nice","Ahora tienes una cuenta !!!");
        return "Bien";
      }

    });
  }

}