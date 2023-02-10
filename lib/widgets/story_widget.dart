import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/story_view_screen.dart';
import '../utils/globals.dart';
import '../utils/style.dart';
import '../utils/ui_helper.dart';


class StoriesWidget extends StatefulWidget {
  const StoriesWidget({Key? key}) : super(key: key);

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget> {
  late Stream<QuerySnapshot> _stream;
  final CollectionReference _reference = FirebaseFirestore.instance.collection('user_stories');
  String imageUrl = '';
  bool isLoading = false;
  late Map data;

  @override
  void initState() {
    _stream = _reference.snapshots();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var kHeight = UiHelper.getSize(context).height;
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
          }).toList();
          return Container(
            color: Colors.white,
            height: kHeight * 0.15,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
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
                            'like' : false
                          };
                          await _reference.add(dataToSend);
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(msg: 'Story added successfully!');
                        }else{
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const
                          SnackBar(content: Text('Please upload an image')));
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              SizedBox(
                                height: 80.0,
                                child: ClipOval(
                                    child: Image.asset(
                                      "assets/userImage.jpg",
                                      fit: BoxFit.cover,
                                      width: 80.0,
                                    )
                                ),
                              ),
                              Positioned(
                                  bottom: -1.0,
                                  right: -1.0,
                                  child: Stack(
                                    children: const <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 10.0,
                                      ),
                                      Icon(Icons.add_circle, size: 20.0, color: Colors.blue),
                                    ],
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kHeight * 0.01,
                          ),
                          Text('Add Story',
                          style: Styles.headingStyle6(
                            isBold: true
                          ),)
                        ],
                      ),
                    ),
                  ),
                  if(isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: SpinKitCircle(
                      color: Globals.primary,
                      size: 35,
                    ),
                  ),
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map thisItem = items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => StoryViewScreen(
                                    items[index]
                                  )));
                                },
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: const AssetImage('assets/loading.gif'),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(thisItem['image']),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: kHeight * 0.01,
                              ),
                              Text('user_name',
                                style: Styles.headingStyle6(
                                    isBold: true
                                ),)
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
