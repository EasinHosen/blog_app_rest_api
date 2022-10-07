import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/blog_model.dart';
import '../../provider/blog_provider.dart';

class UpdateBlogPage extends StatefulWidget {
  const UpdateBlogPage({Key? key}) : super(key: key);

  static const String routeName = '/create_blog_page';

  @override
  State<UpdateBlogPage> createState() => _UpdateBlogPageState();
}

class _UpdateBlogPageState extends State<UpdateBlogPage> {
  late BlogData blogDataModel;
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final slugController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final categoryIdController = TextEditingController();

  final form_key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    slugController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    categoryIdController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    blogDataModel = ModalRoute.of(context)!.settings.arguments as BlogData;

    titleController.text = blogDataModel.title! ?? '';
    subtitleController.text = blogDataModel.subTitle! ?? '';
    slugController.text = blogDataModel.slug! ?? '';
    descriptionController.text = blogDataModel.description! ?? '';
    dateController.text = blogDataModel.date! ?? '';
    categoryIdController.text = blogDataModel.categoryId! ?? '';

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new blog'),
        actions: [
          TextButton(
            onPressed: _saveBlog,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: form_key,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Blog title',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is required!';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: subtitleController,
              decoration: InputDecoration(
                labelText: 'Subtitle',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: slugController,
              decoration: InputDecoration(
                labelText: 'Slug',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 2,
              maxLines: 5,
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please provide a description';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.datetime,
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date(yyyy-MM-dd)',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date is required!';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _saveBlog() {
    if (form_key.currentState!.validate()) {
      final blogDataModel2 = BlogData(
        id: blogDataModel.id,
        status: blogDataModel.status,
        createdAt: blogDataModel.createdAt,
        createdBy: blogDataModel.createdBy,
        image: blogDataModel.image,
        updatedAt: blogDataModel.updatedAt,
        updatedBy: blogDataModel.updatedBy,
        video: blogDataModel.video,
        categoryId: categoryIdController.text,
        title: titleController.text,
        subTitle: subtitleController.text,
        slug: slugController.text,
        description: descriptionController.text,
        date: dateController.text,
      );

      print(blogDataModel2.toString());

      Provider.of<BlogProvider>(context, listen: false)
          .updateBlog(blogDataModel2);
      Navigator.pop(context);

      // print(blogDataModel.toString());
    }
  }
}
