// import 'package:agoris/common/size_constants.dart';
// import 'package:agoris/common/text_constants.dart';
// import 'package:agoris/presentation/theme/colors.dart';
// import 'package:flutter/material.dart';
//
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:libphonenumber/libphonenumber.dart';
//
// class PhoneInput extends StatefulWidget {
//
//   // final void Function(CountryCode, String)? onChanged;
//   final TextEditingController controller;
//
//   const PhoneInput({
//     Key? key,
//     // required this.onChanged
//     required this.controller
//   }) : super(key: key);
//
//   @override
//   State<PhoneInput> createState() => _PhoneInputState();
// }
//
// class _PhoneInputState extends State<PhoneInput> {
//
//   late Size size;
//
//   CountryCode countryCode = CountryCode(
//       name: 'Nigeria',
//       code: 'NG',
//       dialCode: '+234'
//   );
//
//   final TextEditingController phone = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     size = MediaQuery.of(context).size;
//
//     return Container(
//       width: size.width,
//       height: Sizes.dimen_56,
//       padding: const EdgeInsets.symmetric(
//           horizontal: Sizes.dimen_10, vertical: Sizes.dimen_10
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(Sizes.dimen_8),
//         border: Border.all(
//             color: const Color(0xFFE0DBD7),
//             width: Sizes.dimen_2
//         ),
//         // color: Colors.red
//       ),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//                 border: Border(
//                     right: BorderSide(
//                         color: AppColors.inputBorderColor,
//                         width: Sizes.dimen_1,
//                         style: BorderStyle.solid
//                     )
//                 )
//             ),
//             child: Directionality(
//               textDirection: TextDirection.rtl,
//               child: TextButton.icon(
//                 label: Text(
//                   countryCode.dialCode!,
//                   style: TextStyle(
//                       color: AppColors.labelColor,
//                       fontSize: Sizes.dimen_14,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: 'Manrope'
//                   ),
//                 ),
//                 icon: Icon(Icons.arrow_drop_down, color: AppColors.labelColor,),
//                 onPressed: (){},
//               ),
//             ),
//           ),
//           Container(
//             width: Sizes.dimen_1,
//             height: Sizes.dimen_40,
//             decoration: BoxDecoration(
//               color: AppColors.inputBorderColor,
//             ),
//           ),
//
//           Expanded(
//             child: TextFormField(
//               controller: widget.controller,
//               style: TextStyle(
//                   color: AppColors.primaryColor,
//                   fontSize: Sizes.dimen_16,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'Manrope'
//               ),
//               validator: (v){},
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.fromLTRB(
//                     Sizes.dimen_0,
//                     Sizes.dimen_0,
//                     Sizes.dimen_0,
//                     Sizes.dimen_10
//                 ),
//                 floatingLabelBehavior: FloatingLabelBehavior.never,
//                 hintText: TextConstants.phoneHint,
//                 focusColor: AppColors.primaryLightColor,
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(
//                     color: AppColors.hintTextColor,
//                     fontSize: Sizes.dimen_16,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: 'Manrope'
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//
//     // return Container(
//     //     decoration: BoxDecoration(
//     //         border: Border.all(color: AppColors.inputBorderColor),
//     //         borderRadius: BorderRadius.circular(Sizes.dimen_4)
//     //     ),
//     //     child: IntrinsicHeight(
//     //         child: Row(
//     //             crossAxisAlignment: CrossAxisAlignment.stretch,
//     //             children: [
//     //               CountryCodePicker(
//     //                   onChanged: (val) {
//     //                     setState(() => countryCode = val);
//     //                     onEditingComplete();
//     //                   },
//     //                   initialSelection: countryCode.code,
//     //                   showFlagDialog: true,
//     //                   showFlag: false,
//     //                   alignLeft: true,
//     //                   // textStyle: context.textTheme.bodyText1,
//     //                   // dialogTextStyle: context.textTheme.bodyText1,
//     //                   padding: const EdgeInsets.only(left: Sizes.dimen_4),
//     //                   dialogSize: Size(
//     //                       size.width * .7,
//     //                       size.height * .7
//     //                   ),
//     //                   searchDecoration: const InputDecoration(
//     //                     contentPadding: EdgeInsets.zero,
//     //                     isDense: true,
//     //                   )
//     //               ),
//     //               // ).w(context.screenWidth * .15),
//     //               Container(
//     //                   width: 1,
//     //                   color: AppColors.borderColor,
//     //                 padding: const EdgeInsets.symmetric(vertical: Sizes.dimen_8),
//     //               ),
//     //               TextFormField(
//     //                   controller: phone,
//     //                   // expands: true,
//     //                   // style: context.textTheme.bodyText1,
//     //                   onEditingComplete: onEditingComplete,
//     //                   onSaved: (val) => onEditingComplete(),
//     //                   keyboardType: TextInputType.phone,
//     //                   decoration: const InputDecoration(
//     //                       border: InputBorder.none,
//     //                       hintText: "Enter phone number"
//     //                   )
//     //               )
//     //             ]
//     //         )
//     //     )
//     // );
//
//   }
//
//   // onEditingComplete() async {
//   //   if(phone.text.length > 3 && _phoneValidation(phone.text)) {
//   //     var _phone = PhoneNumberUtil.normalizePhoneNumber(
//   //         phoneNumber: phone.text,
//   //         isoCode: countryCode.code!
//   //     );
//   //
//   //     var normalizePhoneNumber = await _phone;
//   //     if(widget.onChanged != null) {
//   //       setState(() => widget.onChanged!(
//   //           countryCode,
//   //           normalizePhoneNumber!
//   //       ));
//   //     }
//   //   }
//   // }
//   //
//   // bool _phoneValidation(String text) {
//   //   if (text.isEmpty) return false;
//   //
//   //   Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//   //   RegExp regex = RegExp(pattern as String);
//   //   if (!regex.hasMatch(text)) return false;
//   //
//   //   return true;
//   // }
//
// }