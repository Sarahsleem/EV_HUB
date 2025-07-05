import 'package:evhub/core/helpers/extensions.dart';
import 'package:evhub/core/helpers/spacing.dart';
import 'package:evhub/core/routing/routes.dart';
import 'package:evhub/core/widgets/app_text_button.dart';
import 'package:evhub/core/widgets/image_network.dart';
import 'package:evhub/features/posts/logic/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class PostsUi extends StatefulWidget {
  const PostsUi({super.key});

  @override
  State<PostsUi> createState() => _PostsUiState();
}

class _PostsUiState extends State<PostsUi> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    PostsCubit.get(context).getPostsCategory().then((_) {
      PostsCubit.get(context).getPostsAll();
    });
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
              verticalSpace(22),
              BlocBuilder<PostsCubit, PostsState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 40.h,
                    child: BlocBuilder<PostsCubit, PostsState>(
                      builder: (context, state) {
                        if (state is PostsCategoryLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.LigGthGray,
                            ),
                          );
                        }
                        return ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsetsDirectional.only(start: 13.w),
                          children: [
                            GestureDetector(
                              onTap: () {
                                PostsCubit.get(context).getPostsAll();
                                PostsCubit.get(context).changeIndex(-1);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18.r),
                                  color:
                                      PostsCubit.get(context).currentIndex == -1
                                          ? Color(0x38ffffff)
                                          : Color(0xff435F72),
                                ),
                                child: Center(
                                  child: Text(
                                    S.of(context).All,
                                    textAlign: TextAlign.center,
                                    style: TextStyles.inter18WhiteMedium,
                                  ),
                                ),
                              ),
                            ),
                            horizontalSpace(10),
                            ListView.separated(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    PostsCubit.get(context).changeIndex(index);
                                    PostsCubit.get(context).getPostsByCategory(
                                      PostsCubit.get(
                                        context,
                                      ).categories[index].id,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.r),
                                      color:
                                          PostsCubit.get(
                                                    context,
                                                  ).currentIndex ==
                                                  index
                                              ? Color(0x38ffffff)
                                              : Color(0xff435F72),
                                    ),
                                    child: Center(
                                      child: Text(
                                        PostsCubit.get(
                                          context,
                                        ).categories[index].name,
                                        textAlign: TextAlign.center,
                                        style: TextStyles.inter18WhiteMedium,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (context, index) => horizontalSpace(10),
                              itemCount:
                                  PostsCubit.get(context).categories.length,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
              verticalSpace(20),
              BlocBuilder<PostsCubit, PostsState>(
                builder: (context, state) {
                  if (state is PostsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.LigGthGray,
                      ),
                    );
                  } else if (state is PostsErrorState) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).somethingWentWrong,
                            style: TextStyles.inter18WhiteMedium,
                          ),
                          verticalSpace(30),
                          AppTextButton(
                            buttonWidth: 200,
                            backgroundColor: ColorsManager.darkBlue,
                            buttonText: S.of(context).tryagain,
                            textStyle: TextStyles.inter18WhiteMedium,
                            onPressed: () {
                              didChangeDependencies();
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (PostsCubit.get(context).posts.isEmpty &&
                      state is PostsSuccessState) {
                    return Center(
                      child: Text(
                        S.of(context).noPosts,
                        style: TextStyles.inter18WhiteMedium,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemBuilder:
                        (context, index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                Routes.postsDetailsScreen,
                                arguments: PostsCubit.get(context).posts[index],
                              );
                            },
                            child: Stack(
                              children: [
                                AppCachedNetworkImage(
                                  image:
                                      PostsCubit.get(
                                        context,
                                      ).posts[index].featuredImage,
                                  width: double.infinity,
                                  height: 360.64.h,
                                  radius: 18.r,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0x00141e28),
                                        Color(0xed141e28),
                                      ],
                                    ),
                                    //color: Color(0x4d435f72),
                                    borderRadius: BorderRadius.circular(18.r),
                                  ),

                                  height: 360.h,
                                  child: Padding(
                                    padding: const EdgeInsets.all(23),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 97.w,
                                              child: Text(
                                                PostsCubit.get(context)
                                                    .posts[index]
                                                    .categories[0]
                                                    .name,
                                                style:
                                                    TextStyles
                                                        .inter14WhiteSemiBold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              formatDate(
                                                PostsCubit.get(
                                                  context,
                                                ).posts[index].date,
                                              ),
                                              style:
                                                  TextStyles
                                                      .inter14WhiteSemiBold,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          height: 70.h,
                                          child: Text(
                                            PostsCubit.get(context).posts[index].title,
                                            style: TextStyles.inter20greyBold.copyWith(color: Colors.white),
                                            //textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                          )

                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'images/png/chatbubble-ellipses-outline.png',
                                              height: 27.h,
                                              width: 27.w,
                                            ),
                                            Spacer(),
                                            // Image.asset(
                                            //   'images/png/arrow-redo-outline.png',
                                            //   height: 27.h,
                                            //   width: 27.w,
                                            // ),
                                            // Image.asset(
                                            //   'images/png/bookmark-outline.png',
                                            //   height: 27.h,
                                            //   width: 27.w,
                                            // ),
                                          ],
                                        ),
                                        //HtmlContentViewer(htmlContent: PostsCubit.get(context).posts[index].content),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: PostsCubit.get(context).posts.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
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
            textAlign: TextAlign.center,
            S.of(context).Blogs,
            style: TextStyles.inter18WhiteMedium,
          ),
        ),
        SizedBox(width: 20.w),
      ],
    );
  }
}

class HtmlContentViewer extends StatelessWidget {
  final String htmlContent;

  const HtmlContentViewer({super.key, required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlContent,
      style: {
        "h2": Style(textAlign:TextAlign.right,fontSize: FontSize.xxLarge, color: Colors.white),
        "h3": Style(textAlign:TextAlign.right,fontSize: FontSize.xLarge, color: Colors.teal.shade700),
        "p": Style(
          textAlign:TextAlign.right,
          fontSize: FontSize.medium,
          lineHeight: LineHeight.number(1.6),
          // maxLines: 1
        ),
        "strong": Style(textAlign:TextAlign.right,fontWeight: FontWeight.bold,),
        "ul": Style(textAlign:TextAlign.right,margin: Margins.only(bottom: 16)),
        "ol": Style(textAlign:TextAlign.right,margin: Margins.only(bottom: 16)),
      },
    );
  }
}

String formatDate(String dateString) {
  final dateTime = DateTime.parse(dateString);
  final formatted = DateFormat('d MMMM, y — h:mm a').format(dateTime);
  return formatted;
}
