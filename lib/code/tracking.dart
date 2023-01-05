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
  bool isTagging = false;
  List<PhotoState> photoStates = List.of(urls.map((url) => PhotoState(url)));
  Set<String> tags = {"all", "nature", "cat"};

  void selectTag(String tag) {
    setState(() {
      if (isTagging) {
        if (tag != "all") {
          photoStates.forEach((element) {
            if (element.selected) {
              element.tags.add(tag);
            }
          });
        }
      } else {
        photoStates.forEach((element) {
          element.display = tag == "all" ? true : element.tags.contains(tag);
        });
      }
    });
  }

  void toogleTagging(String url) {
    setState(() {
      isTagging = !isTagging;
      photoStates.forEach((element) {
        if (isTagging && element.url == url) {
          element.selected = true;
        } else {
          element.selected = false;
        }
      });
    });
  }

  void onPhotoSelect(String url, bool selected) {
    setState(() {
      photoStates.forEach((element) {
        if (element.url == url) {
          element.selected = selected;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Photo Viewer',
        home: GalleryPage('Image Gallery', photoStates, isTagging,
            toogleTagging, onPhotoSelect));
  }
}

class PhotoState {
  String url;
  bool selected;
  bool display;
  Set<String> tags = {};

  PhotoState(this.url, {this.selected = false, this.display = true, tags});
}

class GalleryPage extends StatelessWidget {
  final String title;
  final List<PhotoState> photoStates;
  final bool tagging;

  final Function toogleTagging;
  final Function onPhotoSelect;

  const GalleryPage(this.title, this.photoStates, this.tagging,
      this.toogleTagging, this.onPhotoSelect,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: GridView.count(
            primary: false,
            crossAxisCount: 2,
            children: List.of(photoStates.map(
                (ps) => Photo(ps, tagging, toogleTagging, onPhotoSelect)))));
  }
}

class Photo extends StatelessWidget {
  final PhotoState state;
  final bool selectable;

  final Function onLongPress;
  final Function onSelect;

  const Photo(this.state, this.selectable, this.onLongPress, this.onSelect,
      {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      GestureDetector(
          child: Image.network(state.url),
          onLongPress: () => onLongPress(state.url)),
    ];
    if (selectable) {
      children.add(Positioned(
          left: 20,
          top: 0,
          child: Theme(
              data: Theme.of(context)
                  .copyWith(unselectedWidgetColor: Colors.grey[200]),
              child: Checkbox(
                  onChanged: (value) {
                    onSelect(state.url, value);
                  },
                  value: state.selected,
                  activeColor: Colors.white,
                  checkColor: Colors.black))));
    }
    return Container(
        padding: EdgeInsets.only(top: 10),
        child: Stack(alignment: Alignment.center, children: children));
  }
}
