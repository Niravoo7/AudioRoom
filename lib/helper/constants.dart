import 'dart:ui';

import 'package:flutter/material.dart';

class AppConstants {
  static const String var_APP_ID = "6a6e8941a95f4290b3569ce9f18ad8cc";

  //color
  static const Color clrWhite = Color(0xFFFFFFFF);
  static const Color clrRedAccent = Color(0xFFE90000);
  static const Color clrGreenAccent = Color(0xFF00FF00);
  static const Color clrGreen = Color(0xFF40BF5C);
  static const Color clrSwitchGreen = Color(0xFF34C759);
  static const Color clrBlue = Color(0xFF5478AC);
  static const Color clrYellowAccent = Color(0xFFFFAA1D);
  static const Color clrScaffoldBG = Color(0xFFE5E5E5);
  static const Color clrPrimary = Color(0xFFF7931A);

  static const Color clrDivider = Color(0xFFE9E9E9);
  static const Color clrDarkGrey = Color(0xFF9C9C9C);
  static const Color clrGrey = Color(0xFFE5E4E3);
  static const Color clrTitleBG = Color(0xFFFAF9F9);
  static const Color clrBlack = Color(0xFF000000);
  static const Color clrTransparent = Color(0x00000000);
  static const Color clrInputBorder = Color(0xFFEEEEEE);
  static const Color clrFollowers = Color(0xFF545454);
  static const Color clrText = Color(0xFF467187);
  static const Color clrBtnNo = Color(0x55FBBE8B);
  static const Color clrButtonBG = Color(0xFF212121);
  static const Color clrSettingBG = Color(0xFFFFFFF7);
  static const Color clrProfileBG = Color(0xFF25AE87);
  static const Color clrSearchBG = Color(0xFFE5E4E3);
  static const Color clrSearchIconColor = Color(0xFF898988);
  static const Color clrWidgetBGColor = Color(0xFFE6E4E3);

  //fonts
  static const String fontGothic = "Gothic";

  //size
  static const double size_double_extra_small = 8;
  static const double size_extra_small = 10;
  static const double size_small = 12;
  static const double size_small_medium = 13;
  static const double size_medium = 15;
  static const double size_medium_large = 17;
  static const double size_large = 18;
  static const double size_extra_large = 24;
  static const double size_double_extra_large = 34;
  static const double size_triple_extra_large = 60;

  static const double size_text_large = 24;
  static const double size_text_medium = 18;
  static const double size_text_small = 14;
  static const double size_input_text = 18;

  //images
  static const String root_image = "assets/images";
  static const String img_logo = '$root_image/img_logo.png';
  static const String img_logo_text = '$root_image/img_logo_text.png';
  static const String ic_uncheckbox = '$root_image/ic_uncheckbox.png';
  static const String ic_checkbox = '$root_image/ic_checkbox.png';
  static const String img_profile = '$root_image/img_profile.png';
  static const String img_search = '$root_image/img_search.png';
  static const String img_progress = '$root_image/img_progress.png';
  static const String img_close = '$root_image/img_close.png';
  static const String img_green_true = '$root_image/img_green_true.png';

  static const String ic_active = '$root_image/ic_active.png';
  static const String ic_home = '$root_image/ic_home.png';
  static const String ic_search = '$root_image/ic_search.png';
  static const String ic_upcoming = '$root_image/ic_upcoming.png';

  static const String ic_add_mail = '$root_image/ic_add_mail.png';
  static const String ic_add_user = '$root_image/ic_add_user.png';
  static const String ic_dark_home = '$root_image/ic_dark_home.png';
  static const String ic_edit = '$root_image/ic_edit.png';
  static const String ic_instagram = '$root_image/ic_instagram.png';
  static const String ic_leave_group = '$root_image/ic_leave_group.png';
  static const String ic_list = '$root_image/ic_list.png';
  static const String ic_lock = '$root_image/ic_lock.png';
  static const String ic_notification = '$root_image/ic_notification.png';
  static const String ic_raise_hand = '$root_image/ic_raise_hand.png';
  static const String ic_setting = '$root_image/ic_setting.png';
  static const String ic_speaker = '$root_image/ic_speaker.png';
  static const String ic_speaker_mute = '$root_image/ic_speaker_mute.png';
  static const String ic_star = '$root_image/ic_star.png';
  static const String ic_twitter = '$root_image/ic_twitter.png';
  static const String ic_clock = '$root_image/ic_clock.png';
  static const String ic_user = '$root_image/ic_user.png';
  static const String ic_user_profile = '$root_image/ic_user_profile.png';
  static const String ic_user_profile2 = '$root_image/ic_user_profile2.png';
  static const String ic_hide = '$root_image/ic_hide.png';
  static const String ic_closed = '$root_image/ic_closed.png';
  static const String ic_global = '$root_image/ic_global.png';
  static const String ic_social = '$root_image/ic_social.png';
  static const String ic_add_to_call = '$root_image/ic_add_to_call.png';
  static const String ic_copy_link = '$root_image/ic_copy_link.png';
  static const String ic_share = '$root_image/ic_share.png';
  static const String ic_add_upcoming_event =
      '$root_image/ic_add_upcoming_event.png';

  //string
  static const String str_app_name = "Audio Room";
  static const String str_no_network = "Please Check Your Internet Connection.";
  static const String str_no_record_found = "No Records found.";
  static const String str_no_room_found = "No Room found.";
  static const String str_email = "Email";
  static const String str_start_a_room = "+ Start a room";
  static const String str_your_mobile_number = "Your Mobile Number";
  static const String str_lorem =
      "AudioRoom is a Audio based social Network. Connecting 7 billion+ people through Audio.";
  static const String str_user_name = "User Name";
  static const String str_password = "Password";
  static const String str_first_name = "First Name";
  static const String str_last_name = "Last Name";
  static const String str_choose_your_username = "Choose your Username";
  static const String str_about = "About";
  static const String str_resend_otp = "Resend OTP";
  static const String str_mobile_number = "Mobile Number";
  static const String str_search = "Search";
  static const String str_skip = "Skip";
  static const String str_ok = "OK";
  static const String str_cancle = "CANCLE";
  static const String str_confirm_password = "Confirm Password";
  static const String str_continue = "Continue";
  static const String str_publish = "Publish";
  static const String str_create_account = "Create Account";
  static const String str_remember = "Remember Me";
  static const String str_registerText = "Don't have an account? Register";
  static const String str_loginText = "Have an account? Login";
  static const String str_sign_in = "Sign In";
  static const String str_request_code = "Request Code";
  static const String str_sign_up = "Sign Up";
  static const String str_tab_room = "Start A Room";
  static const String str_all_rooms = "All Rooms";
  static const String str_tab_home = "🙏 Welcome ";
  static const String str_tab_search = "Explore";
  static const String str_tab_upcoming = "Upcoming for you";
  static const String str_tab_active = "Active People & Clubs";
  static const String str_sign_out = "Sign Out";
  static const String str_forgot_password = "Forgot Password?";
  static const String str_enter_user_name = "User name required.";
  static const String str_enter_about = "About required.";
  static const String str_enter_profile_image = "Profile image required.";
  static const String str_enter_email = "Email address required.";
  static const String str_valid_email = "Please enter valid email.";
  static const String str_enter_mobile_number = "Mobile number required.";
  static const String str_event_name = "Event Name";
  static const String str_with = "With";
  static const String str_melinda_livsey = "Melinda Livsey";
  static const String str_date = "Date";
  static const String str_time = "Time";
  static const String str_description = "Description";
  static const String str_write_the_event_details = "Write the event details";
  static const String str_add_a_co_host_or_guest = "Add a Co-host or Guest";
  static const String str_write_a_title_for_the_event =
      "Write a title for the event";
  static const String str_valid_mobile_number =
      "Mobile number require 10 digits.";
  static const String str_enter_first_name = "First name required.";
  static const String str_enter_last_name = "Last name required.";
  static const String str_enter_code = "Verification code required.";
  static const String str_valid_code = "Verification code require 6 digits.";
  static const String str_enter_pwd = "Password required.";
  static const String str_valid_pwd =
      "Password should be at least 6 characters.";
  static const String str_enter_cpwd = "Confirm Password required.";
  static const String str_valid_cpwd =
      "Confirm Password should be at least 6 characters.";
  static const String str_password_Mismatch = "Password Mismatch!!";
  static const String str_question = "?";
  static const String str_yes = "Yes";
  static const String str_add = "Add";
  static const String str_follow = "Follow";
  static const String str_no = "No";
  static const String str_send = "Send";
  static const String str_something = "Something went wrong!";
  static const String str_are_you_sure_you_want_to_exit =
      "Are you sure you want to exit?";
  static const String str_exitApp = 'Exit App?';
  static const String str_image_url =
      "https://www.pavilionweb.com/wp-content/uploads/2017/03/user-300x300.png";
  static const String str_account_created =
      'Your account has been successfully created. We will text your when you can use your account or when someone invites you.';
  static const String str_followers = 'Followers';
  static const String str_following = 'Following';
  static const String str_invited = 'Invited';
  static const String str_invite = 'Invite';
  static const String str_room = '+ Room';
  static const String str_make_speaker = 'Make Speaker';
  static const String str_send_remainder = 'Send Remainder';
  static const String str_clubs_joined = 'Clubs Joined';
  static const String str_joined = 'Joined on ';
  static const String str_recommended_by = 'Recommended by';
  static const String str_lorem_ipsum =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eros, eleifend neque, arcu eget in tortor facilisi dignissim elementum. Fermentum semper turpis felis lacus, euismod egestas lorem malesuada a. Quam faucibus cras et tincidunt feugiat.';
  static const String str_search_for_people = 'Search for people';
  static const String str_search_for_clubs = 'Search for clubs';
  static const String str_search_for_people_and_club =
      'Search for people and club';
  static const String str_empty_invites_list =
      'You have 0 invites left. And You have 4 pending invites.';
  static const String str_pending_invites = 'Pending Invites';
  static const String str_top = 'Top';
  static const String str_all = 'All';
  static const String str_people = 'People';
  static const String str_active_people = 'Active People';
  static const String str_people_conversation =
      'People Interested in This Conversation';
  static const String str_clubs = 'Clubs';
  static const String str_active_clubs = 'Active Clubs';
  static const String str_view_more_people = 'View more people';
  static const String str_view_less_people = 'View less people';
  static const String str_view_more_club = 'View more club';
  static const String str_view_less_club = 'View less club';
  static const String str_ongoing = 'Ongoing';
  static const String str_upcoming_for_you = 'Upcoming for you';
  static const String str_upcoming = 'Upcoming';
  static const String str_hide_room = 'Hide Room';
  static const String str_show_room = 'Show Room';
  static const String str_clubs_to_follow = 'Clubs to Follow';
  static const String str_title = 'Title';
  static const String str_select_the_audience = 'Select The Audience';
  static const String str_select_club = 'Select Club';
  static const String str_write_a_title_for_the_conversation =
      'Write a title for the conversation';
  static const String str_global = 'Global';
  static const String str_social = 'Social';
  static const String str_closed = 'Closed';
  static const String str_start_a_room_small = 'Start a room';
  static const String str_choose_people = 'Choose people';
  static const String str_leave_quietly = 'Leave Quietly';
  static const String str_people_who_raised_hand = 'People who raised hand';
  static const String str_invite_people = 'Invite people';
  static const String str_make_a_speaker = 'Make a speaker';
  static const String str_move_to_audience = 'Move to audience';
  static const String str_view_full_profile = 'View full profile';
  static const String str_share = 'Share';
  static const String str_tweet = 'Tweet';
  static const String str_copy_link = 'Copy Link';
  static const String str_add_to_call = 'Add to Call';
  static const String str_clubName_is_already_used =
      'ClubName is already used. Try with another one!';
  static const String str_roomName_is_already_used =
      'RoomName is already used. Try with another one!';
  static const String str_member_online = 'members online';
  static const String str_title_required = 'Please enter title';
  static const String str_please_select_club_first = 'Please select club first';
  static const String str_room_already_exist = 'Room already exist';
  static const String str_please_select_1_user =
      'Please select at least 1 user';
  static const String str_leave = 'Leave';
  static const String str_join = 'Join';
}
