//import 'dart:html';

import 'package:flutter/material.dart';

class Massenger extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://4.bp.blogspot.com/-5IynLL8mNus/W2NS6BBY_qI/AAAAAAAACxY/csdiNrDp3g0HhA7YmlXDl0KY-xq5vaH2wCLcBGAs/w1200-h630-p-k-no-nu/levi%2Battack%2Bon%2Btitan%2Bseason%2B3.jpg'),
            ),
            SizedBox(width: 10,),
            Text('Chats'
              , style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700
              ),),
          ],
        ),
        actions: [
          IconButton(onPressed: (){},
            icon: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.camera_alt,
                size: 14.0,
                color: Colors.white,
              ),
            ),),
          IconButton(onPressed: (){},
            icon: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.edit,
                size: 14.0,
                color: Colors.white,
              ),
            ),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[400],
              ),
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                      Icons.search
                  ),
                  SizedBox(width: 15,),
                  Text('Search'),

                ],
              ),
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://i1.sndcdn.com/avatars-PpVzWFrA6zsloJDc-5sROvQ-t500x500.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text('Eren',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://sportshub.cbsistatic.com/i/2021/03/18/05574ba9-dea5-4761-b2fb-e8a4a19b0a9c/attack-on-titan-sasha-cosplay-1255344.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text('Sasha',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://i.kym-cdn.com/photos/images/original/001/105/343/75f.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text('Mikasa',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://qph.cf2.quoracdn.net/main-qimg-393cf814ac96cdc22e29ba515204acab-pjlq'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text('Jean',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://pbs.twimg.com/media/FMFO5wZVIAMpwHo.jpg:large'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text('annie',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://sportshub.cbsistatic.com/i/2022/02/15/9b166b0e-b092-4e90-85ac-e5e16ba00600/attack-on-titan-armin.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text('Armin',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://pbs.twimg.com/media/EpkISgEVQAAV9Pj.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text('Reiner',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://www.meme-arsenal.com/memes/5b0ad8ffe3276c60d7c76f7aafbaf899.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(height: 7,),
                        Text('Hanji',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://sportshub.cbsistatic.com/i/2022/02/15/9b166b0e-b092-4e90-85ac-e5e16ba00600/attack-on-titan-armin.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Armin',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text('هل لديك خطة ؟',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                  Text('02:00 PM')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://i.kym-cdn.com/photos/images/original/001/105/343/75f.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mikasa',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text('ايريه',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                  Text('02:00 PM')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://www.meme-arsenal.com/memes/5b0ad8ffe3276c60d7c76f7aafbaf899.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),

                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Jean',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text('بحبك ♥',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                  Text('02:00 PM')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://i1.sndcdn.com/avatars-PpVzWFrA6zsloJDc-5sROvQ-t500x500.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Eren',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text('كتفمك ',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                  Text('02:00 PM')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://pbs.twimg.com/media/FMFO5wZVIAMpwHo.jpg:large'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Annie',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text('😂😂😂😂😂😂😂😂',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                  Text('02:00 PM')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://sportshub.cbsistatic.com/i/2021/03/18/05574ba9-dea5-4761-b2fb-e8a4a19b0a9c/attack-on-titan-sasha-cosplay-1255344.jpg'),

                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.green[600],
                            ),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sasha',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text('عايزه اكل بطاطا',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                  Text('02:00 PM')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//import 'dart:html';


class massenger extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://4.bp.blogspot.com/-5IynLL8mNus/W2NS6BBY_qI/AAAAAAAACxY/csdiNrDp3g0HhA7YmlXDl0KY-xq5vaH2wCLcBGAs/w1200-h630-p-k-no-nu/levi%2Battack%2Bon%2Btitan%2Bseason%2B3.jpg'),
            ),
            SizedBox(width: 10,),
            Text('Chats'
              , style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700
              ),),
          ],
        ),
        actions: [
          IconButton(onPressed: (){},
            icon: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.camera_alt,
                size: 14.0,
                color: Colors.white,
              ),
            ),),
          IconButton(onPressed: (){},
            icon: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                Icons.edit,
                size: 14.0,
                color: Colors.white,
              ),
            ),),
        ],
      ),
      body:  Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[400],
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                          Icons.search
                      ),
                      SizedBox(width: 15,),
                      Text('Search'),

                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder:(context, index) => SizedBox(width : 20),
                    itemBuilder : (context, index) =>buildStoryItem(),
                    itemCount: 20,
                  ),
                ),
                SizedBox(height: 20,),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index) => buildChatItem(),
                  separatorBuilder: (context , index) => SizedBox(height: 20,),
                  itemCount: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  buildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://sportshub.cbsistatic.com/i/2022/02/15/9b166b0e-b092-4e90-85ac-e5e16ba00600/attack-on-titan-armin.jpg'),

          ),
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor: Colors.green[600],
          ),
        ],
      ),
      SizedBox(width: 15,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Armin',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: Text('هل لديك خطة ؟',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
                Text('02:00 PM')
              ],
            ),
          ],
        ),
      ),
    ],
  );
  buildStoryItem() =>  Container(
    width: 60,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://i1.sndcdn.com/avatars-PpVzWFrA6zsloJDc-5sROvQ-t500x500.jpg'),

            ),
            CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
            ),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green[600],
            ),
          ],
        ),
        SizedBox(height: 7,),
        Text('Eren',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,),
      ],
    ),
  );
}

