import 'dart:convert';

import 'package:shadcn_flutter/shadcn_flutter.dart';

final _usernameKey = const TextFieldKey('username');
final _passwordKey = const TextFieldKey('password');
final _confirmPasswordKey = const TextFieldKey('confirmPassword');

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final FormController controller = FormController();
            return AlertDialog(
              title: const Text('Edit profile'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 480,
                    child: Form(
                      onSubmit: (context, values) {
                        String? username = _usernameKey[values];
                        String? password = _passwordKey[values];
                        String? confirmPassword = _confirmPasswordKey[values];
                        String json = jsonEncode(
                          values.map((key, value) {
                            return MapEntry(key.key, value);
                          }),
                        );
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Form Values'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Username: $username'),
                                  Text('Password: $password'),
                                  Text('Confirm Password: $confirmPassword'),
                                  Text('JSON: $json'),
                                ],
                              ),
                              actions: [
                                PrimaryButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FormTableLayout(
                            rows: [
                              FormField(
                                key: _usernameKey,
                                label: const Text('Username'),
                                hint: const Text(
                                  'This is your public display name',
                                ),
                                validator: const LengthValidator(min: 4),
                                child: const TextField(
                                  initialValue: 'sunarya-thito',
                                ),
                              ),
                              FormField(
                                key: _passwordKey,
                                label: const Text('Password'),
                                validator: const LengthValidator(min: 8),
                                child: const TextField(obscureText: true),
                              ),
                              FormField(
                                key: _confirmPasswordKey,
                                label: const Text('Confirm Password'),
                                validator: CompareWith.equal(
                                  _passwordKey,
                                  message: 'Passwords do not match',
                                ),
                                child: const TextField(obscureText: true),
                              ),
                            ],
                          ),
                          const Gap(24),
                          FormErrorBuilder(
                            builder: (context, errors, child) {
                              return PrimaryButton(
                                onPressed: errors.isEmpty
                                    ? () => context.submitForm()
                                    : null,
                                child: const Text('Submit'),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const Text('Edit Profile'),
    );
  }
}
