import 'package:flutter/material.dart';
import '../../model/model.dart';
import '../../../resources/app_colors.dart';

class CommonCard extends StatelessWidget {
  final LeadModel lead;

  const CommonCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lead.date, style: const TextStyle(color: AppColors.dateGrey)),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.borderLightGrey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  child: Row(
                    children: [
                      displayDp(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(lead.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 4),
                              if (lead.status == "inProcess" ||
                                  lead.status == "success")
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14)
                            ],
                          ),
                          Text(lead.account,
                              style: const TextStyle(
                                  color: AppColors.subTextGrey)),
                        ],
                      ),
                      const Spacer(),
                      displayStatusSpecificWidget(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (lead.status == "expired")
                  displayExpiredOptions()
                else
                  const SizedBox(),
                statusContainer(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayStatusSpecificWidget() {
    switch (lead.status) {
      case "rejected":
        return displayCompanyImage();
      case "expired":
        return displayExpiredCreatedAtDate();
      default:
        return displayCoinAndAmount();
    }
  }

  Widget displayExpiredCreatedAtDate() {
    return Column(
      children: [
        const Text('Created At',
            style: TextStyle(color: AppColors.subTextGrey)),
        Text(lead.expiredCreatedDate!,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }

  Widget displayExpiredOptions() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderLightGrey),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Last Update',
                      style: TextStyle(color: AppColors.subTextGrey)),
                  Text(lead.expiredLastUpdateDate!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),
          ),
          const VerticalDivider(color: Colors.grey, thickness: 3),
          const Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Have an issue?',
                        style: TextStyle(color: AppColors.subTextGrey)),
                    Text('Resolve It',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayCoinAndAmount() {
    return Row(
      children: [
        Image.asset('assets/images/coin.png', width: 16, height: 16),
        Text(lead.amount!, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget displayCompanyImage() {
    return Image.asset('assets/images/stashFin.png', width: 80, height: 16);
  }

  Widget displayDp() {
    return lead.status != "inProcess"
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundImage: AssetImage(lead.dp!)),
        )
        : const SizedBox();
  }

  Widget statusContainer(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lead.backgroundColor,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        border: Border.all(color: AppColors.borderLightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lead.statusText,
              style: TextStyle(
                  color: lead.statusColor, fontWeight: FontWeight.bold)),
          if (lead.status != "rejected")
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(lead.description!,
                  style: const TextStyle(color: AppColors.subTextGrey)),
            ),
        ],
      ),
    );
  }
}
