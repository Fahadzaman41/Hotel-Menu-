
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HotelMenu(),
    );
  }
}

class HotelMenu extends StatefulWidget {
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
        title: Text('My Hotel Menu'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [

          Padding(
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
                  margin: EdgeInsets.all(8),

                  child: ListTile(
                    leading: Image.network(
                      pictures[index],
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.restaurant, size: 50);
                      },
                    ),

                    title: Text(
                      names[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      'Price: Rs. ${prices[index]}',
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
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(15),

            child: Column(
              children: [

                Text(
                  'Total Price: Rs. ${totalPrice()}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),

                SizedBox(height: 10),

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
                          SnackBar(
                            content: Text('Please select some food!'),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,

                          builder: (context) {
                            return AlertDialog(
                              title: Text('Order Placed!'),

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

                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },

                    child: Text(
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
