import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

class Whatshomescreen extends StatefulWidget {
  const Whatshomescreen({super.key});

  @override
  State<Whatshomescreen> createState() => _WhatshomescreenState();
}

class _WhatshomescreenState extends State<Whatshomescreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  final TextEditingController Textcontroller = TextEditingController();
  String? hint = "Enter your phone number";
  String initialCountry = 'PK';
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/back.jpg',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "WhatsApp Direct",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            15.0), // Set the border radius here
                        border: Border.all(
                            color: Colors.grey), // Optionally add a border
                      ),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            this.number = number;
                          });
                          print(number.phoneNumber);
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          useBottomSheetSafeArea: true,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: TextStyle(color: Colors.black),
                        initialValue: number,
                        hintText: hint,
                        textFieldController: controller,
                        formatInput: true,
                        keyboardType: TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        inputDecoration: InputDecoration(
                          hintText: hint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  15.0), // Set the radius as per your requirement
                            ),
                          ),
                        ),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            15.0), // Set the border radius here
                        border: Border.all(
                            color:
                                Colors.grey), // Optionally add a border color
                      ),
                      child: TextField(
                        controller: Textcontroller,
                        decoration: InputDecoration.collapsed(
                          hintText: '  Write a message here',
                          hintStyle: TextStyle(color: Colors.black45),
                        ),
                        maxLines:
                            null, // Allows the text field to expand vertically
                        expands:
                            true, // Allows the text field to fill the available space
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                  // FilledButton(
                  //   onPressed: () async {
                  //     String? phoneNumber = await number.phoneNumber;
                  //     String? message = "hello";
                  //     // print(
                  //     //     'Full phone number with country code: $phoneNumber&text=$message');

                  //     // Define the function
                  //     launchWhatsappWithMobileNumber() async {
                  //       final url =
                  //           "whatsapp://send?phone=$phoneNumber&text=$message";
                  //       if (await canLaunchUrl(
                  //           Uri.parse(Uri.encodeFull(url)))) {
                  //         await launchUrl(Uri.parse(Uri.encodeFull(url)));
                  //       } else {
                  //         throw 'Could not launch $url';
                  //       }
                  //     }

                  //     // Call the function
                  //     await launchWhatsappWithMobileNumber();
                  //   },
                  //   child: const Text("Send Message"),
                  // ),
                  SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width * 8 / 10,
                    child: FilledButton(
                      onPressed: () async {
                        String? phoneNumber = await number.phoneNumber;
                        String? message = Textcontroller.text;

                        var whatsappUrl = Uri.parse(
                            "whatsapp://send?phone=$phoneNumber" +
                                "&text=${Uri.encodeComponent("$message")}");
                        try {
                          launchUrl(whatsappUrl);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors
                            .green.shade300), // Set the background color here
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Adjusts the Row to fit its children
                        children: [
                          Icon(Icons.message,
                              color: Colors.white), // WhatsApp icon
                          SizedBox(width: 8), // Space between the icon and text
                          Text("Send Message"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // void getPhoneNumber(String phoneNumber) async {
  //   PhoneNumber number =
  //       await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

  //   setState(() {
  //     this.number = number;
  //   });
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }
}
