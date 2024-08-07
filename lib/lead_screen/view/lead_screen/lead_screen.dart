import 'package:earningfish/lead_screen/controller/lead_controller.dart';
import 'package:earningfish/lead_screen/view/widgets/common_card.dart';
import 'package:earningfish/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LeadCubit(),
      child: const LeadScreenBody(),
    );
  }
}

class LeadScreenBody extends StatefulWidget {
  const LeadScreenBody({super.key});

  @override
  _LeadScreenBodyState createState() => _LeadScreenBodyState();
}

class _LeadScreenBodyState extends State<LeadScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedStatusIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onStatusSelected(int index) {
    LeadStatus status;
    switch (index) {
      case 0:
        status = LeadStatus.inProcess;
        break;
      case 1:
        status = LeadStatus.success;
        break;
      case 2:
        status = LeadStatus.rejected;
        break;
      case 3:
        status = LeadStatus.expired;
        break;
      default:
        status = LeadStatus.none;
    }

    context.read<LeadCubit>().selectStatus(status);
    setState(() {
      _selectedStatusIndex = index;
    });
  }

  Widget _buildStatusButton(String title, int index) {
    return OutlinedButton(
        onPressed: () => _onStatusSelected(index),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: _selectedStatusIndex == index
                ? AppColors.primaryColor
                : AppColors.borderLightGrey,
          ),
          backgroundColor: _selectedStatusIndex == index
              ? AppColors.primaryColor
              : AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        ),
        child: Row(
          children: [
            if (title == 'Filters') const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                color: _selectedStatusIndex == index
                    ? AppColors.whiteColor
                    : AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (title == 'Filters')
              Image.asset(
                'assets/images/filters_icon.png',
                width: 24,
                height: 24,
              ),
          ],
        ));
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor),
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            height: 100.0,
          ),
        );
      },
    );
  }

  Widget _buildNoLeadsFound() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 5),
        child: Column(
          children: [
            const Text(
              'No leads found',
              style: TextStyle(fontSize: 22, color: AppColors.blackColor,fontWeight: FontWeight.bold),
            ),
            const Text(
              textAlign: TextAlign.center,
              'There are currently no leads that match the selected filter.',
              style: TextStyle(fontSize: 18, color: AppColors.blackColor),
            ),
            const SizedBox(height: 20),
            Image.asset("assets/images/no_leads_found.png"),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.blackColor,
                backgroundColor: AppColors.whiteColor,
                textStyle: const TextStyle(fontSize: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Clear Filter'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return BlocBuilder<LeadCubit, LeadState>(
      builder: (context, state) {
        if (state.isLoading) {
          return _buildShimmerEffect();
        } else if (state.leads.isEmpty) {
          return _buildNoLeadsFound();
        } else {
          return ListView(
            children:
                state.leads.map((lead) => CommonCard(lead: lead)).toList(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Leads',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.whiteColor,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/notifications_icon.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8.0, 15, 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    hintStyle: const TextStyle(color: AppColors.greyColor),
                    prefixIcon:
                        const Icon(Icons.search, color: AppColors.greyColor),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                  ),
                  style: const TextStyle(color: AppColors.blackColor),
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.whiteColor,
                labelColor: AppColors.whiteColor,
                unselectedLabelColor: AppColors.whiteColor,
                tabs: const [
                  Tab(text: 'Saving Account'),
                  Tab(text: 'Credit Cards'),
                  Tab(text: 'Personal Loan'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 8, 15, 0),
                child: Row(
                  children: [
                    _buildStatusButton('Filters', 4),
                    const SizedBox(width: 10),
                    _buildStatusButton('In Process', 0),
                    const SizedBox(width: 10),
                    _buildStatusButton('Success', 1),
                    const SizedBox(width: 10),
                    _buildStatusButton('Rejected', 2),
                    const SizedBox(width: 10),
                    _buildStatusButton('Expired', 3),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(),
                _buildTabContent(),
                _buildTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
