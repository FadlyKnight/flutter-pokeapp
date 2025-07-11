import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onNavigateToRegister;
  
  const LoginPage({super.key, this.onNavigateToRegister});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String _emailInput = '';
  String _passwordInput = '';
  bool _isLoading = false;
  bool _isLoggedIn = false;
  User? _currentUser;

  // Controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Check if user is already logged in
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    final User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _isLoggedIn = true;
        _currentUser = user;
        _emailInput = user.email ?? '';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateEmailInput(String text) {
    setState(() {
      _emailInput = text;
    });
  }

  void _updatePasswordInput(String text) {
    setState(() {
      _passwordInput = text;
    });
  }

  // Method to handle login
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Sign in with email and password
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailInput,
        password: _passwordInput,
      );
      
      // If login is successful
      if (userCredential.user != null) {
        setState(() {
          _isLoggedIn = true;
          _currentUser = userCredential.user;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selamat Datang, $_emailInput'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred during login';
      
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format';
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to handle logout
  Future<void> _logout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signOut();
      setState(() {
        _isLoggedIn = false;
        _currentUser = null;
        _emailInput = '';
        _passwordInput = '';
        _emailController.clear();
        _passwordController.clear();
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully logged out'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during logout: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: width,
                height: height * 0.45,
                child: Image.network(
                  'https://media-hosting.imagekit.io/1b5d57a4229644fa/pokemon-banner.jpg?Expires=1840987701&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=eGWEfgC63Quglf8BUGA8Ek7Nqs2VZH5h1f4PLDNxwj3jw7RycVBIuypad3VUg4NAAkSI3TWMQy8zkAn8XEwdqyuOEjpePEtS1ArHS1rSg9PdIbSSx6RgApbOl9SHlQ28HV56R4QunpSFXISd62k4kI1w~aRrw6~qpThdJW3DjXqv2tT0-20rEbMF6gK9pux8vKZdzh4mhKlGCcejUVnreKs~pfbLBT~g~SKGs8sidRTBXPNsGQDdnxdD4Ps1pFRXjSi6Tj4E62bPynT5m6nstv4XOHJgN80gKFeJ1Dob3u9Qk8Znq3HdU-wPQTj-DeepDe2TyEt54wR9OvE-xf4Ttg__',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _isLoggedIn ? 'Account' : 'Login',
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              
              if (_isLoggedIn) ...[
                // Show user info when logged in
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, size: 28),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Email: ${_currentUser?.email ?? ""}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          onPressed: _isLoading ? null : _logout,
                          icon: const Icon(Icons.logout, color: Colors.white),
                          label: _isLoading 
                            ? const SizedBox(
                                width: 20, 
                                height: 20, 
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ))
                            : const Text('Logout', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                // Show login form when not logged in
                TextField(
                  controller: _emailController,
                  onChanged: _updateEmailInput,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: _updatePasswordInput,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: const Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to reset password page
                          // Add this functionality later
                        },
                        child: const Text('Forget password?', style: TextStyle(fontSize: 12.0)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                        ),
                        onPressed: _isLoading ? null : _login,
                        child: _isLoading 
                            ? const SizedBox(
                                width: 20, 
                                height: 20, 
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ))
                            : const Text('Login'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                    onTap: () {
                      // Use callback to navigate to register page
                      if (widget.onNavigateToRegister != null) {
                        widget.onNavigateToRegister!();
                      } else {
                        // Fallback to named route if callback is not provided
                        Navigator.pushNamed(context, '/register');
                      }
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      children: [
                        TextSpan(
                          text: 'Signup',
                          style: TextStyle(color: Color(0xffEE7B23)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
