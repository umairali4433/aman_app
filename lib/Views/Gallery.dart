import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  final List<String> imagesList = [
    'https://aman.paknavy.gov.pk/images/aman19/01.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/02.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/003.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/04.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/005.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/006.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/007.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/08.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/09.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/010.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/011.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/012.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/013.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/014.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/015.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/016.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/017.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/018.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/019.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/020.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/021.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/022.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/023.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/024.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/025.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/026.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/027.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/028.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/031.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/032.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/033.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/034.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/035.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/036.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/037.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/038.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/039.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/040.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/041.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/042.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/043.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/044.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/045.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/046.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/047.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/048.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/049.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/050.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/051.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/052.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/053.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/054.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/055.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/056.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/057.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/058.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/059.jpg',
    'https://aman.paknavy.gov.pk/images/aman19/060.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1),
        itemBuilder: (context, index) {
          return Card(

            color: Colors.grey,
              elevation: 6,
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.blueGrey.shade900, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imagesList[index],
                  scale: 1.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey.shade900),
                        backgroundColor: Colors.grey.shade400,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
          );
        },
        itemCount: imagesList.length,
      ),
    );
  }
}
