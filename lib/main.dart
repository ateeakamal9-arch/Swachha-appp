import 'package:flutter/material.dart';

void main() {
  runApp(const SwachhaApp());
}

class SwachhaApp extends StatelessWidget {
  const SwachhaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swachha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
        primaryColor: const Color(0xFFE5A93C),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE5A93C),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final List> services = const [
    {
      'title': 'Vehicle Washing',
      'price': 499.0,
      'icon': Icons.directions_car_filled_rounded,
      'bgColor': Color(0xFFFFF3D6),
      'accentColor': Color(0xFFE5A93C),
    },
    {
      'title': 'Kitchen Cleaning',
      'price': 1299.0,
      'icon': Icons.countertops_rounded,
      'bgColor': Color(0xFFFFE8E8),
      'accentColor': Color(0xFFD96B6B),
    },
    {
      'title': 'Bathroom Cleaning',
      'price': 799.0,
      'icon': Icons.clean_hands_rounded,
      'bgColor': Color(0xFFE8F4F8),
      'accentColor': Color(0xFF4A90E2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swachha • ಸ್ವಚ್ಛ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Service',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Professional cleaning at your doorstep in Karnataka',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: service['bgColor'],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: service['accentColor'],
                        child: Icon(service['icon'], color: Colors.white),
                      ),
                      title: Text(
                        service['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Starting at ₹${service['price'].toStringAsFixed(0)}'),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: service['accentColor'],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(
                                serviceType: service['title'],
                                price: service['price'],
                              ),
                            ),
                          );
                        },
                        child: const Text('Book', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingScreen extends StatefulWidget {
  final String serviceType;
  final double price;

  const BookingScreen({Key? key, required this.serviceType, required this.price}) : super(key: key);

  @override
  State createState() => _BookingScreenState();
}

class _BookingScreenState extends State {
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.serviceType}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service: ${widget.serviceType}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Total Amount: ₹${widget.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, color: Color(0xFFD96B6B), fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Address',
                hintText: 'House No, Street, Bengaluru',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD96B6B)),
                onPressed: () {
                  if (_addressController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter address')),
                    );
                    return;
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderStatusScreen()),
                  );
                },
                child: const Text('Confirm Order', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Status'), automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Color(0xFFE5A93C)),
              const SizedBox(height: 20),
              const Text(
                'Finding nearest Swachha Agent...',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your order is auto-assigning to an available partner.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE5A93C)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                child: const Text('Back to Home', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
