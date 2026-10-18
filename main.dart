import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HotelMenu(),
    );
  }
}

class HotelMenu extends StatefulWidget {
  const HotelMenu({super.key});

  @override
  State<HotelMenu> createState() => _HotelMenuState();
}

class _HotelMenuState extends State<HotelMenu> {
  List<String> names = [
    'Pizza',
    'Burger',
    'Biryani',
    'Chicken Karahi',
    'Sandwich',
    'French Fries',
    'Pasta',
    'BBQ Tikka',
    'Ice Cream',
    'Chocolate Cake',
  ];

  List<int> prices = [
    1200, 500, 350, 1500, 400,
    250, 650, 800, 200, 300
  ];

  List<String> pictures = [
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300',
    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
    'https://images.unsplash.com/photo-1563379091339-03246963d96c?w=300',
    'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=300',
    'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=300',
    'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=300',
    'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=300',
    'https://images.unsplash.com/photo-1544025162-d76694265947?w=300',
    'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=300',
    'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=300',
  ];

  List<bool> selected = List<bool>.filled(10, false);

  // Track expanded state for each item to show details with animation
  List<bool> expanded = List<bool>.filled(10, false);

  int totalPrice() {
    int total = 0;

    for (int i = 0; i < names.length; i++) {
      if (selected[i]) {
        total = total + prices[i];
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Hotel Menu'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Select Your Favourite Food',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: expanded[index] ? 4 : 2,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        // Toggle item detail expansion on tap
                        expanded[index] = !expanded[index];
                      });
                    },
                    child: Column(
                      children: [
                        ListTile(
                          // Animated image size increase on click
                          leading: AnimatedContainer(
                            duration: const Duration(seconds: 5),
                            curve: Curves.easeInOut,
                            width: expanded[index] ? 100 : 70,
                            height: expanded[index] ? 100 : 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                pictures[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.restaurant, size: 50);
                                },
                              ),
                            ),
                          ),

                          title: Row(
                            children: [
                              Text(
                                names[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                expanded[index]
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 20,
                                color: Colors.brown,
                              ),
                            ],
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price: Rs. ${prices[index]}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.brown,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // ANIMATION 1: AnimatedCrossFade (5 seconds)
                              AnimatedCrossFade(
                                duration: const Duration(seconds: 5),
                                crossFadeState: expanded[index]
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                firstChild: const Row(
                                  children: [
                                    Icon(Icons.touch_app, size: 14, color: Colors.grey),
                                    SizedBox(width: 4),
                                    Text(
                                      'Tap item to see details',
                                      style: TextStyle(fontSize: 11, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                secondChild: const Row(
                                  children: [
                                    Icon(Icons.restaurant_menu, size: 14, color: Colors.brown),
                                    SizedBox(width: 4),
                                    Text(
                                      'Showing Full Details Below',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.brown,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          trailing: Checkbox(
                            value: selected[index],
                            onChanged: (value) {
                              setState(() {
                                selected[index] = value!;
                              });
                            },
                          ),
                        ),

                        // ANIMATION 2: AnimatedContainer for expanding detail box (5 seconds)
                        AnimatedContainer(
                          duration: const Duration(seconds: 5),
                          curve: Curves.easeInOut,
                          height: expanded[index] ? 80 : 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.brown.shade50,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: ClipRect(
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ANIMATION 3: AnimatedOpacity applied on click to fade in item details
                                  AnimatedOpacity(
                                    duration: const Duration(seconds: 5),
                                    opacity: expanded[index] ? 1.0 : 0.0,
                                    curve: Curves.easeInOut,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.info_outline, color: Colors.brown, size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'Item Detail: Freshly prepared delicious ${names[index]}. Special hotel recipe served hot and fresh!',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.brown,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  'Total Price: Rs. ${totalPrice()}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                    ),

                    onPressed: () {
                      List<String> order = [];

                      for (int i = 0; i < names.length; i++) {
                        if (selected[i]) {
                          order.add(names[i]);
                        }
                      }

                      if (order.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select some food!'),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Order Placed!'),
                              content: Text(
                                'Your selected items:\n\n'
                                '${order.join('\n')}\n\n'
                                'Total: Rs. ${totalPrice()}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);

                                    setState(() {
                                      selected = List<bool>.filled(
                                        10,
                                        false,
                                      );
                                    });
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                    child: const Text(
                      'Place Order',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
