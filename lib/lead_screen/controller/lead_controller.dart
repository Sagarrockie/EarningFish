import 'package:earningfish/lead_screen/model/model.dart';
import 'package:earningfish/resources/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LeadStatus { inProcess, success, rejected, expired, none }

class LeadState {
  final List<LeadModel> leads;
  final LeadStatus selectedStatus;
  final bool isLoading;

  LeadState({
    required this.leads,
    required this.selectedStatus,
    this.isLoading = false,
  });
}

class LeadCubit extends Cubit<LeadState> {
  LeadCubit()
      : super(LeadState(
    leads: [],
    selectedStatus: LeadStatus.none,
    isLoading: true,
  )) {
    _loadLeads(LeadStatus.inProcess);
  }

  final List<LeadModel> inProcessLeads = [
    LeadModel(
      status: "inProcess",
      date: '08 May 2024',
      name: 'Arshit Vaghani',
      account: 'SBI Saving Account',
      amount: '790',
      statusColor: AppColors.primaryColor,
      statusText: 'Account In Process',
      description: 'View leads that are currently being processed.',
      backgroundColor: AppColors.backgroundColor,
    ),
    LeadModel(
      status: "inProcess",
      date: '08 May 2024',
      name: 'Arshit Vaghani',
      account: 'SBI Saving Account',
      amount: '790',
      statusColor: AppColors.primaryColor,
      statusText: 'Account In Process',
      description: 'View leads that are currently being processed.',
      backgroundColor: AppColors.backgroundColor,
    ),
    LeadModel(
      status: "inProcess",
      date: '08 May 2024',
      name: 'Arshit Vaghani',
      account: 'SBI Saving Account',
      amount: '790',
      statusColor: AppColors.primaryColor,
      statusText: 'Account In Process',
      description: 'View leads that are currently being processed.',
      backgroundColor: AppColors.backgroundColor,
    ),
  ];

  final List<LeadModel> successLeads = [
    LeadModel(
      status: "success",
      dp: "assets/images/sbi.png",
      date: '08 May 2024',
      name: 'Arshit Vaghani',
      account: 'SBI Saving Account',
      amount: '790',
      statusColor: AppColors.primaryColor,
      statusText: 'Account Activated',
      description: 'Follow up with customer to get the application completed.',
      backgroundColor: AppColors.whiteColor,
    ),
    LeadModel(
      status: "success",
      dp: "assets/images/sbi.png",
      date: '08 May 2024',
      name: 'Arshit Vaghani',
      account: 'SBI Saving Account',
      amount: '790',
      statusColor: AppColors.primaryColor,
      statusText: 'Account Activated',
      description: 'Follow up with customer to get the application completed.',
      backgroundColor: AppColors.whiteColor,
    ),
    LeadModel(
      status: "success",
      dp: "assets/images/sbi.png",
      date: '08 May 2024',
      name: 'Arshit Vaghani',
      account: 'SBI Saving Account',
      amount: '790',
      statusColor: AppColors.primaryColor,
      statusText: 'Account Activated',
      description: 'Follow up with customer to get the application completed.',
      backgroundColor: AppColors.whiteColor,
    ),
  ];

  final List<LeadModel> rejectedLeads = [
    LeadModel(
      name: 'Kapil',
      account: '+91 5846215624',
      statusText: 'Lead Rejected',
      status: 'rejected',
      statusColor: AppColors.errorColor,
      backgroundColor: AppColors.fadedWhiteColor,
      date: '08 May 2024',
      dp: "assets/images/nameDP.png",
    ),
    LeadModel(
      name: 'Kapil',
      account: '+91 5846215624',
      statusText: 'Lead Rejected',
      status: 'rejected',
      statusColor: AppColors.errorColor,
      backgroundColor: AppColors.fadedWhiteColor,
      date: '08 May 2024',
      dp: "assets/images/nameDP.png",
    ),
    LeadModel(
      name: 'Kapil',
      account: '+91 5846215624',
      statusText: 'Lead Rejected',
      status: 'rejected',
      statusColor: AppColors.errorColor,
      backgroundColor: AppColors.fadedWhiteColor,
      date: '08 May 2024',
      dp: "assets/images/nameDP.png",
    ),
  ];

  final List<LeadModel> expiredLeads = [
    LeadModel(
      date: '08 May 2024',
      name: 'HDFC 811 Savings Account',
      account: '9856423045',
      amount: '790',
      statusColor: AppColors.errorColor,
      statusText: 'Expired',
      description:
      'We are sorry to inform you that, this lead has expired. Kindly check lead faq’s for detailed reason.',
      backgroundColor: AppColors.fadedWhiteColor,
      lastUpdate: '01 Aug 2024',
      hasIssue: "yes",
      status: 'expired',
      expiredCreatedDate: "20-Apr-2024",
      expiredLastUpdateDate: "08-May-2024",
      dp: "assets/images/hdfc.png",
    ),
    LeadModel(
      date: '08 May 2024',
      name: 'HDFC 811 Savings Account',
      account: '9856423045',
      amount: '790',
      statusColor: AppColors.errorColor,
      statusText: 'Expired',
      description:
      'We are sorry to inform you that, this lead has expired. Kindly check lead faq’s for detailed reason.',
      backgroundColor: AppColors.fadedWhiteColor,
      lastUpdate: '01 Aug 2024',
      hasIssue: "yes",
      status: 'expired',
      expiredCreatedDate: "20-Apr-2024",
      expiredLastUpdateDate: "08-May-2024",
      dp: "assets/images/hdfc.png",
    ),
    LeadModel(
      date: '08 May 2024',
      name: 'HDFC 811 Savings Account',
      account: '9856423045',
      amount: '790',
      statusColor: AppColors.errorColor,
      statusText: 'Expired',
      description:
      'We are sorry to inform you that, this lead has expired. Kindly check lead faq’s for detailed reason.',
      backgroundColor: AppColors.fadedWhiteColor,
      lastUpdate: '01 Aug 2024',
      hasIssue: "yes",
      status: 'expired',
      expiredCreatedDate: "20-Apr-2024",
      expiredLastUpdateDate: "08-May-2024",
      dp: "assets/images/hdfc.png",
    ),
  ];

  void selectStatus(LeadStatus status) async {
    emit(LeadState(
      leads: state.leads,
      selectedStatus: status,
      isLoading: true,
    ));

    await Future.delayed(const Duration(seconds: 1));

    List<LeadModel> leads;

    switch (status) {
      case LeadStatus.inProcess:
        leads = inProcessLeads;
        break;
      case LeadStatus.success:
        leads = successLeads;
        break;
      case LeadStatus.rejected:
        leads = rejectedLeads;
        break;
      case LeadStatus.expired:
        leads = expiredLeads;
        break;
      default:
        leads = [];
    }

    emit(LeadState(
      leads: leads,
      selectedStatus: status,
      isLoading: false,
    ));
  }

  void _loadLeads(LeadStatus status) {
    selectStatus(status);
  }
}
