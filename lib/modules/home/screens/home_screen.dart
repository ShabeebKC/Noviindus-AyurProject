import 'package:ayur_project/constants/app_colors.dart';
import 'package:ayur_project/constants/app_resources.dart';
import 'package:ayur_project/constants/app_styles.dart';
import 'package:ayur_project/modules/home/view_model/home_view_model.dart';
import 'package:ayur_project/modules/login/screens/register_screen.dart';
import 'package:ayur_project/modules/login/view_models/register_view_model.dart';
import 'package:ayur_project/widgets/app_app_bar.dart';
import 'package:ayur_project/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_button.dart';
import '../models/patient_response_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchList();
      context.read<RegisterViewModel>().getBranches();
      context.read<RegisterViewModel>().getTreatments();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const AppAppBar(),
      bottomNavigationBar: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: AppButton(
            text: "Register Now",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
            },
            isLoaderEnabled: false),
      )),
      body: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.white,
        onRefresh: () => _fetchList(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderSearch(context),
              const SizedBox(height: 10,),
              _renderSort(),
              const Divider(height: 30,),
              Consumer<HomeViewModel>(
                  builder: (context, patientList, child) {
                    return patientList.patientList == null
                        ? _renderLoader()
                        : (patientList.patientList?.isNotEmpty ?? false)
                        ? SizedBox(height: MediaQuery.of(context).size.height / 1.5,
                      child: ListView.builder(
                          itemCount: patientList.patientList?.length,
                          itemBuilder: (context, index) {
                            final patient = patientList.patientList?[index];
                            return _renderListItem(patient);
                          }),
                    ) : _renderListEmpty();
                  }
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderListEmpty(){
    return  Center(
      child: Column(
        children: [
          Text("No Patients Listed",
              style: AppTextStyles.poppinsMedium(20)
          ),
          Text("Swip Down to Refresh",
              style: AppTextStyles.poppinsRegular(12, color: AppColors.blueText)
          ),
        ],
      ),
    );
  }

  Widget _renderLoader(){
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 4),
              decoration: BoxDecoration(
                color: AppColors.greyBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(height: 20, width: 70,),
                  const SizedBox(height: 7,),
                  ShimmerWidget(width: 150, height: 30,),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      ...[
                        const SizedBox(width: 5,),
                        ShimmerWidget(height: 20, width: 50,),
                      ],
                      Spacer(),
                      const SizedBox(width: 5,),
                      ShimmerWidget(height: 20, width: 50,),
                    ],
                  ),
                  const SizedBox(height: 20,)
                ],
              ),
            );
          }),
    );
  }

  Widget _renderSearch(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 1.8,
            child: TextFormField(
              decoration: AppInputDecorationStyles.formFieldDecoration("Search for Treatments", 8).copyWith(
                  prefixIcon: Icon(Icons.search, size: 20, color: AppColors.grey,),
                  hintStyle: AppTextStyles.poppinsRegular(14, color: AppColors.grey)
              ),
            ),
          ),
          AppButton(
            text: 'Search',
            onTap: () {},
            isLoaderEnabled: false,
            width: MediaQuery.of(context).size.width * 0.23,
            textStyle: AppTextStyles.poppinsMedium(16,color: AppColors.white),
          )
        ],
      ),
    );
  }

  Widget _renderSort(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Sort By", style: AppTextStyles.poppinsMedium(20,color: AppColors.greyText)),
          Consumer<HomeViewModel>(
            builder: (context, sort, child) {
              return InkWell(
                onTap: () => context.read<HomeViewModel>().sortPatientsByDate(!sort.isAscending),
                child: Container(
                  padding: EdgeInsets.fromLTRB(18, 4, 5, 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: AppColors.grey
                      )
                  ),
                  child: Row(
                    children: [
                      Text("Date", style: AppTextStyles.poppinsRegular(16),),
                      const SizedBox(width: 40),
                      Icon(sort.isAscending ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded, color: AppColors.primary,)
                    ],
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }

  Widget _renderListItem(Patient? patient) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 4),
      decoration: BoxDecoration(
        color: AppColors.greyBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${patient?.id}. ${patient?.user}",
              style: AppTextStyles.poppinsMedium(18)
          ),
          const SizedBox(height: 7,),
          (patient?.patientDetailsSet?.isNotEmpty ?? false)
              ? Text(
            "          ${patient?.patientDetailsSet?.first.treatmentName}",
            style: AppTextStyles.poppinsRegular(18, color: AppColors.primary),
            overflow: TextOverflow.ellipsis,
          )
              : const SizedBox.shrink(),
          const SizedBox(height: 10,),
          Row(
            children: [
              if(patient?.dateNdTime != null)
              ...[SvgPicture.asset(AppResources.calendarIcon),
              const SizedBox(width: 5,),
              Text("${Utils.formatDate(patient?.dateNdTime ?? "")}")],
              Spacer(),
              SvgPicture.asset(AppResources.personIcon),
              const SizedBox(width: 5,),
              Text("${patient?.name}"),
            ],
          ),
          Divider(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("View Booking Details",
                style: AppTextStyles.poppinsRegular(16),),
              Icon(Icons.keyboard_arrow_right_rounded, color: AppColors.primary,)
            ],
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }

  _fetchList(){
    return context.read<HomeViewModel>().getPatientList();
  }
}
