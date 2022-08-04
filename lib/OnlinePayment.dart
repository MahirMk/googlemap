import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OnlinePayment extends StatefulWidget {

  @override
  State<OnlinePayment> createState() => _OnlinePaymentState();
}

class _OnlinePaymentState extends State<OnlinePayment> {

  TextEditingController _pay = TextEditingController();

  static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    //thank you
    //api
    //firebase
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }
  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Payment"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height:250,),
            Text("PAY",style: TextStyle(fontSize: 30),),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 3.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _pay,
                  decoration: InputDecoration(fillColor: Colors. black12, filled: true,
                    border: InputBorder.none,
                    icon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: 10,
                          child: Icon(Icons.currency_rupee,color: Colors.black,)
                      ),
                    ),
                  ),
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors. black,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: GestureDetector(
                  onTap: (){
                    var payment = _pay.text.toString();
                    var options = {
                      'key': 'rzp_test_3k2GVLXHaR6oSy',
                      'amount': double.parse(payment) * 100,
                      'name': 'Campany Name',
                      'description': 'Fine T-Shirt',
                      'retry': {'enabled': true, 'max_count': 1},
                      'send_sms_hash': true,
                      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                      'external': {
                        'wallets': ['paytm']
                      }
                    };

                    try {
                      _razorpay.open(options);
                    } catch (e) {
                      debugPrint('Error: e');
                    }
                  },
                  child: Center(child: Text("SUBMIT",style: TextStyle(fontSize: 20 ,color: Colors. black,fontWeight: FontWeight.bold),))
              ),
            )
          ],
        ),
      ),
    );
  }
}
