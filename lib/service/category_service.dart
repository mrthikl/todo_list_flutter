import 'package:todo_app/models/category.dart';
import 'package:todo_app/repositories/repository.dart';

class CategoryService {
  Repository? _repository;

  CategoryService() {
    _repository = Repository();
  }

  // create data
  saveCategory(Category category) async {
    return await _repository!.insertData('categories', category.CategoryMap());
  }

  // update data from table by id
  updateCategory(Category category) async {
    return await _repository!.updateData('categories', category.CategoryMap());
  }

  // delete data from table by id
  deleteCategory(categoryId) async {
    return await _repository!.deleteData('categories', categoryId);
  }

  // read data from table
  readCategories() async {
    return await _repository!.readData('categories');
  }

  //  read data from table by id
  readCategoryById(categoryId) async {
    return await _repository!.readDataById('categories', categoryId);
  }
}
