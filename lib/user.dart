
import 'package:hive/hive.dart';
part 'user.g.dart';
@HiveType(typeId: 0)
class User{
 @HiveField(0)
  String userName;
 @HiveField(1)
  String email;

  User(this.userName, this.email);

}