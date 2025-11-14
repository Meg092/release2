import 'package:emotional_release/components/emotional_heatmap_calendar.dart';
import 'package:emotional_release/components/emotional_trend_chart.dart';
import 'package:emotional_release/components/emotional_trigger_pie_chart.dart';
import 'package:emotional_release/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'emotional_second_logic.dart';

class EmotionalSecondPage extends GetView<EmotionalSecondLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: <Widget>[
            
            _buildHeader(),
            
            
            _buildViewSwitch(),
            
            const SizedBox(height: 10),
            
            
            Expanded(
              child: Obx(() => controller.viewMode.value == 'statistics'
                ? _buildStatisticsView()
                : _buildRecordsView()
              )
            )
          ].toColumn(),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
            'Release record',
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
      ),
    );
  }

  Widget _buildViewSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.switchViewMode('statistics'),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.viewMode.value == 'statistics'
                      ? primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  'Statistics',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: controller.viewMode.value == 'statistics'
                        ? Colors.white
                        : primaryColor,
                  ),
                ),
              ),
            )),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Obx(() => GestureDetector(
              onTap: () => controller.switchViewMode('records'),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.viewMode.value == 'records'
                      ? primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  'Records',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: controller.viewMode.value == 'records'
                        ? Colors.white
                        : primaryColor,
                  ),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: <Widget>[
        
        _buildDateRangeSelector(),
        const SizedBox(height: 15),
        
        
        Obx(() {
          final stats = controller.statisticsData.value;
          if (stats == null) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Total Records',
                        stats.totalRecords.toString(),
                        Icons.article_outlined,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        'Avg Intensity',
                        stats.averageIntensity.toStringAsFixed(2),
                        Icons.favorite_outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        
        const SizedBox(height: 15),
        
        
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Emotion Trend',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
              Obx(() {
                final stats = controller.statisticsData.value;
                if (stats == null) {
                  return const SizedBox(height: 250);
                }
                return EmotionalTrendChart(
                  data: stats.dailyEmotions,
                  dateRange: controller.dateRange.value,
                );
              }),
            ],
          ),
        ),
        
        const SizedBox(height: 15),
        
        
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Emotion Calendar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
              Obx(() {
                final stats = controller.statisticsData.value;
                if (stats == null) {
                  return const SizedBox(height: 200);
                }
                final Map<DateTime, double> intensityMap = {};
                for (var daily in stats.dailyEmotions) {
                  intensityMap[daily.date] = daily.averageIntensity;
                }
                return EmotionalHeatmapCalendar(
                  intensityData: intensityMap,
                );
              }),
            ],
          ),
        ),
        
        const SizedBox(height: 15),
        
        
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Trigger Analysis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
              ),
              Obx(() {
                final stats = controller.statisticsData.value;
                if (stats == null) {
                  return const SizedBox(height: 300);
                }
                return EmotionalTriggerPieChart(
                  triggerData: stats.triggerCount,
                );
              }),
            ],
          ),
        ),
        
        const SizedBox(height: 15),
        
        
        Container(
          width: double.infinity,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withOpacity(0.8)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.assessment, color: Colors.white, size: 24),
              SizedBox(width: 10),
              Text(
                'View Weekly Report',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ).gestures(onTap: () {
          Get.toNamed('/emotionalWeeklyReport');
        }),
      ].toColumn(),
    );
  }

  Widget _buildDateRangeSelector() {
    return Obx(() => Row(
      children: [
        _buildDateRangeButton('Week', 'week'),
        const SizedBox(width: 10),
        _buildDateRangeButton('Month', 'month'),
        const SizedBox(width: 10),
        _buildDateRangeButton('All', 'all'),
      ],
    ));
  }

  Widget _buildDateRangeButton(String label, String value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeDateRange(value),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.dateRange.value == value
                ? primaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: primaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: controller.dateRange.value == value
                  ? Colors.white
                  : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30, color: primaryColor),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRecordsView() {
    return Obx(() {
            return controller.list.isEmpty
                ? const Center(
              child: Text('No data'),
            )
                : ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: controller.list.length,
                itemBuilder: (_, index) {
                  final entity = controller.list[index];
                return _buildRecordItem(entity);
              });
    });
  }

  Widget _buildRecordItem(entity) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
                    child: <Widget>[
                      <Widget>[
          Image.asset('assets/icon${entity.type}.png', width: 50, height: 50),
                        Text(
                          moodTypes[entity.type],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                        )
                      ].toColumn(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min),
        Container(width: 1, height: 70)
            .decorated(color: Colors.grey[300])
            .marginSymmetric(horizontal: 10),
                      Expanded(
                          child: <Widget>[
                            Text(
                              entity.createdTimeStr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
          Text(
            entity.intensityStars,
            style: const TextStyle(fontSize: 14, color: Colors.amber),
          ),
          if (entity.content.isNotEmpty)
                            Text(
                              entity.content,
                              style: const TextStyle(color: Color(0xff555555)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start))
                    ].toRow(),
    ).gestures(onTap: () async {
      final result = await Get.toNamed(
        '/emotionalDetail',
        arguments: entity.id,
      );
      if (result == true) {
        controller.getData();
      }
    });
  }
}
