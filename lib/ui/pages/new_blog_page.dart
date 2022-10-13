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
  final imageUrlController = TextEditingController();
  final videoUrlController = TextEditingController();

  final form_key = GlobalKey<FormState>();

  String? dropdownCategoryId;

  var catIdList = [
    '1',
    '2',
    '3',
    '4',
  ];

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    slugController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    imageUrlController.dispose();
    videoUrlController.dispose();
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
            ), //title
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
            ), //subtitle
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
            ), //slug
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
            ), //description
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: 'Date(yyyy-MM-dd)',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
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
                ),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  flex: 1,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Category Id',
                          ),
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          value: dropdownCategoryId,
                          items: catIdList
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category id';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              dropdownCategoryId = val;
                            });
                          }),
                    ),
                  ),
                ),
              ],
            ), //date and category id
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image url',
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
              controller: videoUrlController,
              decoration: InputDecoration(
                labelText: 'Video url',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveBlog() async {
    if (form_key.currentState!.validate()) {
      final blogDataModel = BlogData(
        title: titleController.text,
        categoryId: dropdownCategoryId ?? '1',
        image: imageUrlController.text,
        video: videoUrlController.text,
        subTitle: subtitleController.text,
        slug: slugController.text,
        description: descriptionController.text,
        date: dateController.text,
      );

      await Provider.of<BlogProvider>(context, listen: false)
          .createBlog(blogDataModel);
      Navigator.pop(context, blogDataModel);

      // print(blogDataModel.toString());
    }
  }
}
