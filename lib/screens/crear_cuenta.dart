import 'package:biblioteca_virtualbook_app/modelos/crear_usuario.dart';
import 'package:biblioteca_virtualbook_app/widgets/text_field.dart';
import 'package:biblioteca_virtualbook_app/widgets/alert.dart';
import "package:image_picker/image_picker.dart";
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

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
  File _image;

  void piker()async{
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("");
    print(img.uri);
    print("");
    if(img != null){
      setState(() {
        _image = img;
      });
    }
  }

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

            RaisedButton(
              color: Colors.white,
              onPressed: piker,
              child: Icon(Icons.camera),
            ),

            _image == null
            ? Text('No image selected.')
            : Image.file(_image),

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

            Container(
              padding:EdgeInsets.only(bottom: 20.0),
              width: 320.0,
              child: Container(
                decoration: new BoxDecoration(border: new Border.all(color: Colors.black)),
                child:RaisedButton(
                  elevation: 0.0,
                  child: Text("Crear"),
                  padding: EdgeInsets.all(12),
                  color: Colors.white,
                  onPressed: () async{

                    var base64Image = _image.readAsBytesSync();

                    CreateUser newUser = new CreateUser(
                      password1:passwordController.text, password2: passwordConfirmationController.text, email:emailController.text,
                      country:countryController.text, firstName:nameController.text,lastName: lastNameController.text,image:base64Image.toString(),
                    );
                    await createUser(context,"https://virtualbook-backend.herokuapp.com/api/accounts/register/",body: newUser.toMap());
                  },
                )
              )
            ),

          ],
        )),
      ),
    );
  }

  Future<String> createUser(BuildContext context,String url, {Map body}) async {

  var request = new http.MultipartRequest("PUT", Uri.parse(url));
  request.fields['email'] = 'someone@somewhere.com';
  request.fields["password1"] = "123";
  request.fields["password2"] = "123";
  request.fields["first_name"] = "Gabriel";
  request.fields["last_name"] = "Rosales";
  // var pic = await http.MultipartFile.fromPath("file_field", _image.toString(),filename: "image");
  // request.files.add(pic);
  request.files.add(new http.MultipartFile.fromBytes('image', await File.fromUri(_image.uri).readAsBytes(),
  // contentType: new MediaType('image', 'jpeg')
  filename: "Gabriel-image"));
  request.send().then((response) async{
   print(response.statusCode);
   var responseData = await response.stream.toBytes();
   var responseString = String.fromCharCodes(responseData);
   print(responseString);
  });


  //   return http.put(url, body: body).then((http.Response response){
  //     final int statusCode = response.statusCode;

  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
  //     }

  //     var valor = json.decode(response.body);
  //     print(valor);
  //     if(valor == "True"){
  //       bookFlight(context,"Nice","Ahora tienes una cuenta !!!");
  //       return "Bien";
  //     }else{
  //       bookFlight(context,"La informacion es incorrecta","Porfavor revisa los datos");
  //       return "Mal";
  //     }

  //   });
  }

}