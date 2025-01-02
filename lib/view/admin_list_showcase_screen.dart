import 'package:flutter/material.dart';
import 'package:flutter_architectural_flow/view/edit_dialog.dart';

class AdminListShowcaseScreen extends StatefulWidget {
  const AdminListShowcaseScreen({super.key});

  @override
  State<AdminListShowcaseScreen> createState() => _AdminListShowcaseScreenState();
}

class _AdminListShowcaseScreenState extends State<AdminListShowcaseScreen> {
  ValueNotifier<bool> _isForIndia = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs to Showcase!"),
        actions: [
          ValueListenableBuilder(
              valueListenable: _isForIndia,
              builder: (context, isForIndia, child) {
                return isForIndia ? const Text("India", style: TextStyle(fontWeight: FontWeight.bold),) : const Text("UK", style: TextStyle(fontWeight: FontWeight.bold),);
              }
          ),
          const SizedBox(width: 16,),
          ValueListenableBuilder(
            valueListenable: _isForIndia,
            builder: (context, isForIndia, child) {
              return Switch(value: isForIndia, onChanged: (bool){
                _isForIndia.value = bool;
              });
            }
          ),
          const SizedBox(width: 16,),
        ],
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, pos){
           return Padding(
             padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
             child: ListTile(
               tileColor: Colors.black12,
               leading: Image.network("https://miro.medium.com/v2/resize:fit:1400/format:webp/1*Bhfzsp01NibPkNYmWy9YyA.png"),
               title: Text("Top 10 Coroutine Mistakes We All Have Made as Android Developers", maxLines: 3, overflow: TextOverflow.ellipsis,),
               subtitle: Text("Understanding and Avoiding Common Pitfalls in Asynchronous Programming with Kotlin Coroutines", maxLines: 4, overflow: TextOverflow.ellipsis,),
               trailing: Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text("Nov 3, 2024"),
                       Text("Android")
                     ],
                   ),
                   IconButton(onPressed: (){
                     showEditDialog(context, "Edit Blog Details!");
                   }, icon: Icon(Icons.edit)),
                   IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.redAccent,)),
                 ],
               ),
             ),
           );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showEditDialog(context, "Add New Blog!");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
