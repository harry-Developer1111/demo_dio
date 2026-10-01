import 'package:demo_dio/app_colors/app_colors.dart';
import 'package:demo_dio/core/network/api_service.dart';
import 'package:demo_dio/screens/bottom_screen/homeworkpage/bottomsheetwork/bottomsheetwork.dart';
import 'package:flutter/material.dart';

import '../../../models/products_model.dart';
import '../../../repositories/home_repositary.dart';
class Homeworkpage extends StatefulWidget {
  const Homeworkpage({super.key});

  @override
  State<Homeworkpage> createState() => _HomeworkpageState();
}

class _HomeworkpageState extends State<Homeworkpage> {
  List<ProductModel> phonesList = [];
  List<ProductModel> tabletsList = [];
  List<ProductModel> laptopList = [];

  late final HomeRepositary homeRepositary;

  @override
  void initState() {
    super.initState();
    homeRepositary=HomeRepositary(ApiService());

    getProducts();
  }


  Future<void> getProducts() async {
    try {
      final phones = await homeRepositary.getProducts(
        category: 'phones',
      );

      final tablets = await homeRepositary.getProducts(
        category: 'tablets',
      );

      final laptop = await homeRepositary.getProducts(
        category: 'laptop',
      );

      setState(() {
        phonesList = phones;
        tabletsList = tablets;
        laptopList = laptop;
      });

    } catch (e) {
      print(e);
    }
  }

  Widget productList(List<ProductModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {

        final product = products[index];

        return Card(
          margin: EdgeInsets.all(10),
          child: ListTile(
            title: Text(product.name),

            subtitle: Text(
              "Year: ${product.year}\n"
                  "Price: ${product.price}",
            ),

            trailing: Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }


  Future<void>openBottomSheet()async{
    final result=await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
          return
            SizedBox(
                 height: MediaQuery.of(context).size.height*0.7,
                 child: Bottomsheetwork());
        }
    );

    if(result==true){
      getProducts();
    }

  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 3, 
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.btnAuthClr,
            bottom: const TabBar(
                tabs: [
                  Tab(text: "phones",),
                  Tab(text: "tablets"),
                  Tab(text: "laptop"),
                ]
            ),
          ),
          body: TabBarView(
              children:[
               productList(phonesList),
                productList(tabletsList),
                productList(laptopList),
              ]
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.btnAuthClr,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ), onPressed:openBottomSheet,
              child: Icon(Icons.add),
          ),
        )
    );

  }
}
