import 'package:find_hotel_mis/firebaseOptions/firebase_options.dart';
import 'package:find_hotel_mis/models/hotel.dart';
import 'package:find_hotel_mis/widgets/HotelDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindHotel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromRGBO(
          (0.84 * 255).round(),
          (1.00 * 255).round(),
          (0.99 * 255).round(),
          1.0,
        )),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'FindHotel'),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'FindHotel'),
        '/login': (context) => const AuthScreen(isLogin: true),
        '/register': (context) => const AuthScreen(isLogin: false),
        '/hotelList': (context) => HotelListPage(
              hotels: [
                Hotel(
                  name: 'Luxury Hotel',
                  location: '123 Main Street, Cityville',
                  description: 'A luxurious hotel with breathtaking views.',
                  phone: '+1 123-456-7890',
                  map: 'https://maps.example.com/luxury-hotel',
                  price: 250.0,
                  distance: 2.5,
                ),
                Hotel(
                  name: 'Cozy Inn',
                  location: '456 Oak Avenue, Townsville',
                  description: 'A cozy inn with a warm atmosphere.',
                  phone: '+1 987-654-3210',
                  map: 'https://maps.example.com/cozy-inn',
                  price: 120.0,
                  distance: 1.8,
                ),
                Hotel(
                  name: 'Mountain Retreat',
                  location: '789 Pine Road, Hilltop',
                  description: 'A retreat nestled in the mountains.',
                  phone: '+1 555-123-4567',
                  map: 'https://maps.example.com/mountain-retreat',
                  price: 180.0,
                  distance: 5.2,
                )
              ],
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateToLogin() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(
        (0.84 * 255).round(),
        (1.00 * 255).round(),
        (0.99 * 255).round(),
        1.0,
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(
          (0.84 * 255).round(),
          (1.00 * 255).round(),
          (0.99 * 255).round(),
          1.0,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/img.png'),
            Container(
              margin: const EdgeInsets.only(top: 80.0),
              child: const Center(
                child: Text(
                  'Find the perfect hotel for you!',
                  style: TextStyle(
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Container(
              width: 170.0,
              height: 60.0,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to the login page
                  _navigateToLogin();
                },
                tooltip: 'Increment',
                backgroundColor: Colors.grey,
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  final bool isLogin;

  const AuthScreen({super.key, required this.isLogin});

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<void> _authAction() async {
    try {
      if (widget.isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        _showSuccessDialog(
            "Login Successful",
            "Welcome back! Your login was a success. "
                "Explore, engage, and enjoy your time with us.");
        _navigateToHotelList();
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        _showSuccessDialog(
            "Registration Successful",
            "Success! Your registration is complete. Thanks for joining us. "
                "Start exploring and make the most of your experience.");
        _navigateToLogin();
      }
    } catch (e) {
      _showErrorDialog(
          "Authentication Error", "Error during authentication: $e");
    }
  }

  void _showSuccessDialog(String title, String message) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToHotelList() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/hotelList');
    });
  }

  void _navigateToHome() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  void _navigateToLogin() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  void _navigateToRegister() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/register');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isLogin ? const Text("Sign In") : const Text("Sign Up"),
        backgroundColor: Color.fromRGBO(
          (0.84 * 255).round(),
          (1.00 * 255).round(),
          (0.99 * 255).round(),
          1.0,
        ),
      ),
      backgroundColor: Color.fromRGBO(
        (0.84 * 255).round(),
        (1.00 * 255).round(),
        (0.99 * 255).round(),
        1.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img.png'),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: "Enter your email",
                      filled: true,
                      fillColor: Colors.white),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: "Enter your password",
                      filled: true,
                      fillColor: Colors.white),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _authAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Background color
                  ),
                  child: Text(
                    widget.isLogin ? "Sign In" : "Sign Up",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                if (!widget.isLogin)
                  ElevatedButton(
                    onPressed: _navigateToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Background color
                    ),
                    child: const Text(
                      'Already have an account? Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                if (widget.isLogin)
                  ElevatedButton(
                    onPressed: _navigateToRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Background color
                    ),
                    child: const Text(
                      'Create an account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: _navigateToHome,
                  child: const Text('Back to Main Screen'),
                ),
              ],
            )),
      ),
    );
  }
}

class HotelListPage extends StatelessWidget {
  final List<Hotel> hotels;

  const HotelListPage({super.key, required this.hotels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(
          (0.84 * 255).round(),
          (1.00 * 255).round(),
          (0.99 * 255).round(),
          1.0,
        ),
      ),
      backgroundColor: Color.fromRGBO(
        (0.84 * 255).round(),
        (1.00 * 255).round(),
        (0.99 * 255).round(),
        1.0,
      ),
      body: ListView.builder(
        itemCount: hotels.length + 1, // +1 for the header
        itemBuilder: (context, index) {
          if (index == 0) {
            // This is the header
            return Column(
              children: [
                Image.asset(
                  'assets/img.png',
                  height: 120.0,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 47.0),
              ],
            );
          } else {
            final hotel = hotels[index - 1];
            return GestureDetector(
              onTap: () {
                // Navigate to the HotelDetailPage when a hotel is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDetailPage(hotel: hotel),
                  ),
                );
              },
              child: ListTile(
                title: Text(hotel.name),
                subtitle: Text(hotel.location),
              ),
            );
          }
        },
      ),
    );
  }
}

