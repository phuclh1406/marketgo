// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:matching/representation/widgets/mini_app_bar_container.dart';

// import '../../blocs/payment/payment_bloc.dart';

// class CardFormScreen extends StatelessWidget {
//   const CardFormScreen({super.key});
//   static const routeName = 'card_form_screen';

//   @override
//   Widget build(BuildContext context) {
//     return MiniAppBarContainerWidget(
//       implementLeading: true,
//       child: BlocBuilder<PaymentBloc, PaymentState>(
//         builder: (context, state) {
//           CardFormEditController controller = CardFormEditController(
//               initialDetails: state.cardFieldInputDetails);
//           if (state.status == PaymentStatus.initial) {
//             return Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text('Card Form',
//                           style: Theme.of(context).textTheme.bodyMedium),
//                       const SizedBox(height: 20),
//                       CardFormField(controller: controller),
//                       const SizedBox(height: 10),
//                       ElevatedButton(
//                           onPressed: () {
//                             (controller.details.complete)
//                                 ? context
//                                     .read<PaymentBloc>()
//                                     .add(const PaymentCreateIntent(
//                                         billingDetails: BillingDetails(
//                                             email: 'phuclh1406@gmail.com'),
//                                         items: [
//                                           {'id': 0},
//                                           {'id': 1},
//                                         ]))
//                                 : ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content:
//                                           Text('The form is not completed'),
//                                     ),
//                                   );
//                           },
//                           child: const Text('Pay'))
//                     ]));
//           }
//           if (state.status == PaymentStatus.success) {
//             return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('The payment is successful'),
//                   const SizedBox(height: 10, width: double.infinity),
//                   ElevatedButton(
//                       onPressed: () {
//                         context.read<PaymentBloc>().add(PaymentStart());
//                       },
//                       child: const Text('Back to home'))
//                 ]);
//           }

//           if (state.status == PaymentStatus.failure) {
//             return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('The payment failed'),
//                   const SizedBox(height: 10, width: double.infinity),
//                   ElevatedButton(
//                       onPressed: () {
//                         context.read<PaymentBloc>().add(PaymentStart());
//                       },
//                       child: const Text('Try again'))
//                 ]);
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
