import 'dart:html';

import 'package:flutter/material.dart';

const List<String> urls = [
  'https://th.bing.com/th/id/R.4af6c56962d21c8849a649e4cc88605d?rik=%2fe50ZRZEZApSWQ&pid=ImgRaw&r=0',
  'https://th.bing.com/th/id/OIP.Eh0dFH308Is8XFyk2m6a3wHaD4?pid=ImgDet&rs=1',
  'https://th.bing.com/th/id/OIP.7U1dF5HxTrRYFr4wyuYlfgHaJ3?pid=ImgDet&w=490&h=653&rs=1',
  'https://th.bing.com/th/id/OIP.dEizyG3p1DVRoT7cnZ-PDgHaEr?pid=ImgDet&w=681&h=430&rs=1'
];

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Photo Viewer', home: GalleryPage("Image Gallery", urls));
  }
}

class PhotoState {
  String url;
  bool isSelected;

  PhotoState(this.url, {this.isSelected = false});
}

class GalleryPage extends StatelessWidget {
  final String title;
  final List<String> urls;
  const GalleryPage(this.title, this.urls, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: GridView.count(
            primary: false,
            crossAxisCount: 2,
            children: List.of(urls.map((url) => Photo(url)))));
  }
}

class Photo extends StatelessWidget {
  final String url;
  const Photo(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10), child: Image.network(url));
  }
}
