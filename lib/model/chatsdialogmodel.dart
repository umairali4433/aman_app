
import 'package:flutter/cupertino.dart';

class chatsdialogmodel {
  String dialogId,user1Email,user2Email,lastMessage,des,country;

  chatsdialogmodel(this.dialogId, this.user1Email, this.user2Email, this.lastMessage);
  chatsdialogmodel.a2(this.dialogId, this.user1Email, this.user2Email, this.lastMessage,this.country,this.des);
  chatsdialogmodel.a1(this.dialogId, this.user1Email, this.user2Email);
}
