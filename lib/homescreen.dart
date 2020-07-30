import 'package:flutter/material.dart';
import 'package:flutter_hive_database/user.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<User> userBox;
  String emaill = '';
  String name = '';
  User userr;

  List<User> listUser =  List();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  void initHive() async {
    final appDocumentDirect = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirect.path);
    Hive.registerAdapter(UserAdapter());
     var opentBox = await Hive.openBox<User>('User');
     if (opentBox.isOpen) {
       userBox = Hive.box<User>('User');
     }else{
       print('chua mo box');
     }
  }


//  Future<List<User>> getAllUser() async {
//    for(int i = 0 ; i<userBox.length; i++){
//        var box = userBox.getAt(i);
//        listUser.add(box);
//    }
//    return listUser;
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initHive();
  }
  @override
  Widget build(BuildContext context) {
//    getAllUser();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            TextFormField(

              decoration: InputDecoration(hintText: "Name",),
              controller: usernameController,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              controller: emailController,
            ),
            RaisedButton(
              onPressed: (){
                String userName = usernameController.text;
                String email = emailController.text;
                 userr = User(userName, email);
                userBox.add(userr);



              },
              child: Text("Add"),
            ),

      

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: userBox.listenable(),
              builder: (BuildContext context, Box<User> value, Widget child) {
                return  ListView.builder(
                  shrinkWrap: true,
                  itemCount: userBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<int> listKey = userBox.keys.cast<int>().toList();
                    int keyy = listKey[index];

                    User user = userBox.get(keyy);

                    return Padding(

                      padding: EdgeInsets.all(10),
                      child: Container(
                          width: double.infinity,

                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: ListTile(
                            onTap: (){
                              usernameController.text = user.userName;
                              emailController.text = user.email;
                              userr = user;

                               userr = User(usernameController.text, emailController.text);
                              userBox.putAt(index, userr);

                            },
                            trailing: InkWell(
                            onTap: (){
                                userBox.deleteAt(index);
                            },
                                child: Icon(Icons.close,color: Colors.red,)),
                            leading: Text(keyy.toString()),
                            title: Text(user.email),
                            subtitle: Text(user.userName),
                          )
                      ),
                    );

                  },

                );
              }, )


//            ValueListenableBuilder(
//                valueListenable: userBox.listenable(),
//              builder: (BuildContext context, Box<User> value, Widget child) {
//                  return             ListView.builder(
//                    shrinkWrap: true,
//                    itemCount: userBox.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      List<int> listKey = userBox.keys.cast<int>().toList();
//                      int keyy = listKey[index];
//
//                      User user = userBox.get(keyy);
//
//                      return Padding(
//                        padding: EdgeInsets.all(10),
//                        child: Container(
//                            width: double.infinity,
//
//                            decoration: BoxDecoration(
//                              color: Colors.grey[200],
//                            ),
//                            child: ListTile(
//                              leading: Text(keyy.toString()),
//                              title: Text(user.email),
//                              subtitle: Text(user.userName),
//                            )
//                        ),
//                      );
//
//                    },
//
//                  );
//              }, )
          ),
          ],
        ),
      ),
    );
  }

  void addUser() {


    
  }

//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//    Hive.close();
//  }
}
