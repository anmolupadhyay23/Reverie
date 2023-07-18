import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:riverie/constants/utils.dart';
import 'package:riverie/features/address/services/addressServices.dart';
import 'package:riverie/features/address/services/upiService.dart';
import 'package:riverie/features/admin/widgets/productTextField.dart';
import 'package:riverie/provider/user_provider.dart';
import 'package:riverie/widgets/customButton.dart';


class AddressScreen extends StatefulWidget {
  static const String routeName='/address';
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  final TextEditingController _flatBuildingController=TextEditingController();
  final TextEditingController _areaController=TextEditingController();
  final TextEditingController _pincodeController=TextEditingController();
  final TextEditingController _townCityController=TextEditingController();

  String addressToBeUsed="";

  final _addressFormKey=GlobalKey<FormState>();

  List<PaymentItem> paymentItems=[];

  final AddressServices addressServices=AddressServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(amount: widget.totalAmount,label: 'Total Amount',status: PaymentItemStatus.final_price),);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _townCityController.dispose();
  }

  void onApplePayResult(res) {
    if(Provider.of<UserProvider>(context, listen: false).user.address.isEmpty){
      addressServices.SaveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, total: double.parse(widget.totalAmount));
  }

  void onGooglePayResult(res) {
    if(Provider.of<UserProvider>(context, listen: false).user.address.isEmpty){
      addressServices.SaveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, total: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFromProvider){
    addressToBeUsed="";

    bool isForm=_flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _townCityController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty;

    if(isForm) {
      if(_addressFormKey.currentState!.validate()){
        addressToBeUsed='${_flatBuildingController.text}, ${_areaController.text}, ${_townCityController.text} - ${_pincodeController.text}';
      }
      else{
        throw Exception('Please enter all the values!');
      }
    }
    else if(addressFromProvider.isNotEmpty) {
      addressToBeUsed=addressFromProvider;
    }
    else{
      showSnackBar(context, 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user=context.watch<UserProvider>().user;
    int sum=0;
    user.cart.map((e) => sum+=e['quantity']*e['product']['price'] as int).toList();
    String orderAmount=sum.toString();
    var address=context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
          ),
          title: const Text(
            'Pay here',
            style: TextStyle(
                color: Colors.black,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(address.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black45
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )
                ],
              ),
            Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        productTextField(controller: _flatBuildingController,hintText: 'Flat, Houseno, Building'),
                        SizedBox(height: 20,),
                        productTextField(controller: _areaController,hintText: 'Area, Street'),
                        SizedBox(height: 20,),
                        productTextField(controller: _pincodeController,hintText: 'Pincode'),
                        SizedBox(height: 20,),
                        productTextField(controller: _townCityController,hintText: 'Town/City'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            ApplePayButton(
              onPressed: () {
                payPressed(address);
              },
              width: double.infinity,
              style: ApplePayButtonStyle.whiteOutline,
              type: ApplePayButtonType.buy,
              onPaymentResult: onApplePayResult,
              paymentItems: paymentItems,
              paymentConfigurationAsset: 'applepay.json',
              margin: const EdgeInsets.only(top: 15),
              height: 50,
            ),
            SizedBox(height: 10,),
            GooglePayButton(
              onPressed: () {
                payPressed(address);
              },
              paymentConfigurationAsset: 'gpay.json',
              onPaymentResult: onGooglePayResult,
              paymentItems: paymentItems,
              height: 50,
              type: GooglePayButtonType.buy,
              margin: const EdgeInsets.only(top: 15),
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
                width: MediaQuery.of(context).size.width
            ),

            // TESTING -> ALL UPI APPS AVAILABLE ON DEVICE (USING UPI INDIA PLUGIN) : Status -> Completed + Working
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
                height: 50,
                child: customButton(
                    text: 'Pay using any UPI',
                    onTap: () async {
                      try{
                        String payment_reference=await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpiPayment(orderAmount: orderAmount,))
                        );
                      } catch(e) {
                        showSnackBar(context, 'Payment Failed: Unknown Reason');
                      }
                    },
                    fgColor: Colors.white,
                    bgColor: Colors.black45))
          ],
        ),
      ),
    );
  }
}
