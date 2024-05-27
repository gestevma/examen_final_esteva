import 'package:examen_final_esteva/provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Classe que mostra la informació d'un producte i permet modificar-la
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebasePrvider = Provider.of<FireBaseProvider>(context);

    return _ElementScreenBody(
      fireBaseProvider: firebasePrvider,
    );
  }
}

//Informació del producte
class _ElementScreenBody extends StatelessWidget {
  const _ElementScreenBody({
    Key? key,
    required this.fireBaseProvider,
  }) : super(key: key);

  final FireBaseProvider fireBaseProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, 'home'),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            _ProductForm(),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),

      /*****Botó obrir Geo******/
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: (() {}),
      ),
    );
  }
}

//*********************//
//*****Formulari******//
//*******************//
//Es defineix un formulari amb la informació dels productes
class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          //key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10),

              /***Nom***/
              TextFormField(
                initialValue: FireBaseProvider.selectedPlat.nom,
                onChanged: (value) => FireBaseProvider.selectedPlat.nom = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nom no és valid';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nom', labelText: 'Nom:'),
              ),
              SizedBox(height: 30),

              /****descripcio*****/
              TextFormField(
                initialValue: FireBaseProvider.selectedPlat.descripcio,
                onChanged: (value) =>
                    FireBaseProvider.selectedPlat.descripcio = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'La descripció no és valids';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'descripció', labelText: 'descripció:'),
              ),
              SizedBox(height: 30),

              /*****tipus*****/
              TextFormField(
                initialValue: FireBaseProvider.selectedPlat.tipus,
                onChanged: (value) =>
                    FireBaseProvider.selectedPlat.tipus = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El tipus no és valid';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'tipus', labelText: 'tipus:'),
              ),
              SizedBox(height: 30),

              /*****restaurant*****/
              TextFormField(
                initialValue: FireBaseProvider.selectedPlat.restaurant,
                onChanged: (value) =>
                    FireBaseProvider.selectedPlat.restaurant = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El restaurant no és valid';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'restaurant', labelText: 'restaurant:'),
              ),
              SizedBox(height: 30),

              /*****geo*****/
              TextFormField(
                initialValue: FireBaseProvider.selectedPlat.geo,
                onChanged: (value) => FireBaseProvider.selectedPlat.geo = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El geo no és valid';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'geo', labelText: 'geo:'),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: FireBaseProvider.selectedPlat.disponible,
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      );
}

//Selecciona la imatge del producte
class ElementImage extends StatelessWidget {
  final String? url;

  const ElementImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
          decoration: _buildBoxDecoration(),
          width: double.infinity,
          height: 450,
          child: Opacity(
            opacity: 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: getImage(url),
            ),
          )),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]);

  //3 possibles imatges:
  //  1: Si no hi ha imatge mostra assets/no-image.png
  //  2. Si hi ha imatge mostra la imatge del producte guardada a la base de dades
  //  3. Si hi ha imatge però encara no la hem recuperat de la base de dades mostrà un gif de imatge carregant
  Widget getImage(String? picture) {
    return Image(
      image: NetworkImage(url == null || url == ""
          ? "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/450px-Imagen_no_disponible.svg.png"
          : url!),
      fit: BoxFit.cover,
    );
  }
}

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
          width: 2,
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey),
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.deepPurple)
          : null,
    );
  }
}
