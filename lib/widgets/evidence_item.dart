import 'package:eatoutroundabout/models/evidence_model.dart';
import 'package:eatoutroundabout/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EvidenceItem extends StatelessWidget {
  final Evidence? evidence;
  final bool? isMyEvidence;

  EvidenceItem({this.isMyEvidence, this.evidence});

  @override
  Widget build(BuildContext context) {
    return
      Container(
          margin: EdgeInsets.only(bottom: padding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(padding / 50),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(padding / 2), bottomRight: Radius.circular(padding / 2)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Action: ' + evidence!.evidenceType!, textScaleFactor: 0.85,  overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('ID:' + evidence!.evidenceID!, textScaleFactor: 0.85,  overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('Action Date : ' + DateFormat('dd MMM yyyy').format(evidence!.creationDate!.toDate()), textScaleFactor: 0.85,  overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor))),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text('Value :' + evidence!.measure! + evidence!.value!.toString(), textScaleFactor: 0.85,  overflow: TextOverflow.ellipsis, style: TextStyle(color: primaryColor))),
                            ],
                          ),
                        ],
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
