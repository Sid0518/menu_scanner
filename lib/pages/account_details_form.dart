import 'package:flutter/material.dart';
import 'package:menu_scanner/imports.dart';

enum FormMode {Register, Update}

class AccountDetailsForm extends StatefulWidget {
  @required final FormMode formMode;
  AccountDetailsForm({this.formMode});

  @override
  _AccountDetailsFormState createState() => _AccountDetailsFormState();
}

class _AccountDetailsFormState extends State<AccountDetailsForm> {
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

    if(this.widget.formMode == FormMode.Update)
      this.initFields(user);
  }

  void initFields(User user) {
    this.restaurantName = user.getAttribute('restaurantName');
    this.contactNo = user.getAttribute('contactNo');

    this.addressLine1 = user.getAttribute('addressLine1');
    this.addressLine2 = user.getAttribute('addressLine2');

    this.city = user.getAttribute('city');
    this.pinCode = user.getAttribute('pinCode');

    this.state = user.getAttribute('state');
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.widget.formMode == FormMode.Register ? 
            'Register' : 'Account Settings'
        ),
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

                initialValue: this.ownerName ?? '',
                onChanged: (String value) => this.ownerName = value,
              ),
            ),

            ListTile(
              leading: Icon(Icons.restaurant_menu),
              
              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name of Restaurant'
                ),

                initialValue: this.restaurantName ?? '',
                onChanged: (String value) => this.restaurantName = value,
              ),
            ),

            ListTile(
              leading: Icon(Icons.dialpad),
              
              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contact No.'
                ),

                initialValue: this.contactNo ?? '',
                onChanged: (String value) => this.contactNo = value,
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),

              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address Line 1'
                ),

                initialValue: this.addressLine1 ?? '',
                onChanged: (String value) => this.addressLine1 = value,
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.home),

              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Address Line 2'
                ),

                initialValue: this.addressLine2 ?? '',
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

                      initialValue: this.city ?? '',
                      onChanged: (String value) => this.city = value,
                    ),
                  ),

                  SizedBox(width: 16),
            
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Pin Code'
                      ),

                      initialValue: this.pinCode ?? '',
                      onChanged: (String value) => this.pinCode = value,
                    ),
                  ),
                ]
              ),
            ),
            
            ListTile(
              leading: Icon(Icons.home),

              title: TextFormField(
                decoration: InputDecoration(
                  labelText: 'State'
                ),

                initialValue: this.state ?? '',
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

                user.updateData(
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

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AccountDetailsForm(formMode: FormMode.Register);
  }
}

class UpdateAccountForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AccountDetailsForm(formMode: FormMode.Update);
  }
}