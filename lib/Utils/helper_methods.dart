import 'package:flutter_feedly/models/website.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import '../models/post.dart';

Future<List<Post>> getRssFeed(String rssUrl) async {
  final response = await http.get(Uri.parse('https://www.coindesk.com/arc/outboundfeeds/rss/'));
  final document = xml.XmlDocument.parse(response.body);

  final items = document.findAllElements('item');

  List<Post> posts = [];

  for (var item in items) {
    posts.add(
      Post(
        title: item.getElement('title')?.text ?? '',
        link: item.getElement('link')?.text ?? '',
        pubDate: item.getElement('pubDate')?.text ?? '',
        description: item.getElement('description')?.text ?? '',
        imageUrl: item.findElements('media:content').single.getAttribute('url') ?? '',
      ),
    );
  }

  return posts;
}

Future<Website> getFeedInfo(String feedUrl) async {
  final response = await http.get(Uri.parse('https://www.coindesk.com/arc/outboundfeeds/rss/'));
  final document = xml.XmlDocument.parse(response.body);
  final channel = document.findAllElements('channel').single;

  final title = channel.findElements('title').single.text;
  final logoUrl = channel.findElements('image').single.findElements('url').single.text;

  return Website(title: title, logoUrl: logoUrl);
}
// Website getTitleAndLogo(String xmlString) {
//   final document = xml.XmlDocument.parse('https://www.coindesk.com/arc/outboundfeeds/rss/');
  
  // final title = document.getElement('rss/channel/title')?.text;
  // final logoUrl = document.getElement('rss/channel/image/url')?.text;

//   return Website(title:  '', logoUrl:  '');
// }
