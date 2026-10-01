import 'package:demo_dio/app_colors/app_colors.dart';
import 'package:demo_dio/core/network/api_service.dart';
import 'package:demo_dio/repositories/home_repositary.dart';
import 'package:flutter/material.dart';
class Bottomsheetwork extends StatefulWidget {
  const Bottomsheetwork({super.key});

  @override
  State<Bottomsheetwork> createState() => _BottomsheetworkState();
}

class _BottomsheetworkState extends State<Bottomsheetwork> {

 String selectedCategory='phones';
 final formKey=GlobalKey<FormState>();

 final nameController = TextEditingController();
 final priceController = TextEditingController();
 final yearController = TextEditingController();

 late final  HomeRepositary homeRepositary;

 @override
 void dispose() {
   nameController.dispose();
   priceController.dispose();
   yearController.dispose();

   super.dispose();
 }


 @override
  void initState() {
    super.initState();
    homeRepositary=HomeRepositary(ApiService());
  }

 Future<void> createProduct() async {

    try{
      final product=await homeRepositary.createProduct(
          category: selectedCategory,
          name: nameController.text.trim(),
          year: int.parse(yearController.text.trim()),
          price:double.parse( priceController.text.trim()),
      );

      if(!mounted)return;

      ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Product created successfully')),
      );

      Navigator.pop(context, true);

    }catch(e){
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
     }


 }



  Widget categoryBtn({
  required String title,
  required IconData icon,
    }){
    bool isSelected=selectedCategory==title;

    return ElevatedButton(
             style: ElevatedButton.styleFrom(
               side: BorderSide(
                 width: 2,
                 color: AppColors.btnAuthClr
               ),
               backgroundColor:isSelected?AppColors.btnAuthClr:AppColors.white ,
               foregroundColor: isSelected?AppColors.white:AppColors.btnAuthClr,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20),
               ),
             ),
        onPressed: () {
               setState(() {
                 selectedCategory=title;
               });
        },
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 2,),
            Text(title)
          ],
        ),
      );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Form(
           key: formKey,
           child: SingleChildScrollView(
             child: Column(
               children: [
                 Padding(
                   padding: EdgeInsets.all(20),
                   child: Row(
                     children: [
                       Expanded(
                         child: Text(
                           "Create Collections",
                           style: TextStyle(
                               fontSize: 24,
                               fontWeight: FontWeight.bold,
                               color: Colors.black),
                         ),
                       ),
                       GestureDetector(
                           onTap: (){
                             Navigator.pop(context);
                           },
                           child: Icon(Icons.highlight_remove)),
                     ],
                   ),
                 ),
             
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     categoryBtn(
                         title: 'phones',
                         icon: Icons.phone_android),
                     SizedBox(width: 6,),
                     categoryBtn(
                         title: 'tablets',
                         icon: Icons.tab),
                     SizedBox(width: 6,),
                     categoryBtn(
                         title: 'laptop',
                         icon: Icons.laptop),
                   ],
                 ),
             
                 Padding(
                   padding: EdgeInsets.all(10),
                   child: Column(
                     children: [
                       TextFormField(
                         controller: nameController,
                         decoration: InputDecoration(
                           hintText: 'Enter  name',
                           label: Text('name'),
                           border: OutlineInputBorder(),
                         ),
                         validator: (value){
                           if(value==null||value.isEmpty){
                             return'Please enter name';
                           }
                           return null;
                         },
                       ),
                       SizedBox(height: 10,),
                       TextFormField(
                         controller: priceController,
                         decoration: InputDecoration(
                           hintText: 'Enter price',
                           label: Text('price'),
                           border: OutlineInputBorder()
                         ),
                         validator: (value){
                           if(value==null||value.isEmpty){
                             return'Please enter price';
                           }
                           return null;
                         },
                       ),
                       SizedBox(height: 10,),
                       TextFormField(
                         controller: yearController,
                         decoration: InputDecoration(
                           hintText: 'Enter year',
                           label: Text('year'),
                           border: OutlineInputBorder()
                         ),
                         validator: (value){
                           if(value==null||value.isEmpty){
                             return'Please enter year';
                           }
                           return null;
                         },
                       ),
                     ],
                   ),
                 ),
             
                 SizedBox(
                   height: 10,
                 ),
             
                 Padding(
                   padding: EdgeInsets.all(20),
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.blue,
                       foregroundColor: Colors.white,
                       minimumSize: Size(double.infinity, 56),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                     onPressed: () {
                       if(formKey.currentState!.validate()){
                        createProduct();
                       }
                     },
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [Icon(Icons.add), Text("create collcetion")],
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: GestureDetector(
                     onTap: (){
                       Navigator.pop(context);
                     },
                     child: Text(
                       "Cancel",
                       style: TextStyle(
                           color: Colors.blue, fontWeight: FontWeight.bold),
                     ),
                   ),
                 )
             
               ],
             ),
           ),
         ),
    );
  }
}
