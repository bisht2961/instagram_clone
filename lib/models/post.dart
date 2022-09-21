import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postId;
  final String username;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.uid,
    required this.description,
    required this.postId,
    required this.username,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "postId": postId,
        "postUrl": postUrl,
        "description": description,
        "profImage": profImage,
        "likes": likes,
        'datePublished': datePublished,
      };

  // static User fromSnapshot(DocumentSnapshot snapshot) {
  //   var snapshotData = snapshot.data() as Map<String, dynamic>;
  //   return User(
  //     username: snapshotData['username'],
  //     email: snapshotData['email'],
  //     photoUrl: snapshotData['photoUrl'],
  //     bio: snapshotData['bio'],
  //     followers: snapshotData['followers'],
  //     following: snapshotData['following'],
  //     uid: snapshotData['uid'],
  //   );
  // }
}
