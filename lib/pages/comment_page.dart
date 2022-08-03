import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinterest/controller/comment_controller.dart';
import 'package:pinterest/widgets/comment_widget.dart';


class CommentPage extends StatelessWidget {
  const CommentPage({Key? key, collection}) : super(key: key);

  static const String id = "CommentPage";


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GetBuilder<CommentController>(
        init: CommentController(),
        builder: (CommentController controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            toolbarHeight: 58,
            bottom: PreferredSize(
                preferredSize: const Size(200, 0),
                child:Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: TabBar(
                          onTap: (int index){
                            controller.pageIndex = index;
                          },
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          tabs: [
                            Container(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Updates',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              height: 40,
                              alignment: Alignment.center,
                            ),

                            Container(
                              alignment: Alignment.center,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Messages',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              height: 40,
                            ),
                          ],
                          // controller: _tabsController,
                        ),
                      ),
                    ),

                    Expanded(
                        flex: 1,
                        child: IconButton(onPressed: (){}, icon: const Icon(Icons.share, color: Colors.black,)))
                  ],
                )
            ),
          ),
          body: CommentWidget(controller: controller,),
        ),
      ),
    );
  }

}