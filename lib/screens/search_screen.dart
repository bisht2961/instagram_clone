import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool showUsers = false;
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
            labelText: 'Search for a user',
          ),
          onFieldSubmitted: (String _) {
            print(_searchController.text);
            showUsers = true;
            setState(() {});
          },
        ),
      ),
      body: showUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: _searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                              uid: (snapshot.data! as dynamic).docs[index]
                                  ['uid']))),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoUrl']),
                        ),
                        title: Text((snapshot.data! as dynamic).docs[index]
                            ['username']),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      (snapshot.data! as dynamic).docs[index]['postUrl'],
                      fit: BoxFit.cover,
                    );
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                    (index % 7 == 0 ? 2 : 1),
                    (index % 7 == 0 ? 2 : 1),
                  ),
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                );
              }),
    );
  }
}
