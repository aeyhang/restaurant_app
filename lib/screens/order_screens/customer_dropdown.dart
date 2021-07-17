import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/constants/style.dart';
import 'package:restaurant_app/controllers/controllers.dart';
import 'package:restaurant_app/models/customer.dart';
import 'package:restaurant_app/widgets/custom_text.dart';

class CustomerDropdown extends StatelessWidget {
  List<Customer>_customers=[];
  @override
  Widget build(BuildContext context) {
    _customers=customerController.customers;
    return _buildDropDownCustomer( context);
  }
  
  Widget _buildDropDownCustomer( BuildContext context) {
    final headline1 = Theme.of(context).textTheme.headline1;
    var _selectedCustomer = _customers.first;
    customerController.setSelected(_selectedCustomer);
    return Container(
      padding: const EdgeInsets.all(3.0),
      width: 200,
      // height: 65,
      child: Center(
        child: FittedBox(
          child: Obx(
            () => DropdownButtonHideUnderline(
                          child: DropdownButton<Customer>(
                value: customerController.selectedCustomer.value,
                items: _customers.map((c) {
                  return DropdownMenuItem<Customer>(
                    child: CustomText(
                      text:c.customerName,
                      color: dark,
                      size: 18,
                    ),
                    value: c,
                  );
                }).toList(),
                onChanged: (Customer? newValue) {
                  customerController.setSelected(newValue!);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}