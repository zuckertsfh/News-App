import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/models.dart';
import 'package:news_app/ui/widgets/widgets.dart';
import 'package:news_app/utils/helper.dart';
import 'package:news_app/utils/scale_ui.dart';
import 'package:news_app/view_model/vm.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_page.dart';
part 'detail_page.dart';
part 'category_page.dart';