import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/features/home/data/model/car_model.dart';
import 'package:evhub/features/search/logic/search_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/font_weight.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/image_network.dart';
import '../../../generated/l10n.dart';
import '../../used_cars/ui/screen/used_car.dart';
import '../../wish_list/logic/wish_list_cubit.dart';

class SearchResultScreen extends StatefulWidget{
  const SearchResultScreen({super.key, required this.carsResult});
final List<Car> carsResult;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void didChangeDependencies() {

    // TODO: implement didChangeDependencies
    //WishListCubit.get(context).getFavorites();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
       decoration: BoxDecoration(
         image: DecorationImage(
           image: const AssetImage('images/png/background.png'),
           fit: BoxFit.cover,
         ),
       ),
       child: SafeArea(
         child: ListView(
           children: [
             CustomAppBar(),


             verticalSpace(17),

             BlocBuilder<SearchCubit,SearchState>(
  builder: (context, state) {
    return Padding(
               padding: const EdgeInsets.all(8.0),
               child: DropdownButton<String>(
                 dropdownColor: ColorsManager.darkBlue,
                 underline: SizedBox(),
                 icon: Icon(CupertinoIcons.sort_down_circle),
                 value: SearchCubit.get(context).selectedSort,
                 // isExpanded: true,
                 items:  SearchCubit.get(context).sortOptions
                     .map((sort) => DropdownMenuItem(
                   value: sort,
                   child: Text(sort),
                 ))
                     .toList(),
                 onChanged: (value) {
                   if (value != null) {
                     SearchCubit.get(context).selectedSort = value;
                     SearchCubit.get(context).sortBy(value);
                   }
                 },
               ),
             );
  },
),
             Padding(
                   padding: EdgeInsetsDirectional.only(end: 30.w),
                   child: Text(
                     textAlign: TextAlign.end,
                     '${widget.carsResult.length} ${S.of(context).Results}',
                     style: TextStyles.inter16greyMedium.copyWith(
                       fontSize: 11.sp,
                     ),
                   ),
                 ),
             verticalSpace(13),
             BlocBuilder<SearchCubit,SearchState>(
               builder: (context, state) {
                 if(widget.carsResult.isEmpty){
                   return Center(child: Text(S.of(context).NoCarsFound),);
                 }
                 return ListView.separated(
                   separatorBuilder: (context, index) {
                     return verticalSpace(12);
                   },
                   padding: EdgeInsets.symmetric(horizontal: 27.w),
                   shrinkWrap: true,
                   physics: ScrollPhysics(),
                   itemCount:widget.carsResult.length,
                   itemBuilder: (context, index) {
                     return GestureDetector(
                       onTap: (){
                         context.pushNamed( Routes.carDetails, arguments:widget.carsResult[index]);

                       },
                       child: Container(
                         padding: EdgeInsets.symmetric(
                           horizontal: 12.w,
                           vertical: 23.h,
                         ),
                         decoration: BoxDecoration(
                           color: Color(0xff1C2F39),
                           borderRadius: BorderRadius.circular(24.r),
                         ),
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 SizedBox(
                                   width: 150.w,
                                   child: Column(
                                     crossAxisAlignment:
                                     CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                         widget.carsResult[index].title ?? '',
                                         style: TextStyles.inter18WhiteMedium
                                             .copyWith(fontSize: 15.3.sp),
                                         overflow: TextOverflow.ellipsis,
                                       ),
                                       Text(
                                         widget.carsResult[index].carBrand?[0]["name"],
                                         style: TextStyles.inter13greyRegular
                                             .copyWith(fontSize: 15.3.sp),
                                       ),
                                     ],
                                   ),
                                 ),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                      S.of(context).StartFrom,
                                       style: TextStyles.inter13greyRegular,
                                     ),
                                     Text(
                                       '${NumberFormat("#,###").format(double.tryParse(widget.carsResult[index].acf!["price"].toString()) ?? 'N/A')} ${S.of(context).LE}',
                                       style: TextStyles.inter13greyRegular
                                           .copyWith(
                                         fontSize: 15.3.sp,
                                         fontWeight: FontWeightHelper.medium,
                                       ),
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                             verticalSpace(10),
                             AppCachedNetworkImage(
                               image: widget.carsResult[index].featuredImage,
                               height: 160.h,
                               width: 304.w,
                               radius: 20.r,
                             ),
                             verticalSpace(10),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 widget.carsResult[index].acf!["km"]==null?SizedBox.shrink():Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Row(children: [Image.asset("images/png/carused.png",height: 22.h,width: 22.w),Text(formatKm(widget.carsResult[index].acf!["km"]),style: TextStyles.inter18WhiteMedium,)],),
                                     Text(
                                       S.of(context).New,
                                       style: TextStyles.inter16greyMedium
                                           .copyWith(fontSize: 11.sp),
                                     ),
                                     Text(
                                       S.of(context).GoodCondition,
                                       style: TextStyles.inter16greyMedium
                                           .copyWith(fontSize: 11.sp),
                                     ),
                                   ],
                                 ),
                                 Container(
                                   width:  widget.carsResult[index].acf!["km"]==null?225.w:140.w,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(59.r),
                                     color: Color(0x2ed9d9d9),
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(12.0),
                                     child: Text(
                                       S.of(context).Explore,
                                       textAlign: TextAlign.center,
                                     ),
                                   ),
                                 ),
                                 BlocBuilder<WishListCubit, WishListState>(
                                   builder: (context, state) {
                                     final cubit = WishListCubit.get(context);
                                     final isFavorite = cubit.favCars.any((car) => car.id == widget.carsResult[index].id);

                                     return GestureDetector(
                                       onTap: () {
                                         if (isFavorite) {
                                           cubit.removeFromFavorites(widget.carsResult[index].id!);
                                           cubit.favCars.removeWhere((car) => car.id == widget.carsResult[index].id);
                                         } else {
                                           cubit.addToFavorites(widget.carsResult[index].id!);
                                           cubit.favCars.add(widget.carsResult[index]);
                                         }
                                         //cubit.emit(GetFavoritesSuccessState(cubit.favCars));
                                       },
                                       child: CircleAvatar(
                                         backgroundColor: const Color(0xff1B262C),
                                         child: Icon(
                                           CupertinoIcons.heart_fill,
                                           color: isFavorite ? Colors.red : const Color(0xa8ffffff),
                                           size: 20.sp,
                                         ),
                                       ),
                                     );
                                   },
                                 ),

                               ],
                             ),
                           ],
                         ),
                       ),
                     );
                   },
                 );
               },
             ),
           ],
         ),
       ),
     ),
   );
  }
}class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_rounded, size: 16.sp),
        ),
        Center(
          child: Text(
            textAlign: TextAlign.center, S.of(context).SearchResults,
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}