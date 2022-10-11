import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../models/blog_model.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({Key? key}) : super(key: key);
  static const String routeName = '/blog_details_page';

  @override
  Widget build(BuildContext context) {
    final blogDataModel =
        ModalRoute.of(context)!.settings.arguments as BlogData;
    return Scaffold(
      body: NestedScrollView(
        dragStartBehavior: DragStartBehavior.start,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // pinned: true,
              floating: false,
              centerTitle: false,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                title: Text(blogDataModel.title!),
                background:
                    blogDataModel.image == null || blogDataModel.image!.isEmpty
                        ? Image.asset(
                            'assets/images/placeholder.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            blogDataModel.image!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
              ),
              expandedHeight: 200,
            ),
          ];
        },
        body:
            SafeArea(child: Text('description: ${blogDataModel.description}')),
      ),
    );
  }
}
// SliverAppBar(
//   pinned: true,
//   floating: false,
//   flexibleSpace: FlexibleSpaceBar(
//     title: Text(blogDataModel.title!),
//     centerTitle: false,
//     background:
//     blogDataModel.image == null || blogDataModel.image!.isEmpty
//         ? Image.asset(
//       'assets/images/placeholder.png',
//       width: double.infinity,
//       height: 200,
//       fit: BoxFit.cover,
//     )
//         : Image.network(
//       blogDataModel.image!,
//       width: double.infinity,
//       height: 200,
//       fit: BoxFit.cover,
//     ),
//   ),
//   expandedHeight: 200,
// ),
