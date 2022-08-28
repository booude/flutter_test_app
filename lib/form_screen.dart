import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();

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
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'E-mail',
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Address',
              ),
              SizedBox(height: 15),
              CustomTextField(
                label: 'Phone',
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () {
                    formKey.currentState?.validate();
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

  const CustomTextField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'This field can\'t be empty';
        }
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Type your $label...',
        border: OutlineInputBorder(),
      ),
    );
  }
}
