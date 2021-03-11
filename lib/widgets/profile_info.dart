import 'package:FlutterGalleryApp/store/unsplash/models/models.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
    this.profile,
  }) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildProfileInfo(context),
          SizedBox(height: 20),
          if (profile.bio != null) _buildBiography(context),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserAvatar(
            avatarLink: profile.profileImage.large,
            width: 75,
            height: 75,
          ),
          SizedBox(width: 18),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${profile.name}',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            '${profile.followersCount}',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      color: AppColors.dodgerBlue,
                                      letterSpacing: -0.47,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'followers',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.08,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Text(
                            '${profile.followingCount}',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      color: AppColors.dodgerBlue,
                                      letterSpacing: -0.47,
                                    ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'following',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      letterSpacing: -0.08,
                                    ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 6),
                if (profile.location != null)
                  Row(
                    children: [
                      Icon(
                        AppIcons.location,
                        size: 14,
                        color: AppColors.dodgerBlue,
                      ),
                      SizedBox(width: 7),
                      Container(
                        width: 220,
                        child: Text(
                          "${profile.location}",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                letterSpacing: -0.08,
                              ),
                        ),
                      )
                    ],
                  ),
                SizedBox(height: 5),
                if (profile.portfolioUrl != null)
                  Row(
                    children: [
                      Icon(
                        AppIcons.link,
                        size: 14,
                        color: AppColors.dodgerBlue,
                      ),
                      SizedBox(width: 8),
                      InkWell(
                        onTap: () => launch(profile.portfolioUrl),
                        child: Container(
                          width: 220,
                          child: Text(
                            "${profile.portfolioUrl}",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      letterSpacing: -0.08,
                                    ),
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiography(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ExpandableText(
        "${profile.bio}",
        trimLines: 3,
        buttonStyle: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
        textStyle: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: FontWeight.w300,
              color: AppColors.black,
            ),
      ),
    );
  }
}
