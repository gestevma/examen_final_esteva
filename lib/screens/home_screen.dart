import 'package:examen_final_esteva/model/plats.dart';
import 'package:examen_final_esteva/provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<FireBaseProvider>(context);

    //Titol de la pantalla. Afegim el nom i un botó per tancar sessió
    return Scaffold(
      appBar: AppBar(
        title: Text('Plats'),
        leading: GestureDetector(
          child: Icon(Icons.logout),
          onTap: () {
            //Botó per tancar sessió
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),

      //Constrium la vista de la llista de dades guardades a firebase
      body: ListView.builder(

          //Elements de la base de dades
          itemCount: firebaseProvider.platsList.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                //Dibuixa les cartes de cada plat amb foto i nom
                child: PlatCard(
                  plat: firebaseProvider.platsList[index],
                  fireBaseProvider: firebaseProvider,
                ),

                //Al clicar sobre un producte s'obrirá el Screen del plat
                onTap: () {
                  FireBaseProvider.selectedPlat =
                      firebaseProvider.platsList[index];

                  Navigator.of(context).pushNamed('details');
                },
              )),
    );
  }
}

//Mostra la informació dels plats que es mostren a home
class PlatCard extends StatelessWidget {
  final Plat plat;
  final FireBaseProvider fireBaseProvider;

  const PlatCard({Key? key, required this.plat, required this.fireBaseProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(plat.foto);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroudWidget(url: plat.foto),

            /******Detalls de les dades mostrades******/
            _PlatDetails(nom: plat.nom),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 10,
          ),
        ],
      );
}

//Mostra la imatge del plat
class _BackgroudWidget extends StatelessWidget {
  final String? url;
  const _BackgroudWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(url);
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
          width: double.infinity,
          height: 400,
          child: Image(
            image: NetworkImage(url == "" || url == null
                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/450px-Imagen_no_disponible.svg.png"
                : url!),
          )
          /*? Image(
                image: NetworkImage(
                    "https://t1.uc.ltmcdn.com/es/posts/0/6/9/como_hacer_un_sandwich_mixto_33960_orig.jpg"),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                placeholder: NetworkImage(
                    "https://t1.uc.ltmcdn.com/es/posts/0/6/9/como_hacer_un_sandwich_mixto_33960_orig.jpg"),
                image: NetworkImage(
                    "https://t1.uc.ltmcdn.com/es/posts/0/6/9/como_hacer_un_sandwich_mixto_33960_orig.jpg"),
                fit: BoxFit.cover,
              ),*/
          ),
    );
  }
}

//Mostra la informació dels plats
class _PlatDetails extends StatelessWidget {
  final String nom;

  const _PlatDetails({
    Key? key,
    required this.nom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: double.infinity,
        height: 80,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nom,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      );
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "${price} €",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
    );
  }
}

class _Availability extends StatelessWidget {
  const _Availability({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Reservat',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red[300],
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
      ),
    );
  }
}
