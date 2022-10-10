import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewBlogPage extends StatefulWidget {
  const NewBlogPage({Key? key}) : super(key: key);

  static const String routeName = '/new_blog_page';

  @override
  State<NewBlogPage> createState() => _NewBlogPageState();
}

class _NewBlogPageState extends State<NewBlogPage> {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final slugController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  final form_key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    slugController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
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
      final blogDataModel = BlogData(
        title: titleController.text,
        categoryId: '2',
        image: null,
        video: null,
        subTitle: subtitleController.text,
        slug: slugController.text,
        description: descriptionController.text,
        date: dateController.text,
      );

      Provider.of<BlogProvider>(context, listen: false)
          .createBlog(blogDataModel);
      Navigator.pop(context);

      // print(blogDataModel.toString());
    }
  }
}
