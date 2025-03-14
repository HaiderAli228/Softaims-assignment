import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth-view/signin_view.dart';

enum UserRole { user, admin }

class ConfirmRole extends StatefulWidget {
  const ConfirmRole({super.key});

  @override
  _ConfirmRoleState createState() => _ConfirmRoleState();
}

class _ConfirmRoleState extends State<ConfirmRole> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  UserRole? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C5CE7), Color(0xFF48D2F0)],
          ),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Welcome to SoftAims!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Create ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextSpan(
                          text: 'Notes',
                          style: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' & ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextSpan(
                          text: 'Todo',
                          style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: " with Notebook",
                            style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Your Name',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xFF6C5CE7), width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) => _name = value,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'Select Your Role:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 15),
                          SegmentedButton<UserRole>(
                            segments: [
                              ButtonSegment(
                                value: UserRole.user,
                                label: Text(
                                  'User',
                                  style: TextStyle(
                                    color: _selectedRole == UserRole.user
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                icon: Icon(Icons.person),
                              ),
                              ButtonSegment(
                                value: UserRole.admin,
                                label: Text(
                                  'Admin',
                                  style: TextStyle(
                                    color: _selectedRole == UserRole.admin
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                icon: const Icon(Icons.admin_panel_settings),
                              ),
                            ],
                            selected: {_selectedRole ?? UserRole.admin},
                            onSelectionChanged: (Set<UserRole> newSelection) {
                              setState(() {
                                _selectedRole = newSelection.first;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return const Color(0xFF6C5CE7);
                                  }
                                  return Colors.grey[200];
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6C5CE7),
                                      Color(0xFF48D2F0)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () async {
                                    if (_formKey.currentState!.validate() && _selectedRole != null) {
                                      try {
                                        _formKey.currentState!.save();
                                        final prefs = await SharedPreferences.getInstance();

                                        // Add null checks for all values
                                        if (_name == null) {
                                          throw Exception('Name is required');
                                        }

                                        // Use conditional access operator
                                        await prefs.setString('userName', _name!);
                                        await prefs.setString(
                                            'userRole',
                                            _selectedRole == UserRole.admin ? 'admin' : 'user'
                                        );

                                        // Navigate only if everything succeeds
                                        if (context.mounted) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => CreateAccountScreen(
                                                name: _name!,
                                                role: _selectedRole!,
                                              ),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Error saving preferences: ${e.toString()}'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please complete all fields'),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Continue',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.arrow_forward,
                                            color: Colors.white)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
