import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_demo/utils/style.dart';
import '../utils/globals.dart';
import '../utils/ui_helper.dart';
import '../widgets/my_bottom_nav.dart';
import '../widgets/post_widget.dart';
import '../widgets/story_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference _reference = FirebaseFirestore.instance.collection('user_post');

  String imageUrl = '';
  final int _currentIndex = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Instagram',
            style: Styles.headingStyle2()),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              var result = await storageImage(
                  imageUrl: imageUrl
              );
              if(result != null){
                Map<String, dynamic> dataToSend = {
                  'image': result,
                  'like' : false,
                  'likeCount' : 0,
                  'setLike' : false
                };
                _reference.add(dataToSend);
                setState(() {
                  isLoading = false;
                });
                Fluttertoast.showToast(msg: 'Post added successfully!');
              }else{
                ScaffoldMessenger.of(context)
                    .showSnackBar(const
                SnackBar(content: Text('Please upload an image')));
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(
                  Icons.add_box_outlined,
                  size: 27,
                  color: Colors.black),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10.0),
            child: const Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black),
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(_currentIndex),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StoriesWidget(),
              const Divider(),
              if(isLoading)
                const Center(
                  child:
                  SpinKitCircle(
                    color: Globals.primary,
                    size: 35,
                  ),
                ),
              const PostWidget()
            ],
          ),
        ),
      ),
    );
  }
}