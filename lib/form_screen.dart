import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as validator;

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  var user = UserModel();
  var passwordCache = '';
  var passwordCacheConfirm = '';
  bool obscureTextPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                label: 'Name',
                hint: 'Type your name...',
                onSaved: (text) => user = user.copyWith(name: text),
                validator: (text) => text == null || text.isEmpty
                    ? 'This field can\'t be empty'
                    : null,
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'E-mail',
                hint: 'Type your e-mail...',
                onSaved: (text) => user = user.copyWith(email: text),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field can\'t be empty';
                  }
                  if (!validator.isEmail(text)) {
                    return 'This field must be an e-mail';
                  }
                },
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Address',
                hint: 'Type your address...',
                onSaved: (text) => user = user.copyWith(address: text),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field can\'t be empty';
                  }
                },
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Phone',
                hint: 'Type your phone number...',
                onSaved: (text) => user = user.copyWith(phone: text),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field can\'t be empty';
                  }
                },
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Password',
                obscureText: obscureTextPassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureTextPassword = !obscureTextPassword;
                    });
                  },
                  icon: Icon(obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                hint: 'Type your password...',
                onSaved: (text) => user = user.copyWith(password: text),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field can\'t be empty';
                  }
                  if (passwordCacheConfirm != passwordCache) {
                    return 'Password is not equal';
                  }
                },
                onChanged: (text) => passwordCache = text,
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Confirm password',
                obscureText: obscureTextPassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureTextPassword = !obscureTextPassword;
                    });
                  },
                  icon: Icon(obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                hint: 'Confirm your password...',
                onSaved: (text) => user = user.copyWith(password: text),
                onChanged: (text) => passwordCacheConfirm = text,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field can\'t be empty';
                  }
                  if (passwordCacheConfirm != passwordCache) {
                    return 'Password is not equal';
                  }
                },
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      print('''FLUTTERANDO FORM
                      
                      Name: ${user.name}
                      Email: ${user.email}
                      Address: ${user.address}
                      Phone: ${user.phone}
                      Password: ${user.password}
                      ''');
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text('Save'),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    formKey.currentState?.reset();
                  },
                  icon: Icon(Icons.restore),
                  label: Text('Reset'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? icon;
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;

  const CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.obscureText = false,
    this.hint,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
        suffixIcon: suffix,
      ),
    );
  }
}

@immutable
class UserModel {
  final String name;
  final String email;
  final String address;
  final String phone;
  final String password;

  UserModel({
    this.name = '',
    this.email = '',
    this.address = '',
    this.phone = '',
    this.password = '',
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? address,
    String? phone,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }
}
