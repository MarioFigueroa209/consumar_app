import 'package:flutter/material.dart';

import 'constants.dart';

class DanoZonaAcopio {
  int? num;
  String? descripcion;
  String? fotoDano;

  DanoZonaAcopio({
    this.num,
    this.descripcion,
    this.fotoDano,
  });
}

class ParticipantesInspeccion {
  int? num;
  String? nombres;
  String? fotoFotocheck;
  String? empresa;

  ParticipantesInspeccion({
    this.num,
    this.nombres,
    this.fotoFotocheck,
    this.empresa,
  });
}

class AutoReportSwitch extends StatelessWidget {
  final double size;
  final bool value;
  final String title;
  final dynamic onChanged;

  const AutoReportSwitch(
      {super.key,
      this.onChanged,
      required this.size,
      required this.value,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
            softWrap: true,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Transform.scale(
            scale: size,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: kColorAzul,
              activeColor: kColorNaranja,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 20.0,
        ),
        Divider(
          height: 2,
          thickness: 2,
          indent: 5,
          endIndent: 5,
          color: Colors.black12,
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}
