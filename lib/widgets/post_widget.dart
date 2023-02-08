import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/style.dart';
import '../utils/ui_helper.dart';


class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);


  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late Stream<QuerySnapshot> _stream;
  final CollectionReference _reference = FirebaseFirestore.instance.collection('user_post');

  @override
  void initState() {
    _stream = _reference.snapshots();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Some error occurred ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot.docs;
          List<Map> items = documents.map((e) =>
          {
            'id': e.id,
            'image': e['image'],
            'like': e['like'],
            'likeCount' : e['likeCount'],
            'setLike' : e['setLike']
          }).toList();
          return items.isNotEmpty ?
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                Map thisItem = items[index];
                return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage: AssetImage('assets/userImage.jpg'),
                            ),
                            SizedBox(width: 10.0),
                            Text('user_name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: () async {
                          DocumentReference _ref = _reference.doc(thisItem['id']);
                          Map<String, dynamic> dataToSend = {
                            'setLike' : true,
                            'like' : true,
                            'likeCount' : thisItem['like'] == false ? thisItem['likeCount'] + 1
                                : thisItem['likeCount']
                          };
                          await _ref.update(dataToSend);
                          Future.delayed(const Duration(milliseconds: 750), (){
                            Map<String, dynamic> dataToSend = {
                              'setLike' : false,
                            };
                            _ref.update(dataToSend);
                          });
                        },
                        child: thisItem['setLike'] == true ? Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/loading.gif'),
                                  fit: BoxFit.cover
                                )
                              ),
                              child: Image.network(thisItem['image'],
                                  fit: BoxFit.cover),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                child: const Center(child: Icon(FontAwesomeIcons.solidHeart, color: Colors.white, size: 80.0))
                            ),
                          ],
                        ) : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/loading.gif'),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: Image.network(thisItem['image'],
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                DocumentReference _ref = _reference.doc(thisItem['id']);
                                Map<String, dynamic> dataToSend = {
                                  'like' : thisItem['like'] == true ? false : true,
                                  'likeCount' : thisItem['like'] == false ? thisItem['likeCount'] + 1
                                      : thisItem['likeCount'] - 1
                                };
                                _ref.update(dataToSend);
                              },
                              child: thisItem['like'] == true ?
                              const Icon(FontAwesomeIcons.solidHeart, color: Colors.red, size: 25.0)
                                  : const Icon(FontAwesomeIcons.heart, size: 25.0),
                            ),
                            const SizedBox(width: 15.0),
                            InkWell(
                              onTap: () async {
                                UiHelper.openLoadingDialog(context,'Please Wait');
                                final uri = Uri.parse(thisItem['image']);
                                final res = await http.get(uri);
                                final bytes = res.bodyBytes;
                                final temp = await getTemporaryDirectory();
                                final path = '${temp.path}/image.jpg';
                                File(path).writeAsBytesSync(bytes);
                                Navigator.pop(context);
                                await Share.shareFiles([
                                  path
                                ], text: 'XYZ shared Instagram post');
                              },
                                child: const Icon(FontAwesomeIcons.paperPlane, size: 25.0)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text('${thisItem['likeCount']} likes',
                            style: Styles.headingStyle4(
                              isBold: true
                            )),
                      ),
                    ],
                  ),
                );
              }) : Center(
            child: Text('No post available',
            style: Styles.headingStyle5(
              isBold: true
            ),)
          );
        }
        return Container();
      },
    );
  }
}