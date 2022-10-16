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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
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
          SliverFillRemaining(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('description: ${blogDataModel.description}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('date: ${blogDataModel.date}'),
                ],
              ),
            ),
          )
        ],
        // body: SafeArea(
        //   child: Text('description: ${blogDataModel.description}'),
        // ),
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
