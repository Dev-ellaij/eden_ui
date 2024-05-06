import 'package:flutter/material.dart';
import 'package:ably_flutter/ably_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DeliveryTimelineScreen(),
    );
  }
}

class DeliveryTimelineScreen extends StatefulWidget {
  @override
  _DeliveryTimelineScreenState createState() => _DeliveryTimelineScreenState();
}

class _DeliveryTimelineScreenState extends State<DeliveryTimelineScreen> {
  final AblyRealtime ablyRealtime = AblyRealtime('');
  late RealtimeChannel channel;

  @override
  void initState() {
    super.initState();
    channel = ablyRealtime.channels.get('order_status');
    channel.subscribe((message) {
      // Handle incoming messages about order status
      print('Received message: ${message.data}');
    });
  }

  @override
  void dispose() {
    ablyRealtime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Delivery Timeline",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Order timeline
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('1'),
                    ),
                    title: Text('Order Placed'),
                    subtitle: Text('Your order has been placed.'),
                    trailing: Text('12:00 PM'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('2'),
                    ),
                    title: Text('Rider Assigned'),
                    subtitle: Text('Oyebisi has been assigned to deliver.'),
                    trailing: Text('12:10 PM'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('3'),
                    ),
                    title: Text('Estimated Arrival'),
                    subtitle: Text('Your order is expected to arrive.'),
                    trailing: Text('12:30 PM'),
                  ),
                ],
              ),
            ),
          ),

          // Order details and checklist
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cartItems[index][0]),
                      subtitle: Text('\$${cartItems[index][1]}'),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Rider:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Oyebisi',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Checklist:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                CheckboxListTile(
                  title: Text('Arrived on time'),
                  value: false,
                  onChanged: (value) {
                    // Implement onChanged functionality
                  },
                ),
                CheckboxListTile(
                  title: Text('Order complete and accurate'),
                  value: false,
                  onChanged: (value) {
                    // Implement onChanged functionality
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement rate order functionality
                  },
                  child: Text('Rate Your Order'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Implement rate rider functionality
                  },
                  child: Text('Rate Your Rider'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<List<String>> cartItems = [
  ['Item 1', '10'],
  ['Item 2', '20'],
  ['Item 3', '30'],
];
