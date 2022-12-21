import 'package:flutter/material.dart';
import 'package:instagram_demo/utils/ui_helper.dart';
import 'package:story_view/story_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/style.dart';
import 'package:instagram_demo/utils/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryViewScreen extends StatefulWidget {
  final Map itemData;
  const StoryViewScreen(this.itemData, {Key? key}) : super(key: key);


  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}
class _StoryViewScreenState extends State<StoryViewScreen> {
  final controller = StoryController();
  final CollectionReference _reference = FirebaseFirestore.instance.collection('user_stories');
  late Map data;

  @override
  Widget build(BuildContext context) {
    var kHeight = UiHelper.getSize(context).height;
    var kWidth = UiHelper.getSize(context).width;
    return Material(
      child: Stack(
                children: [
                  StoryView(
                    storyItems: [
                      StoryItem.pageProviderImage(NetworkImage(widget.itemData['image']))
                    ],
                    onComplete: () {
                      Navigator.pop(context);
                    },
                    onVerticalSwipeComplete: (direction) {
                      if (direction == Direction.down) {
                        Navigator.pop(context);
                      }
                    },
                    controller: controller,
                    inline: false,
                    repeat: false,
                  ),
                  Positioned(
                    top: kHeight * 0.08,
                    left: 10,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/userImage.jpg'),
                        ),
                        SizedBox(
                          width: kWidth * 0.03,
                        ),
                        Text('user_name',
                          style: Styles.headingStyle5(
                              isBold: true,
                              color: Colors.white
                          ),)
                      ],
                    ),
                  ),
                  Positioned(
                    bottom : 20,
                    left: 10,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: kWidth / 1.4,
                          height: kHeight * 0.05,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Send message',
                              labelStyle: Styles.headingStyle5(
                                  isBold: true,
                                  color: Colors.white
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(width: 0, color: Colors.white),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: InkWell(
                            onTap: () async {
                              DocumentReference _ref = _reference.doc(widget.itemData['id']);
                              Map<String, dynamic> dataToSend = {
                                'like' : widget.itemData['like'] == true ? false : true,
                              };
                              setState(() {
                                widget.itemData['like'] = widget.itemData['like'] == true ? false : true;
                              });
                              _ref.update(dataToSend);
                              Navigator.pop(context);
                            },
                            child: widget.itemData['like'] == true ?
                            const Icon(FontAwesomeIcons.solidHeart, color: Colors.red, size: 25.0) :
                            const Icon(FontAwesomeIcons.heart, size: 25.0,color: Colors.white),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right : 15.0),
                          child: Icon(FontAwesomeIcons.paperPlane, size: 25.0,color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}