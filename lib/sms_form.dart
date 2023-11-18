import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sms_advanced/sms_advanced.dart';


class SMSForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SMSFormState();
}

class _SMSFormState extends State<SMSForm>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  //
  // void _sendSMS(String message, List<String> recipients) async {
  //   SmsSender sender = SmsSender();
  //   String address = "3237757247";
  //   sender.sendSms(SmsMessage(address, 'Hello flutter world!'));
  // }


  String? validatePhoneNumber(String? value) {
    // Check if the phone number is empty
    if(value == null || value.isEmpty){
      return 'Phone number is required';
    }

    // Remove any non-digit characters
    String cleanedPhoneNumber = value.replaceAll(RegExp(r'\D'), '');

    // Check if the phone number has the correct length
    if (cleanedPhoneNumber.length != 10) {
      return 'Invalid phone number';
    }
    // You can add more specific validation if needed, such as checking for a valid area code, etc.

    // If everything is fine, return null, indicating no error
    return null;
  }


  String? validateMessage(String? value) {
    if(value == null || value.isEmpty){
      return 'A message is required';
    }

    // Check if the phone number has the correct length
    if (messageController.text.length > 10) {
      return 'Message is too long';
    }

    return null;
  }

  void onSubmitPressed() async {
    if(_formKey.currentState!.validate()){
      print('sent');
      String message = messageController.text;
      String phoneNumber = phoneNumberController.text;

      SmsSender sender = SmsSender();
      await sender.sendSms(SmsMessage(phoneNumber, message));
      // await _sendSMS(message, recipients);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          // Phone Number Text Field
          TextFormField(
            controller: phoneNumberController,
            validator: validatePhoneNumber,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(160), // Adjust the length as needed
              // You can add more formatters or customize based on your needs
            ],
            decoration: const  InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
            ),
          ),

          // Message Text Field
          TextFormField(
            controller: messageController,
            validator: validateMessage,
            decoration: const  InputDecoration(
              labelText: 'Message',
              hintText: 'Message',
            ),
          ),

          // Submit Button
          ElevatedButton(onPressed: onSubmitPressed, child: const Text('Send Text')),

        ],
      )
    );
  }

}