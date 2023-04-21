import 'package:flutter/material.dart';
import 'package:flutter_feedly/Utils/helper_methods.dart';
import 'package:flutter_feedly/Utils/utils.dart';
import 'package:flutter_feedly/search/website_search.dart';
import 'package:xml/xml.dart' as xml;

import '../models/post.dart';
import '../models/website.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _searchQuery = '';

  final List<Post> _posts = [];
  final List<Website> _websites = [];
  List<String> _results = [];
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Feedly'),
      ),
      drawer: Drawer(
        child: ListView.separated(
          itemCount: _websites.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: SizedBox(
                height: 50,
                width: 50,
                child: Image.network(
                  _websites[index].logoUrl,
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(_websites[index].title),
            );
          },
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _inputController,
            onSubmitted: (input) {
              setState(() {
                _searchQuery = input;
              });
            },
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(),
              hintText: 'Website URL',
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                if (_searchQuery.isNotEmpty) {
                  final List<String> results = await WebsiteSearch.search(_searchQuery);
                  setState(() {
                    _results.clear();
                    _results.addAll(results);
                  });
                  // final posts = await getRssFeed(_inputController.text.trim());

                  // if (posts.isNotEmpty) {
                  //   final Website website = await getFeedInfo('');

                  //   setState(() {
                  //     _posts.addAll(posts);
                  //     _websites.add(website);
                  //   });
                  // }
                }
              } catch (e) {
                Utils.showSnackBar(e.toString());
              }
            },
            child: const Text('Print RSS'),
          ),
          const SizedBox(
            height: 24,
          ),

          Expanded(
            child: ListView.separated(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                return Text(_results[index]);
              },
              separatorBuilder: (context, index) => const Divider(thickness: 2, color: Colors.black54),
            ),
          )
          // Expanded(
          //   child: ListView.separated(
          //     itemCount: _posts.length,
          //     itemBuilder: (context, index) {
          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SizedBox(
          //             height: 250,
          //             width: double.infinity,
          //             child: Image.network(
          //               _posts[index].imageUrl,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           Text(
          //             _posts[index].title,
          //             // maxLines: 1,
          //             // overflow: TextOverflow.ellipsis,
          //             style: theme.textTheme.titleMedium,
          //           ),
          //           // Text(
          //           //   _posts[index].description,
          //           //   maxLines: 2,
          //           //   style: theme.textTheme.bodyMedium,
          //           // ),
          //         ],
          //       );
          //     },
          //     separatorBuilder: (context, index) => const Divider(thickness: 2, color: Colors.black54),
          //   ),
          // )
        ],
      ),
    );
  }
}
