import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({
    super.key,
    required this.photo,
    this.onTap,
    required this.width,
  });
  final String photo;
  final VoidCallback? onTap;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text("WELCOME TO RESTAURANTS"),
          backgroundColor: Colors.red,
        ),
        body: _getDynamicList(),
      ),
    );
  }

   _getDynamicList() {
    var restaurantData = [
      { 
        'name': "ITALIANO", 
        'image': "https://images.unsplash.com/photo-1516100882582-96c3a05fe590",
        'description': "Authentic Italian cuisine with homemade pasta, wood-fired pizzas, and an extensive wine selection."
      },
      { 
        'name': "BURGER KING", 
        'image': "https://images.unsplash.com/photo-1571091718767-18b5b1457add",
        'description': "Home of the Whopper! Fast food burgers, fries, and shakes served quickly with flame-grilled taste."
      },
      { 
        'name': "SUSHI HAVEN", 
        'image': "https://images.unsplash.com/photo-1579871494447-9811cf80d66c",
        'description': "Fresh sushi and Japanese specialties prepared by master chefs with the finest ingredients."
      },
      { 
        'name': "TACO FIESTA", 
        'image': "https://images.unsplash.com/photo-1615870216519-2f9fa575fa5c",
        'description': "Vibrant Mexican flavors with handmade tortillas, spicy salsas, and refreshing margaritas."
      },
      { 
        'name': "STEAK HOUSE", 
        'image': "https://images.unsplash.com/photo-1544025162-d76694265947",
        'description': "Premium cuts of beef aged to perfection, grilled exactly to your liking with classic sides."
      },
    ];
    
    return ListView.builder(
      itemCount: restaurantData.length,
      itemBuilder: (ctx, index) {
        return ListTile(
          title: Text(restaurantData[index]['name']!),
          leading: PhotoHero(photo: restaurantData[index]['image']!, width: 40),
          trailing: const Icon(Icons.arrow_forward_ios, size: 10),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("CLICKED ON ${restaurantData[index]['name']}")));

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(
                          data: restaurantData[index],
                        )));
          },
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  final Map<String, String> data;

  DetailPage({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(
            title: Text("RESTAURANT DETAILS"), 
            backgroundColor: Colors.red),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PhotoHero(
                  photo: data['image']!,
                  width: 300.0,
                  onTap: () {
                    Navigator.pop(context);
                  }),
             
              Text(data['name']!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
            
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text(data['description']!,
                  
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ],
          ),
        ),
     ),
);
}
}