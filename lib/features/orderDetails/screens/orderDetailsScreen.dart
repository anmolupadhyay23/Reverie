import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/admin/services/adminServices.dart';
import 'package:riverie/provider/user_provider.dart';
import 'package:riverie/widgets/customButton.dart';
import '../../../model/order.dart';
import '../../search/screens/searchScreen.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName='/order-details';
  final Order order;
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  int currentStep=0;

  final AdminServices adminServices=AdminServices();

  void NavigateSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep=widget.order.status;
  }

  // ONLY FOR ADMIN (FEATURE)
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status+1,
        order: widget.order,
        onSuccess: () {},
    );
  }

  void decreaseOrderStatus(int status) {
    adminServices.changeOrderStatus(
      context: context,
      status: status-1,
      order: widget.order,
      onSuccess: () {},
    );
  }

  @override
  Widget build(BuildContext context) {

    final user=Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient, // Color can be changed from globalVariables
                color: Colors.white
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  // margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    // elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: NavigateSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 6
                              ),
                              child: Icon(Icons.search,color: Colors.black, size: 23,),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          // border: const OutlineInputBorder(
                          //     borderRadius: BorderRadius.all(
                          //         Radius.circular(7)
                          //     ),
                          //     borderSide: BorderSide.none
                          // ),
                          // enabledBorder: const OutlineInputBorder(
                          //     borderRadius: BorderRadius.all(
                          //         Radius.circular(7)
                          //     ),
                          //     borderSide: BorderSide(color: Colors.black38,width: 1)
                          // ),
                          hintText: 'Search item',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14
                          )
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.transparent,
              //   height: 42,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   child: const Icon(Icons.mic,color: Colors.black,size: 25,),
              // )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View Order Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Date: ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}'),
                    Text('Order Id: ${widget.order.id}'),
                    Text('Order Total: \$${widget.order.totalPrice}')
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for(int i=0;i<widget.order.products.length;i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            Image.network(widget.order.products[i].images[0],
                              height: 120,
                              width: 120,
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.order.products[i].name,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Quantity: ${widget.order.quantity[i]}',
                                    ),
                                  ],
                                ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: Colors.deepOrange)
                  ),
                  child: Stepper(
                    physics: NeverScrollableScrollPhysics(),
                    steps: [
                      Step(
                        isActive: currentStep>=0,
                        title: const Text('Order Confirmed'),
                        content: const Text('Your order is yet to be confirmed'),
                      ),
                      Step(
                        isActive: currentStep>=1,
                        title: const Text('Shipped'),
                        content: const Text('Your order has been shipped'),
                      ),
                      Step(
                        isActive: currentStep>=2,
                        title: const Text('Out fot delivery'),
                        content: const Text('Your order is out for delivery'),
                      ),
                      Step(
                        isActive: currentStep>=3,
                        title: const Text('Delivered'),
                        content: const Text('Your order has been delivered'),
                      ),
                    ],
                    currentStep: currentStep,
                    onStepContinue: () {
                      final isLastStep=currentStep==3; // HARDCODED 3 because we have 3 steps
                      if(isLastStep) {
                        print('Completed');
                      }
                      else {
                        setState(() {
                          currentStep += 1;
                        });
                      }
                    },
                    onStepCancel: currentStep==0
                        ? null
                        : () {
                      setState(() {
                        currentStep-=1;
                      });
                    },
                    controlsBuilder: (context, details, {onStepContinue,onStepCancel}){
                      if(user.type=='admin')
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customButton(
                                      text: 'Done',
                                      onTap: () {
                                        final isLastStep=currentStep==3; // HARDCODED 3 because we have 3 steps
                                        if(isLastStep) {
                                          Navigator.pop(context);
                                        }
                                        else {
                                          changeOrderStatus(details.currentStep);
                                          setState(() {
                                            currentStep += 1;
                                          });
                                        }
                                      },
                                      fgColor: Colors.white,
                                      bgColor: Colors.deepOrange
                                  ),
                                  const SizedBox(width: 12,),
                                  currentStep!=0 ? customButton(
                                      text: 'Cancel',
                                      // onTap: onStepCancel,
                                      onTap: () {
                                        final isFirstStep=currentStep==0;
                                        decreaseOrderStatus(details.currentStep);
                                        if(isFirstStep){
                                          return null;
                                        }
                                        else{
                                          setState(() {
                                            currentStep-=1;
                                          });
                                        }
                                      },
                                      fgColor: Colors.white,
                                      bgColor: Colors.black54
                                  ) : const SizedBox(),
                                ],
                              ),
                            );
                          return const SizedBox();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
