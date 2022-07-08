import 'package:app_wallet/components/app_form_field.dart';
import 'package:app_wallet/components/primary_button.dart';
import 'package:app_wallet/data/model/credit_card_input.dart';
import 'package:flutter/material.dart';

const _kPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 35);

class AddCardForm extends StatefulWidget {
  final void Function(CreditCardInput)? onSubmit;

  const AddCardForm({Key? key, this.onSubmit}) : super(key: key);

  @override
  State<AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: _kPadding,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF322E77)),
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFF27245D)),
      child: Form(
        key: _formKey,
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 12),
              const Icon(Icons.add, size: 16, color: Colors.white),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add card',
                      style: textTheme.headline4
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 5),
                  Text('Add your credit / debit card',
                      style: textTheme.bodyText1),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          const AppFormField(labelText: 'Card Number'),
          const SizedBox(height: 20),
          const AppFormField(labelText: 'Cardholder Name'),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                flex: 166,
                child: AppFormField(labelText: 'Expiration Date'),
              ),
              SizedBox(width: 17),
              Expanded(
                flex: 127,
                child: AppFormField(labelText: 'Security Code'),
              ),
            ],
          ),
          const SizedBox(height: 36),
          PrimaryButton(
            text: 'Next',
            onPressed: () {},
          )
        ]),
      ),
    );
  }
}
