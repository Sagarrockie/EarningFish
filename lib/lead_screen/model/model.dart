import 'package:flutter/material.dart';

class LeadModel {
  final String status;
  final String? dp;
  final String date;
  final String name;
  final String account;
  final String? amount;
  final Color statusColor;
  final String statusText;
  final String? description;
  final Color backgroundColor;
  final String? lastUpdate;
  final String? hasIssue;
  final String? expiredCreatedDate;
  final String? expiredLastUpdateDate;

  LeadModel(
      {required this.status,
      this.dp,
      required this.date,
      required this.name,
      required this.account,
      this.amount,
      required this.statusColor,
      required this.statusText,
      this.description,
      this.lastUpdate,
      this.hasIssue,
      required this.backgroundColor,
      this.expiredCreatedDate,
      this.expiredLastUpdateDate});
}
