
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }  
  String limitString(int len){
    if (this.length > len){
      return this.replaceRange(len - 3, this.length, '...');
    }
    else return this;
  }
  String cutString(int len){
    if (this.length > len){
      return this.replaceRange(len, this.length, '');
    }
    else return this;
  }
}
