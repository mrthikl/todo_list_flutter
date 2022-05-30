import 'package:flutter/material.dart';
import 'package:todo_app/models/category.dart';
import 'package:todo_app/service/category_service.dart';
import 'package:todo_app/src/app.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();
  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  var category;
  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = <Category>[];

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = <Category>[];
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _EditCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text =
          category[0]['name'] ?? ['No Name'].toString();
      _editCategoryDescriptionController.text =
          category[0]['description'] ?? ['No Description'].toString();
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (parem) {
          return AlertDialog(
            actions: [
              FlatButton(
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    _category.name = _categoryNameController.text;
                    _category.description = _categoryDescriptionController.text;
                    var result = await _categoryService.saveCategory(_category);
                    if (result > 0) {
                      print(result);
                      Navigator.pop(context);
                      getAllCategories();
                      _showSuccessSnackBar(Text('Saved'));
                    }
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
            title: Text('Categories Form'),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Write a category',
                    labelText: 'Category',
                  ),
                ),
                TextField(
                  controller: _categoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Write a Description',
                    labelText: 'Description',
                  ),
                ),
              ],
            )),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (parem) {
          return AlertDialog(
            actions: [
              FlatButton(
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _editCategoryNameController.text;
                    _category.description =
                        _editCategoryDescriptionController.text;
                    var result =
                        await _categoryService.updateCategory(_category);
                    if (result > 0) {
                      print(result);
                      Navigator.pop(context);
                      getAllCategories();
                      _showSuccessSnackBar(Text('Updated'));
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
            title: Text('Edit Categories Form'),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Edit a category',
                    labelText: 'Category',
                  ),
                ),
                TextField(
                  controller: _editCategoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Edit a Description',
                    labelText: 'Description',
                  ),
                ),
              ],
            )),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (parem) {
          return AlertDialog(
            actions: [
              FlatButton(
                  color: Colors.green,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton(
                  color: Colors.red,
                  onPressed: () async {
                    var result =
                        await _categoryService.deleteCategory(categoryId);
                    if (result > 0) {
                      print(result);
                      Navigator.pop(context);
                      getAllCategories();
                      _showSuccessSnackBar(Text('Deleted'));
                    }
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
            title: Text('Are you sure you want delete this?}'),
          );
        });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState!.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: _categoryList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                child: Card(
                  elevation: 8,
                  child: ListTile(
                    leading: IconButton(
                        onPressed: () {
                          _EditCategory(context, _categoryList[index].id);
                        },
                        icon: Icon(Icons.edit)),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_categoryList[index].name.toString()),
                        IconButton(
                            color: Colors.red,
                            onPressed: () {
                              _deleteFormDialog(
                                  context, _categoryList[index].id);
                            },
                            icon: Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
