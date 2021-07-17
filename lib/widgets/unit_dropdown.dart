import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/unit_controller.dart';
import '../models/unit.dart';

class UnitDropdown extends StatelessWidget {
  final _unitController=Get.find<UnitController>();
  List<Unit>_units=[];
  final int _unitID;
  UnitDropdown(this._unitID);
  @override
  Widget build(BuildContext context) {
    _units=_unitController.units;
    return _buildDropDownUnit(_unitID, context);

  }
  
  Widget _buildDropDownUnit(int unitID, BuildContext context) {
    final headline1 = Theme.of(context).textTheme.headline1;
    var _selectedUnit = _units.firstWhere((c) => c.id == unitID);
    _unitController.selectedUnit(_selectedUnit);
    return Container(
      padding: const EdgeInsets.all(3.0),
      width: 200,
      height: 65,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: FittedBox(
          child: Obx(
            () => DropdownButton<Unit>(
              value: _unitController.selectedUnit.value,
              items: _units.map((u) {
                return DropdownMenuItem<Unit>(
                  child: Text(
                    u.unitName,
                    textAlign: TextAlign.center,
                    style: headline1,
                  ),
                  value: u,
                );
              }).toList(),
              onChanged: (Unit? newValue) {
                _unitController.selectedUnit(newValue);
              },
            ),
          ),
        ),
      ),
    );
  }

}