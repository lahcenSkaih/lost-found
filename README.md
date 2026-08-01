# lost_found

A new Flutter project.

# Project Structure
lib/
├── main.dart
├── app/
│   ├── app.dart                      # GetMaterialApp setup, theme, initial route
│   ├── routes/
│   │   ├── app_routes.dart           # route name constants
│   │   └── app_pages.dart            # GetPage list mapping routes → views/bindings
│   └── theme/
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       └── app_theme.dart
│
├── core/
│   ├── constants/
│   │   ├── item_categories.dart      # enum: idCard, wallet, creditCard, document, other
│   │   └── app_constants.dart
│   ├── services/
│   │   ├── auth_service.dart         # Firebase Auth wrapper, Get.put at startup
│   │   ├── firestore_service.dart    # generic CRUD helpers
│   │   ├── storage_service.dart      # image upload/blur logic
│   │   ├── location_service.dart     # geolocator/geocoding wrapper
│   │   └── notification_service.dart # FCM setup
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── image_blur_helper.dart
│   │   └── date_formatter.dart
│   └── widgets/                      # shared/reusable widgets
│       ├── custom_button.dart
│       ├── custom_textfield.dart
│       ├── item_card.dart
│       └── loading_indicator.dart
│
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── item_model.dart
│   │   ├── claim_model.dart
│   │   └── chat_model.dart
│   └── repositories/
│       ├── user_repository.dart
│       ├── item_repository.dart
│       ├── claim_repository.dart
│       └── chat_repository.dart
│
└── features/
    ├── auth/
    │   ├── bindings/
    │   │   └── auth_binding.dart
    │   ├── controllers/
    │   │   ├── login_controller.dart
    │   │   └── otp_controller.dart
    │   └── views/
    │       ├── login_view.dart
    │       └── otp_view.dart
    │
    ├── home/
    │   ├── bindings/
    │   │   └── home_binding.dart
    │   ├── controllers/
    │   │   └── home_controller.dart      # feed list, filters, pagination
    │   └── views/
    │       ├── home_view.dart
    │       └── widgets/
    │           └── filter_bar.dart
    │
    ├── map/
    │   ├── bindings/
    │   │   └── map_binding.dart
    │   ├── controllers/
    │   │   └── map_controller.dart
    │   └── views/
    │       └── map_view.dart
    │
    ├── post_item/
    │   ├── bindings/
    │   │   └── post_item_binding.dart
    │   ├── controllers/
    │   │   └── post_item_controller.dart # form state, image picker, category fields
    │   └── views/
    │       ├── post_item_view.dart
    │       └── widgets/
    │           └── category_fields_form.dart
    │
    ├── item_detail/
    │   ├── bindings/
    │   │   └── item_detail_binding.dart
    │   ├── controllers/
    │   │   └── item_detail_controller.dart
    │   └── views/
    │       └── item_detail_view.dart
    │
    ├── claim/
    │   ├── bindings/
    │   │   └── claim_binding.dart
    │   ├── controllers/
    │   │   └── claim_controller.dart     # verification Q&A flow
    │   └── views/
    │       └── claim_view.dart
    │
    ├── chat/
    │   ├── bindings/
    │   │   └── chat_binding.dart
    │   ├── controllers/
    │   │   └── chat_controller.dart
    │   └── views/
    │       └── chat_view.dart
    │
    └── profile/
        ├── bindings/
        │   └── profile_binding.dart
        ├── controllers/
        │   └── profile_controller.dart
        └── views/
            └── profile_view.dart



