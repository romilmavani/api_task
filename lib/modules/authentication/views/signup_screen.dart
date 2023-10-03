import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../../../utils/const/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController walletPinController = TextEditingController();
  final TextEditingController deviceIdController = TextEditingController();
  final TextEditingController deviceIpController = TextEditingController();
  final TextEditingController deviceModelController = TextEditingController();
  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    getDeviceDetails();
    super.initState();
  }

  getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    deviceModelController.text =  androidInfo.model;
    deviceIdController.text =  androidInfo.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Screen'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextField(
                    labelText: 'Full Name',
                    controller: fullNameController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),

                  // Add the remaining text fields here
                  CustomTextField(
                    labelText: 'Username',
                    controller: usernameController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'First Name',
                    controller: firstNameController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Last Name',
                    controller: lastNameController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Middle Name',
                    controller: middleNameController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your middle name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Phone Number',
                    controller: phoneNumberController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Wallet Pin',
                    controller: walletPinController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your wallet pin';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Device ID',
                    controller: deviceIdController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your device ID';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Device IP',
                    controller: deviceIpController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your device IP';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Device Model',
                    controller: deviceModelController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your device model';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Street 1',
                    controller: street1Controller,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your street 1';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Street 2',
                    controller: street2Controller,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your street 2';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'City',
                    controller: cityController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'State',
                    controller: stateController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your state';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Zip Code',
                    controller: zipCodeController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your zip code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Country',
                    controller: countryController,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your country';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform signup here
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

