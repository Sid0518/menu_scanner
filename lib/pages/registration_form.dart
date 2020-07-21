import 'package:flutter/material.dart';
import 'package:menu_scanner/imports.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();

  String ownerName;
  String restaurantName;
  String contactNo;

  String addressLine1;
  String addressLine2;

  String city;
  String pinCode;

  String state;

  @override
  void initState() {
    super.initState();
    
    User user = Provider.of<User>(context, listen: false);
    this.ownerName = user.name;
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),

      body: Form(
        key: this.formKey,

        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,

          children: [
            ListTile(
              leading: Icon(Icons.person),

              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name of Owner'
                ),

                initialValue: user.name,
                onChanged: (String value) => this.ownerName = value,
              ),
            ),

            ListTile(
              leading: Icon(Icons.restaurant_menu),
              
              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name of Restaurant'
                ),

                onChanged: (String value) => this.restaurantName = value,
              ),
            ),

            ListTile(
              leading: Icon(Icons.dialpad),
              
              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact No.'
                ),

                onChanged: (String value) => this.contactNo = value,
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),

              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address Line 1'
                ),

                onChanged: (String value) => this.addressLine1 = value,
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.home),

              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address Line 2'
                ),

                onChanged: (String value) => this.addressLine2 = value,
              ),
            ),
                
            ListTile(
              leading: Icon(Icons.location_city),

              title: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'City'
                      ),

                      onChanged: (String value) => this.city = value,
                    ),
                  ),

                  SizedBox(width: 16),
            
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Pin Code'
                      ),

                      onChanged: (String value) => this.pinCode = value,
                    ),
                  ),
                ]
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.code),

              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'State'
                ),

                onChanged: (String value) => this.state = value,
              ),
            ),
          ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),

        onPressed: () async {
          if(this.formKey.currentState.validate()) {
            await showLoadingDialog(
              context,
              () async {
                await registerUser(
                  id: user.id,
                  ownerName: this.ownerName, restaurantName: this.restaurantName,
                  contactNo: this.contactNo,
                  addressLine1: this.addressLine1, addressLine2: this.addressLine2,
                  city: this.city, pinCode: this.pinCode,
                  state: this.state,
                );
              }
            );

            Navigator.pushReplacement(context, 
              MaterialPageRoute(
                builder: (context) => 
                  HomePage()
              )
            );
          }
        },
      ),
    );
  }
}