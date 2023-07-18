import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverie/provider/user_provider.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.black
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,size: 20,
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Arriving to ${user.name} - ${user.address}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                  ),
                  overflow: TextOverflow.ellipsis, // Used to show ... when address overflows
                ),
              )
          ),
          const Padding(
              padding: EdgeInsets.only(
                  left: 5,
                  right: 2,
              ),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
