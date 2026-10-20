
import 'package:flutter/material.dart';

enum InstituteEnum {
  kindergarten,
  elementarySchool,
  middleSchool,
  highSchool,
  college,
  university,
  vocationalSchool,
  culinarySchool,
  musicSchool,
  artSchool,
  fitnessSchool,
  karateSchool,
  swimmingSchool,
  languageSchool,
  drivingSchool,
  diplomaPrograms,
  genericSchool,
}

extension InstituteEnumExtension on InstituteEnum {
  String get label {
    switch (this) {
      case InstituteEnum.kindergarten:
        return 'Kindergarten 🌈 - Bright, playful design for young children';
      case InstituteEnum.elementarySchool:
        return 'Elementary School 🏫 - Bright, engaging design for young learners';
      case InstituteEnum.middleSchool:
        return 'Middle School 🎒 - Balanced design for transitional years';
      case InstituteEnum.highSchool:
        return 'High School 🎓 - Dynamic, aspirational design for teens';
      case InstituteEnum.college:
        return 'College 🎓 - Modern, sophisticated design';
      case InstituteEnum.university:
        return 'University 🏛 - Academic, prestigious design';
      case InstituteEnum.vocationalSchool:
        return 'Vocational School 🔧 - Practical, hands-on design';
      case InstituteEnum.culinarySchool:
        return 'Culinary School 👨‍🍳 - Warm, appetizing design';
      case InstituteEnum.musicSchool:
        return 'Music School 🎵 - Creative, artistic design';
      case InstituteEnum.artSchool:
        return 'Art School 🎨 - Inspiring, expressive design';
      case InstituteEnum.fitnessSchool:
        return 'Fitness School 💪 - Energetic, motivational design';
      case InstituteEnum.karateSchool:
        return 'Karate School 🥋 - Disciplined, traditional design';
      case InstituteEnum.swimmingSchool:
        return 'Swimming School 🏊 - Aquatic, refreshing design';
      case InstituteEnum.languageSchool:
        return 'Language School 🌍 - Global, communicative design';
      case InstituteEnum.drivingSchool:
        return 'Driving School 🚗 - Dynamic, safety-focused design';
      case InstituteEnum.diplomaPrograms:
        return 'Diploma Programs 🏆 - Achievement-focused design';
      case InstituteEnum.genericSchool:
        return 'Generic School 🏫 - Default professional design';
    }
  }

  /// Category grouping (for UI headers)
  String get category {
    switch (this) {
      case InstituteEnum.kindergarten:
        return "Early Childhood";
      case InstituteEnum.elementarySchool:
      case InstituteEnum.middleSchool:
      case InstituteEnum.highSchool:
      case InstituteEnum.college:
      case InstituteEnum.university:
        return "Academic Institutions";
      case InstituteEnum.vocationalSchool:
      case InstituteEnum.culinarySchool:
        return "Specialized Training";
      case InstituteEnum.musicSchool:
      case InstituteEnum.artSchool:
        return "Arts & Creative";
      case InstituteEnum.fitnessSchool:
      case InstituteEnum.karateSchool:
      case InstituteEnum.swimmingSchool:
        return "Physical Training";
      case InstituteEnum.languageSchool:
        return "Language & Communication";
      case InstituteEnum.drivingSchool:
        return "Transportation";
      case InstituteEnum.diplomaPrograms:
        return "Specialized Programs";
      case InstituteEnum.genericSchool:
        return "Generic";
    }
  }
  IconData get icon {
    switch (this) {
      case InstituteEnum.kindergarten:
        return Icons.child_care;
      case InstituteEnum.elementarySchool:
        return Icons.school;
      case InstituteEnum.middleSchool:
        return Icons.backpack;
      case InstituteEnum.highSchool:
        return Icons.emoji_events;
      case InstituteEnum.college:
        return Icons.account_balance;
      case InstituteEnum.university:
        return Icons.account_balance_outlined;
      case InstituteEnum.vocationalSchool:
        return Icons.build;
      case InstituteEnum.culinarySchool:
        return Icons.restaurant_menu;
      case InstituteEnum.musicSchool:
        return Icons.music_note;
      case InstituteEnum.artSchool:
        return Icons.brush;
      case InstituteEnum.fitnessSchool:
        return Icons.fitness_center;
      case InstituteEnum.karateSchool:
        return Icons.sports_martial_arts;
      case InstituteEnum.swimmingSchool:
        return Icons.pool;
      case InstituteEnum.languageSchool:
        return Icons.language;
      case InstituteEnum.drivingSchool:
        return Icons.directions_car;
      case InstituteEnum.diplomaPrograms:
        return Icons.workspace_premium;
      case InstituteEnum.genericSchool:
        return Icons.apartment;
    }
  }
}


