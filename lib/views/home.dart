import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay razorpay = new Razorpay();
  TextEditingController amount = new TextEditingController();
  @override
  void initState() {
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_ynXOT6MmNCB4yZ",
      "amount": num.parse(amount.text) * 100,
      "name": "Razor Pay",
      "description": "Payment",
      "prefil": {
        "contact": "1234567890",
        "email": "harshithv25@gmail.com",
      },
      "external": {
        "wallets": ["paytm"]
      },
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  void handlerPaymentSuccess() {
    print('success');
  }

  void handlerErrorFailure() {
    print('err');
  }

  void handlerExternalWallet() {
    print('wallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text(
            'Razor Pay',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: amount,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                openCheckout();
              },
              color: Colors.redAccent,
              child: Text(
                'Pay Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
