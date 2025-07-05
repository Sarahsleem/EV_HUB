import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/theming/colors.dart';
import 'package:evhub/core/theming/styles.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/posts/logic/posts_cubit.dart';
import 'package:evhub/features/posts/ui/screen/posts_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../../services/logic/services_cubit.dart';
import '../../data/model/post_model.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  TextEditingController comment = TextEditingController();
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
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        color: Colors.white30,
                        blurRadius: 18,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: AppCachedNetworkImage(
                    image: widget.postModel.featuredImage,
                    height: 370.h,
                    radius: 30.r,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 33.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      verticalSpace(33),
                      Text(
                        widget.postModel.ratings.details[0].author,
                        style: TextStyles.inter12WhiteRegular.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      verticalSpace(25),
                      Text(
                        widget.postModel.categories[0].name,
                        textAlign: TextAlign.right,
                        style: TextStyles.inter16greyMedium.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      verticalSpace(13),
                      SizedBox(
                        height: 70.h,
                        child: Text(
                          widget.postModel.title,
                          style: TextStyles.inter20greyBold.copyWith(
                            color: Colors.white,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      verticalSpace(20),
                      Text(
                        formatDate(widget.postModel.date),
                        style: TextStyles.inter16greyMedium.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                      verticalSpace(25),
                      Divider(color: Color(0x14ffffff)),
                      HtmlContentViewer(htmlContent: widget.postModel.content),
                      verticalSpace(25),
                      Text(
                        S.of(context).Writeareview, // Or "Comments"
                        style: TextStyles.inter14WhiteSemiBold,
                      ),
                      verticalSpace(12),
                      ...widget.postModel.ratings.details.map((comment) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.author,
                                  style: TextStyles.inter14WhiteSemiBold,
                                ),
                                verticalSpace(6),
                                Text(
                                  comment.content,
                                  style: TextStyles.inter12WhiteRegular,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      verticalSpace(50),

                    ],
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 22.w, top: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<PostsCubit, PostsState>(
                    builder: (context, state) {
                      return Center(
                        child:
                            PostsCubit.get(context).writeComment
                                ? WriteComment(
                                  comment: comment,
                                  onSend: widget.postModel.id,
                                )
                                : GestureDetector(
                                  onTap: () {
                                    PostsCubit.get(
                                      context,
                                    ).changeWriteComment();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 22.h),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(29.r),
                                    ),
                                    child: Image.asset(
                                      'images/png/chatbubble-ellipses-outline.png',
                                      color: Colors.black45,
                                      height: 27.h,
                                      width: 27.w,
                                    ),
                                  ),
                                ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WriteComment extends StatelessWidget {
  final int onSend;
  final TextEditingController comment;
  const WriteComment({super.key, required this.onSend, required this.comment});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        return Column(
          
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 237.w,
              child: AppTextFormField(
                backgroundColor: Color(0x17d9d9d9),
                controller: comment,

                hintText: S.of(context).Writeareview,
                suffixIcon: IconButton(
                  onPressed: () {
                    ServicesCubit.get(context).postComment(comment.text, 1, 5);
                  },
                  icon:
                      state is AddCommentLoading
                          ? SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                          : Icon(Icons.send),
                ),
              ),
            ),
            verticalSpace(10)
          ],
        );
      },
    );
  }
}
