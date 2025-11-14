import 'package:emotional_release/main.dart';
import 'package:emotional_release/pages/emotional_first/emotional_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'emotional_detail_logic.dart';

class EmotionalDetailPage extends GetView<EmotionalDetailLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Detail'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: <Widget>[
          
          _buildEmotionHeader(),
          const SizedBox(height: 15),

          
          _buildIntensitySection(),
          const SizedBox(height: 15),

          
          _buildTriggersSection(),
          const SizedBox(height: 15),

          
          _buildFeelingsSection(),
          const SizedBox(height: 15),

          
          _buildContentSection(),
          const SizedBox(height: 15),

          
          _buildReflectionSection(),
          const SizedBox(height: 20),

          
          _buildSaveButton(),
        ].toColumn(),
      ),
    );
  }

  Widget _buildEmotionHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.1),
            primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor.withOpacity(0.3), width: 2),
      ),
      child: <Widget>[
        Image.asset(
          'assets/icon${controller.entity.type}.png',
          width: 60,
          height: 60,
        ),
        const SizedBox(height: 10),
        Text(
          moodTypes[controller.entity.type],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          controller.entity.createdTimeStr,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ].toColumn(mainAxisSize: MainAxisSize.min),
    );
  }

  Widget _buildIntensitySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: <Widget>[
        Row(
          children: [
            Icon(Icons.favorite, color: primaryColor, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Intensity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              controller.entity.intensityStars,
              style: const TextStyle(fontSize: 28, color: Colors.amber),
            ),
            const SizedBox(width: 10),
            Text(
              '${controller.entity.intensity} / 5',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildTriggersSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: <Widget>[
        Row(
          children: [
            Icon(Icons.flash_on, color: primaryColor, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Triggers',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 10),
        controller.entity.triggers.isEmpty
            ? const Text(
                'None',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.entity.triggers.map((trigger) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: primaryColor, width: 1),
                    ),
                    child: Text(
                      trigger,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildFeelingsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: <Widget>[
        Row(
          children: [
            Icon(Icons.healing, color: primaryColor, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Physical Sensations',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 10),
        controller.entity.physicalFeelings.isEmpty
            ? const Text(
                'None',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.entity.physicalFeelings.map((feeling) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.orange, width: 1),
                    ),
                    child: Text(
                      feeling,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  );
                }).toList(),
              ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildContentSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: <Widget>[
        Row(
          children: [
            Icon(Icons.notes, color: primaryColor, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          controller.entity.content.isEmpty
              ? 'No notes'
              : controller.entity.content,
          style: TextStyle(
            fontSize: 14,
            color: controller.entity.content.isEmpty
                ? Colors.grey
                : Colors.black87,
            height: 1.5,
          ),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildReflectionSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor.withOpacity(0.3), width: 2),
      ),
      child: <Widget>[
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Reflection',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Text(
          'Add your thoughts after the fact',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 15),
        Obx(() => EmotionalTextField(
              padding: const EdgeInsets.all(12),
              value: controller.reflectionText.value,
              textAlign: TextAlign.start,
              hintText: 'Looking back, what do you think about this moment?',
              maxLines: 8,
              maxLength: 500,
              onChange: (v) {
                controller.reflectionText.value = v;
              },
            )),
        if (controller.entity.hasReflection) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.schedule, size: 14, color: Colors.grey),
              const SizedBox(width: 5),
              Text(
                'Last updated: ${controller.entity.reflectionTime != null ? controller.entity.reflectionTime!.toString().substring(0, 16) : ""}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Text(
        'Save Reflection',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    ).gestures(onTap: () {
      controller.saveReflection();
    });
  }
}

