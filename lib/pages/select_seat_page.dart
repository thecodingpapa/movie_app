import 'package:flutter/material.dart';
import 'package:movie_app/data/movie_model.dart';
import 'package:movie_app/helpers/image_path_helper.dart';
import 'package:vector_math/vector_math_64.dart' show degrees2Radians;

const ROTATE_X = 85.0;
const SKEW_X = 0.075;

class SelectSeatPage extends StatefulWidget {
  final MovieModel movieModel;
  List<List<bool>> selected = <List<bool>>[];
  SelectSeatPage(
    this.movieModel, {
    Key key,
  }) : super(key: key);

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  double xRotation = 0.0;
  double xSkew = 0.0;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {
          xRotation = ROTATE_X * _animationController.value;
          xSkew = SKEW_X * _animationController.value;
        });
      });
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    Tween().animate(_animation);
    super.initState();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      List<bool> bools = [];
      for (int j = 0; j < 20; j++) {
        bools.add(false);
      }
      widget.selected.add(bools);
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          widget.movieModel.originalTitle,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 100,
                left: 16,
                right: 16,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 20,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: List.generate(200, (index) {
                    int column = (index % 20).toInt();
                    int row = (index ~/ 20);

                    return Checkbox(
                        checkColor: Colors.blueGrey,
//                      activeColor: Colors.grey[800],
                        value: widget.selected[row][column],
                        onChanged: (selected) {
                          setState(() {
                            widget.selected[row][column] = selected;
                          });
                        });
                  }),
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                top: 32,
                child: Transform(
                  transform: (Matrix4.identity()
                        ..setEntry(3, 2, 0.0005)
                        ..rotateX(xRotation * degrees2Radians)) *
                      Matrix4.skewX(xSkew),
                  child: Hero(
                    tag: widget.movieModel.posterPath,
                    child: Image.network(
                      buildImagePath(widget.movieModel.posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: FlatButton(
                  onPressed: () {},
                  color: Colors.redAccent,
                  child: Text(
                    'CHECKOUT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
