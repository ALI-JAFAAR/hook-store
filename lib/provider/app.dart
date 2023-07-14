import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../models/Product.dart';
import '../models/cart.dart';
import '../models/cat.dart';
import '../models/cus.dart';
import '../screens/home/home_screen.dart';

class AppProvider extends ChangeNotifier {
  Api api = Api();
  late SnackBar snackBar;
  List<CartItem> cartitem = [];
  bool login = false;
  var userdata;
  // serch var
  bool searchwaiting = true;
  int searchcount = 0;
  var searchitem;





  int catAcount = 0;
  bool catAwaiting = true;
  var catA;
  category_all() async {
    if ( catAwaiting == false) {
    } else {
      catAwaiting = true;
   

      final response = await api.getData('cats-all');
      print(response.statusCode);
      if (response.statusCode == 200) {
        var datas = json.decode(response.body);
        if (datas["success"] == true) {
          var slidesdata = catFromJson(response.body);
          print(
              "CATS fethed successfully and count of them = ${slidesdata.data.length}");
          catAcount = slidesdata.data.length;
          catAwaiting = false;
          catA = slidesdata.data;

          notifyListeners();
        } else {
          print("error fitching  cats");
        }
      }
    }
  }



  //################ Products ##########
  int page_id = 0;
  int prodC = 0;
  bool prodwa = true;
  var prods;

  prod_by_page(id) async {
    if (page_id == id  ) {
    } else {
      prodwa = !prodwa;
      final response = await api.getData('prod-cat/$id');
      notifyListeners();
      if (response.statusCode == 200) {
        var datas = json.decode(response.body);
        if (datas["success"] == true) {
          var prodss = productsFromJson(response.body);
          print(
              "Prod by Page fethed successfully and count of them = ${prodss.data.length}");
          prodC = prodss.data.length;
          prods = prodss.data;
          print(prods[0].name);
          prodwa = false;
          page_id = id;
          notifyListeners();
        } else {
          print("error fitching  Product");
        }
      }
    }
  }















  createaccount(BuildContext context, String name, String password, String phone) async {
    var data = {
      "name": name,
      "password": password,
      "phone": phone,
    };
    final response = await api.postData(data, 'cus-signup');
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      print(response.body);
      var logindata = customerFromJson(response.body);

      if (datas["success"] == false) {
        snackbar(context, "حدث خطا ما");
      } else {
        userdata = logindata.data;
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setInt('id', userdata.id);
        localStorage.setString('name', userdata.name);
        localStorage.setString('phone', userdata.phone);
        snackbar(context, "مرحبا بك ${userdata.name}");
        login = true;
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  HomeScreen()),
        );
      }
    } else {
      print(response.body);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  HomeScreen()),
    );
  }


  userlogin(BuildContext context, pass, phone) async {
    var data = {
      "password": pass,
      "phone": phone,
    };
    final response = await api.postData(data, 'cus-login');
    if (response.statusCode == 200) {
      var datas = json.decode(response.body);
      print(response.body);
      var logindata = customerFromJson(response.body);

      if (datas["success"] == false) {
        snackbar(context, "حدث خطا ما");
      } else {
        userdata = logindata.data;
        print("user login data ${logindata.data}");
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setInt('id', userdata.id);
        localStorage.setString('name', userdata.name);
        localStorage.setString('phone', userdata.phone);
        snackbar(context, "مرحبا بك ${userdata.name}");
        login = true;
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  HomeScreen()),
        );
      }
    } else {
      print(response.body);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  HomeScreen()),
    );
  }

  check_login(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (login == true) {
    } else {
      if (localStorage.getInt('id') != null) {
        Data da = Data(
          name: localStorage.getString('name'),
          id: localStorage.getInt('id'),
          phone: localStorage.getString('phone'),
        );
        userdata = da;
        login = true;
        snackbar(context, "مرحبا بك مجددا");
        print("user login id = ${userdata.id}");
        notifyListeners();
      }
    }
  }

  logout(context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('id');
    localStorage.remove('name');
    localStorage.remove('phone');
    localStorage.remove('address');
    login = false;
    snackbar(context, "تم تسجيل الخروج");
    notifyListeners();
  }

  void add_item(ids, name, img, price, context) {
    CartItem item = CartItem(
        id: ids.toString(),
        name: name.toString(),
        price: price.toString(),
        img: img.toString());

    for (int i = 0; i < cartitem.length; i++) {
      if (cartitem[i].id == item.id ) {
        print("old = ${cartitem[i].id}   new = ${item.id}");
        snackbar(context, "هذا المنتج تم اضافتة الى العربة مسبقا");
        return;
      }

      if ( cartitem[i].id == item.id) {
        snackbar(context, "تم تحديث الكمية المطلوبه من المنتج");
        notifyListeners();
        return;
      }
    }
    cartitem.add(item);
    snackbar(context, "تم اضافة المنتج الى العربة");
    notifyListeners();
  }

  remove_item(index) {
    cartitem.removeAt(index);
    notifyListeners();
  }
  int total_price() {
    int sum = 0;
    for (int i = 0; i < cartitem.length; i++) {
      sum += int.parse(cartitem[i].price);
    }
    return sum;
  }

  del_account(context,id) async {

      final response = await api.getData('cus-del/$id');
      print(response.statusCode);
      if (response.statusCode == 200) {
        var datas = json.decode(response.body);

        if (datas["success"] == true) {
          snackbar(context,"تم حذف الحساب لدينا يمكنك الان انشاء حساب جديد");
          logout(context);
          notifyListeners();
        } else {
          print("error delet account");
        }
      }
  }

  search_reset(){
    searchwaiting = true;
    notifyListeners();
  }

  void send_order(name,phone, total, address, id, context) async {
    var data = {
      "cus_name": name,
      "cus_id": id,
      "phone": phone,
      "total": total,
      "address": address,
      "items": cartitem
    };

    print(data);
    final response = await api.postData(data, 'order');
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body == "product saved") {
        snackbar(context,
            "تم ارسال الطلب بنجاح  سوف نقوم بالتواصل معك على رقم هاتفك الشخصي");
        cartitem.clear();
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  HomeScreen()),
        );
      }
    } else {
      print(response.statusCode);
    }
  }

  void snackbar(context, String text) {
    snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}