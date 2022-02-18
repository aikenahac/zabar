import 'package:flutter/material.dart';
import 'package:zabar/models/bicikelj/bicikelj.model.dart';
import 'package:zabar/widgets/modal.widget.dart';

class BicikeLJMarker extends StatelessWidget {
  const BicikeLJMarker({Key? key, required this.terminal}) : super(key: key);

  final BicikeLJ terminal;

  _openDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Modal(
        height: 250.0,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                terminal.name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Available: ${terminal.station.available}'),
              Text('Free: ${terminal.station.free}'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetails(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.green[800],
        ),
        child: const Center(
          child: Icon(
            Icons.pedal_bike,
            color: Colors.white,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
