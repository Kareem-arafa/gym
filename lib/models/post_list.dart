import 'package:flutter/material.dart';
import 'package:gym/models/video_adapter.dart';
import 'package:gym/ui/screens/post.dart';
import 'package:gym/ui/widgets/footer.dart';
import 'package:gym/ui/widgets/header.dart';
import 'package:gym/ui/widgets/post_body.dart';
import 'package:video_player/video_player.dart';

class PostList {
 /* List<Header> header = [
    Header(
      name: 'Kareem Arafa',
      city: 'Ismailia',
      image: AssetImage('assets/prof.jpg'),
      dateTime: '3/7/2019    6:36PM',
    ),
    Header(
      name: 'Mohamed Hussien',
      city: 'Cairo',
      image: AssetImage('assets/chris.jpg'),
      dateTime: '7/7/2019    1:00AM',
    ),
    Header(
      name: 'Alaa Essam',
      city: 'Alex',
      image: AssetImage('assets/noodles.jpeg'),
      dateTime: '7/7/2019    1:00AM',
    ),
    Header(
      name: 'Reham Arafa',
      city: 'Suez',
      image: AssetImage('assets/second.png'),
    )
  ];
  List<PostBody> body = [
    PostBody(
        body: ChewieListItem(
      videoPlayerController: VideoPlayerController.asset(
        'assets/video.webm',
      ),
      looping: false,
    )),
    PostBody(
      body: Text(
          'Now comes the time to start playing videos. For that Chewie provides its own widget which is, as I\'ve already mentioned, only a wrapper on top of the VideoPlayer which comes directly from the Flutter team.'),
    ),
    PostBody(
        body: ChewieListItem(
      videoPlayerController: VideoPlayerController.asset(
        'assets/video.webm',
      ),
      looping: false,
    )),
    PostBody(
      body: Text(
          'Now comes the time to start playing videos. For that Chewie provides its own widget which is, as I\'ve already mentioned, only a wrapper on top of the VideoPlayer which comes directly from the Flutter team.'),
    ),
  ];
  List<Footer> footer = [
    Footer(
      isBook: false,
      isLove: true,
      num: '752',
    ),
    Footer(
      isBook: true,
      isLove: true,
      num: '6',
    ),
    Footer(
      isBook: false,
      isLove: false,
      num: '23k',
    ),
    Footer(
      isBook: true,
      isLove: false,
      num: '100',
    ),
  ];*/

  List<Post> _post = [
    Post(
      head: Header(
        name: 'Kareem Arafa',
        city: 'Ismailia',
        image: AssetImage('assets/prof.jpg'),
        dateTime: '3/7/2019    6:36PM',
      ),
      body: PostBody(
          body: ChewieListItem(
        videoPlayerController: VideoPlayerController.asset(
          'assets/video.webm',
        ),
        looping: false,
      )),
      footer: Footer(
        isBook: false,
        isLove: true,
        num: '752',
      ),
    ),
    Post(
      head: Header(
        name: 'Mohamed Hussien',
        city: 'Cairo',
        image: AssetImage('assets/chris.jpg'),
        dateTime: '7/7/2019    1:00AM',
      ),
      body: PostBody(
        body: Text(
            'Now comes the time to start playing videos. For that Chewie provides its own widget which is, as I\'ve already mentioned, only a wrapper on top of the VideoPlayer which comes directly from the Flutter team.'),
      ),
      footer: Footer(
        isBook: true,
        isLove: true,
        num: '6',
      ),
    ),
    Post(
      head: Header(
        name: 'Alaa Essam',
        city: 'Alex',
        image: AssetImage('assets/noodles.jpeg'),
        dateTime: '7/7/2019    1:00AM',
      ),
      body: PostBody(
          body: ChewieListItem(
        videoPlayerController: VideoPlayerController.asset(
          'assets/video1.webm',
        ),
        looping: false,
      )),
      footer: Footer(
        isBook: false,
        isLove: false,
        num: '23k',
      ),
    ),
    Post(
      head: Header(
        name: 'Reham Arafa',
        city: 'Suez',
        dateTime:'1/1/2020    12:01PM' ,
        image: AssetImage('assets/second.png'),
      ),
      footer: Footer(
        isBook: true,
        isLove: false,
        num: '100',
      ),
      body:PostBody(
        body: Text(
            'Now comes the time to start playing videos. For that Chewie provides its own widget which is, as I\'ve already mentioned, only a wrapper on top of the VideoPlayer which comes directly from the Flutter team.'),
      )
    )
  ];

  List<Post> getPost(){
    return _post;
  }

}
