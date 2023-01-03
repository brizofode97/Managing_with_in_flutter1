import 'package:flutter/material.dart';

const List<String> urls = [
  'https://th.bing.com/th/id/R.4af6c56962d21c8849a649e4cc88605d?rik=%2fe50ZRZEZApSWQ&pid=ImgRaw&r=0',
  'https://th.bing.com/th/id/OIP.Eh0dFH308Is8XFyk2m6a3wHaD4?pid=ImgDet&rs=1',
  'https://th.bing.com/th/id/OIP.7U1dF5HxTrRYFr4wyuYlfgHaJ3?pid=ImgDet&w=490&h=653&rs=1',
  'https://th.bing.com/th/id/OIP.dEizyG3p1DVRoT7cnZ-PDgHaEr?pid=ImgDet&w=681&h=430&rs=1'
];

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(title: 'Photo Viewer', 
    home: GalleryPage(title: 'Image Gallery', urls: urls));
  }
}

class GalleryPage extends StatelessWidget {

  late final String title;
  late final List<String> urls;
  GalleryPage({title, urls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: GridView.count(
            primary: false,
            crossAxisCount: 2,
            children: List.of(urls.map((url) => Photo(url: url)))));
  }
}

class Photo extends StatelessWidget {

  late final String url;
  Photo({url});

  @override
  Widget build(BuildContext context) {
    return Image.network(url);
  }
}
