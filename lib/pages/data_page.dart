import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firststop/utils/centered_view.dart';
import 'package:firststop/models/User.dart';
import 'package:firebase/firebase.dart' as fb;

class UserData extends StatefulWidget {
   UserData({Key key, this.userId, this.loginCallback}) : super(key: key);

   final VoidCallback loginCallback;
   final String userId;

  @override
  State<StatefulWidget> createState() => _UserDataState();
}
class _UserDataState extends State<UserData> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  User newUser = new User();
  List<String> _roles = <String>['', 'Student', 'Advisor'];
  String _role = '';

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
      .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message))); 
  }

  void submitForm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Some form entries are not valid!');
    } 
    else { 
      form.save();
      final fb.DatabaseReference ref = fb.database().ref("users/" + widget.userId);
      var map = {
        "completeSignUp": "true",
        'firstName': newUser.firstName,
        'lastName': newUser.lastName,
        'role': newUser.role,
      };
      await ref.set(map);
      widget.loginCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Get Started'),
        elevation: 1,
      ),
      body: CenteredView(
              child: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person_outline),
                    hintText: 'First Name',
                    labelText: 'First Name',
                  ),
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄ" +
                      "ĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]")),
                    LengthLimitingTextInputFormatter(30),
                  ],
                  onSaved: (val) => newUser.firstName = val,
                ),
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person_outline),
                    hintText: 'Last Name',
                    labelText: 'Last Name',
                  ),
                  inputFormatters: [
                    WhitelistingTextInputFormatter(RegExp("[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄ" +
                      "ĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]")),
                    LengthLimitingTextInputFormatter(30),
                  ],
                  onSaved: (val) => newUser.lastName = val,
                ),
                new FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.fitness_center),
                        labelText: 'Role',
                      ),
                      isEmpty: _role == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: _role,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              newUser.role = newValue;
                              _role = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _roles.map((String value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  validator: (val) {
                    return val != '' ? null : 'Please select an option';
                  },
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                  child: new RaisedButton(
                    elevation: 1.0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.blue,
                    child: const Text('Submit', style: const TextStyle(fontSize: 15.0, color: Colors.white)),
                    onPressed: submitForm,
                  ),
                ),
              ],
            )
          )
        ),
      ),
    );
  }
}
