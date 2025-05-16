import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:trade_marketing_app/app/app_widget.dart';

enum ToastType {
  success,
  error,
  warning,
  info,
}

ToastificationType _mapToastType(ToastType type) {
  switch (type) {
    case ToastType.success:
      return ToastificationType.success;
    case ToastType.error:
      return ToastificationType.error;
    case ToastType.warning:
      return ToastificationType.warning;
    case ToastType.info:
      return ToastificationType.info;
  }
}

Color _getToastColor(ToastType type) {
  switch (type) {
    case ToastType.success:
      return const Color(0xFF009822); // Verde para sucesso
    case ToastType.error:
      return const Color(0xFFFF0000); // Vermelho para erro
    case ToastType.warning:
      return const Color(0xFFFFA500); // Laranja para aviso
    case ToastType.info:
      return const Color(0xFF1E90FF); // Azul para informação
  }
}

IconData _getIconByType(ToastType type) {
  switch (type) {
    case ToastType.success:
      return Icons.check; // Ícone de sucesso
    case ToastType.error:
      return Icons.error; // Ícone de erro
    case ToastType.warning:
      return Icons.warning; // Ícone de aviso
    case ToastType.info:
      return Icons.info; // Ícone de informação
    default:
      return Icons.info; // Ícone padrão
  }
}

void showToast({
  required ToastType type,
  required String title,
  required String description,
}) {
  final context = globalScaffoldMessageKey.currentContext;
  if (context != null) {
    toastification.show(
      context: context,
      type: _mapToastType(type), // Mapeia para ToastificationType
      style: ToastificationStyle.flat,
      title: Text(title),
      icon: Icon(_getIconByType(type)),
      description: Text(description),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 4),
      primaryColor: _getToastColor(type), // Define a cor personalizada
      borderRadius: BorderRadius.circular(12.0),
      showProgressBar: true,
    );
  } else {
    debugPrint('Contexto global não está disponível.');
  }
}
