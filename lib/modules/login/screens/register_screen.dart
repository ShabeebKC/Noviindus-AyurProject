import 'package:ayur_project/constants/app_resources.dart';
import 'package:ayur_project/constants/app_styles.dart';
import 'package:ayur_project/modules/login/models/booked_treatment_model.dart';
import 'package:ayur_project/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_app_bar.dart';
import '../models/branch_response_model.dart';
import '../models/treatment_response_model.dart';
import '../view_models/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController whNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController totalAmount = TextEditingController();
  TextEditingController discountAmount = TextEditingController();
  TextEditingController advanceAmount = TextEditingController();
  TextEditingController balanceAmount = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Consumer<RegisterViewModel>(
          builder: (context, loading, child) {
            return AppButton(text: "Save", onTap: () {
              final nm = name.text;
              final wh = whNumber.text;
              final add = address.text;
              final amount = (totalAmount.text,discountAmount.text,advanceAmount.text,balanceAmount.text);
              context.read<RegisterViewModel>().registerPatient(nm,wh,add,amount);
            }, isLoaderEnabled: loading.isLoading);
          }
        ),
      )),
      appBar: const AppAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0,top: 10),
            child: Text("Register", style: AppTextStyles.poppinsMedium(25)),
          ),
          Divider(height: 25),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildFields(fieldName: "Name", hint: "Enter your full name", controller: name),
                    ..._buildFields(fieldName: "Whatsapp Number", hint: "Enter your Whatsapp number", keyboardType: TextInputType.phone, controller: whNumber),
                    ..._buildFields(fieldName: "Address", hint: "Enter your full address", controller: address),
                    Consumer<RegisterViewModel>(
                      builder: (context, values, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._buildDropDowns<String>(
                              fieldName: "Location",
                              list: values.locations,
                              selectedValue: values.selectedLocation,
                              itemToString: (loc) => loc,
                              onChange: (value) {
                                context.read<RegisterViewModel>().changeLocation(value ?? "");
                              },
                            ),
                            ..._buildDropDowns<Branches>(
                              fieldName: "Branch",
                              list: values.branchList ?? [],
                              selectedValue: values.selectedBranch,
                              itemToString: (branch) => branch.name ?? "",
                              onChange: (value) {
                                context.read<RegisterViewModel>().changeBranch(value);
                              },
                            ),
                            ..._renderTreatment(),
                            const SizedBox(height: 20,),
                            ..._buildFields(fieldName: "Total Amount", hint: "", keyboardType: TextInputType.number, controller: totalAmount),
                            ..._buildFields(fieldName: "Discount Amount", hint: "", keyboardType: TextInputType.number, controller: discountAmount),
                            ..._renderPaymentOptions(),
                            ..._buildFields(fieldName: "Advance Amount", hint: "", keyboardType: TextInputType.number, controller: advanceAmount),
                            ..._buildFields(fieldName: "Balance Amount", hint: "", keyboardType: TextInputType.number, controller: balanceAmount),
                            ..._buildDateAndTimePicker(
                                Utils.formatDate(values.date.toString()),
                                fieldName: "Treatment Date",
                                icon: SvgPicture.asset(
                                  width: 20,
                                  height: 25,
                                  AppResources.calendarIcon,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              onTap: () => _selectDate()
                            ),
                            ..._buildDateAndTimePicker(
                                Utils.formatTime(values.time,),
                                fieldName: "Treatment Time",
                                icon: Icon(Icons.access_time_rounded, color: AppColors.primary,),
                                onTap: () => _selectTime(context)
                            ),
                          ],
                        );
                      }
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _renderTreatment(){
    return[
      const SizedBox(height: 20,),
      Text("Treatment", style: AppTextStyles.poppinsRegular(16)),
      Consumer<RegisterViewModel>(
        builder: (context, values, child) {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: values.bookedTreatments.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.greyBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Text("${index + 1}. ${values.bookedTreatments[index].treatments?.name}",
                            style: AppTextStyles.poppinsRegular(16),
                            overflow: TextOverflow.ellipsis,),
                        ),
                        IconButton(onPressed: () {
                          context.read<RegisterViewModel>().removeTreatment(index);
                        }, icon: Icon(Icons.cancel,
                          color: AppColors.lightRed,
                          size: 25,)
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text("Male", style: AppTextStyles.poppinsRegular(16, color: AppColors.primary)),
                        const SizedBox(width: 5),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.greyBg,
                            border: Border.all(color: AppColors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text("${values.bookedTreatments[index].maleCount}",
                                style: AppTextStyles.poppinsMedium(16, color: AppColors.primary)
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text("Female", style: AppTextStyles.poppinsRegular(16, color: AppColors.primary)),
                        const SizedBox(width: 5),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.greyBg,
                            border: Border.all(color: AppColors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text("${values.bookedTreatments[index].femaleCount}",
                                style: AppTextStyles.poppinsMedium(16, color: AppColors.primary)
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {return const SizedBox(height: 10);},);
        }
      ),
      const SizedBox(height: 10),
      AppButton(
        text: "+ Add Treatment",
        onTap: () => _renderTreatmentSheet(),
        isLoaderEnabled: false,
        color: AppColors.secondary,
        textStyle: AppTextStyles.poppinsMedium(16),
      ),
    ];
  }

  Future<void> _renderTreatmentSheet(){

    Widget renderPatientCounts({required String gender,required int count}){
      return Row(
        children: [
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                color: AppColors.greyBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey)
            ),
            child: Center(child: Text(gender,
                style: AppTextStyles.poppinsRegular(18, color: AppColors.grey)
            )),
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              if(count == 0) return;
              context.read<RegisterViewModel>().modifyPatientCount(gender,"-");
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: count == 0 ? AppColors.secondary  : AppColors.primary,
              child: Text("-", style: AppTextStyles.poppinsBold(20, color: AppColors.white),),
            ),
          ),
          const SizedBox(width: 5,),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey)
            ),
            child: Center(child: Text(count.toString(),
                style: AppTextStyles.poppinsRegular(18, color: AppColors.grey)
            )),
          ),
          const SizedBox(width: 5,),
          InkWell(
            onTap: () => context.read<RegisterViewModel>().modifyPatientCount(gender,"+"),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primary,
              child: Text("+", style: AppTextStyles.poppinsBold(20, color: AppColors.white),),
            ),
          )
        ],
      );
    }

    return showModalBottomSheet<void>(
      elevation: 0,
      context: context,
      backgroundColor: AppColors.white,
      builder: (BuildContext context) {
        return Consumer<RegisterViewModel>(
            builder: (context, treatment,child) {
              return Padding(
                padding: const  EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._buildDropDowns<Treatments>(
                      fieldName: "Treatment",
                      list: treatment.treatmentList ?? [],
                      selectedValue: treatment.selectedTreatment,
                      itemToString: (treatment) => treatment.name ?? "",
                      onChange: (value) {
                        context.read<RegisterViewModel>().changeTreatment(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    Text("Add Patients", style: AppTextStyles.poppinsMedium(16)),
                    const SizedBox(height: 10),
                    renderPatientCounts(gender: "Male", count: treatment.maleCount),
                    const SizedBox(height: 10),
                    renderPatientCounts(gender: "Female", count: treatment.femaleCount),
                    const SizedBox(height: 20,),
                    SafeArea(
                        child: AppButton(
                            text: "Save",
                            onTap: () {
                              final vieModel = context.read<RegisterViewModel>();
                              final treatment = vieModel.selectedTreatment;
                              final male = vieModel.maleCount;
                              final female = vieModel.femaleCount;
                              final item = BookedTreatmentModel(treatment, male, female);
                              context.read<RegisterViewModel>().addTreatment(item);
                              Navigator.pop(context);
                            },
                            isLoaderEnabled: false
                        )
                    )
                  ],
                ),
              );
            }
        );
      },
    );
  }

  List<Widget> _renderPaymentOptions(){
    return [
      Text("Payment Option", style: AppTextStyles.poppinsRegular(16)),
      const SizedBox(height: 8),
      Consumer<RegisterViewModel>(
          builder: (context, payment, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (index) {
                final option = payment.paymentOptions[index];
                return Row(
                  children: [
                    Radio<String>(
                      activeColor: AppColors.primary,
                      value: option,
                      groupValue: payment.selectedPaymentOption,
                      onChanged: (val) {
                        context.read<RegisterViewModel>().changePaymentOption(val);
                      },
                    ),
                    InkWell(
                        onTap: () => context.read<RegisterViewModel>().changePaymentOption(option),
                        child: Text(option,
                            style: AppTextStyles.poppinsRegular(18)
                        )
                    )
                  ],
                );
              },),
            );
          }
      ),
      const SizedBox(height: 20,),
    ];
  }

  List<Widget> _buildDateAndTimePicker(dynamic val,{required String fieldName, required Widget icon, required void Function()? onTap}){
    return [
      Text(fieldName, style: AppTextStyles.poppinsRegular(16)),
      const SizedBox(height: 8),
      InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.greyBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(val.toString(), style: AppTextStyles.poppinsRegular(16),),
              icon
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
    ];
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      context.read<RegisterViewModel>().updateTime(picked);
    }
  }

  Future<void> _selectDate() async {
    var defaultDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      confirmText: "Select",
      helpText: "Pick Treatment Date",
      context: context,
      initialDate: defaultDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != defaultDate) {
      context.read<RegisterViewModel>().updateDate(DateTime.parse(DateFormat('yyyy-MM-dd').format(pickedDate)));
    }
  }

  List<Widget> _buildFields({
    TextInputType keyboardType = TextInputType.streetAddress,
    required String fieldName,
    TextEditingController? controller,
    required String hint}){
    return [
      Text(fieldName, style: AppTextStyles.poppinsRegular(16)),
      const SizedBox(height: 8),
      TextFormField(
        autofocus: false,
        keyboardType: keyboardType,
        controller: controller,
        cursorColor: AppColors.primary,
        decoration: AppInputDecorationStyles.formFieldDecoration(hint, 12),
      ),
      const SizedBox(height: 20,),
    ];
  }

  List<Widget> _buildDropDowns<T>({
    required String fieldName,
    required List<T> list,
    required T? selectedValue,
    required String Function(T) itemToString,
    required void Function(T?)? onChange,
  }) {
    return [
      const SizedBox(height: 20),
      Text(fieldName, style: AppTextStyles.poppinsRegular(16)),
      const SizedBox(height: 8),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.grey)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: false,
            hint: Text("Choose the $fieldName"),
            padding: EdgeInsets.symmetric(horizontal: 18),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
            elevation: 3,
            dropdownColor: AppColors.white,
            value: selectedValue,
            items: list.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    itemToString(item),
                    style: AppTextStyles.poppinsRegular(16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChange,
          ),
        ),
      )
    ];
  }

}
