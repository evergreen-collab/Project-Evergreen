import 'package:evergreen/widgets/joy_nest_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  int selectedMood = -1;

  final List<Medication> medications = [
    Medication(
      name: 'Ibuprofen',
      amount: '200mg',
      schedule: ['08:00', '20:00'],
    ),
    Medication(
      name: 'Amoxicillin',
      amount: '500mg',
      schedule: ['09:00', '21:00'],
    ),
  ];

  final List<Appointment> appointments = [
    Appointment(
      doctor: 'Dr. Smith',
      specialization: 'Cardiologist',
      time: DateTime.now().add(const Duration(days: 1, hours: 3)),
      location: 'City Clinic',
    ),
    Appointment(
      doctor: 'Dr. Adams',
      specialization: 'Dermatologist',
      time: DateTime.now().add(const Duration(days: 3)),
      location: 'Health Center',
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (final med in medications) {
      med.simulateLastTaken();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final containerColor = bgColor.withOpacity(0.1);

    return Scaffold(
      appBar: JoyNestAppBar(showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            const Center(
              child: Text(
                "Medication and appoitments",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "How are you feeling today?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(child: MoodSelector()),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "Medication",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ...medications.map(
              (med) => MedicationCard(
                medication: med,
                containerColor: containerColor,
                onTaken: () {
                  setState(() {
                    med.markAsTaken();
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "Doctor Appointments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ...appointments.map(
              (appt) => AppointmentCard(
                appointment: appt,
                containerColor: containerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodSelector extends StatefulWidget {
  @override
  _MoodSelectorState createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  int selectedMood = -1; // No mood selected initially

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(5, (index) {
        final colors = [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.lightGreen,
          Colors.green,
        ];
        final emojis = ['😞', '😕', '😐', '🙂', '😄'];

        Color backgroundColor =
            selectedMood == index
                ? colors[index]
                : colors[index].withOpacity(0.35);

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedMood = index;
            });
          },
          child: CircleAvatar(
            backgroundColor: backgroundColor,
            radius: 22,
            child: Text(emojis[index], style: const TextStyle(fontSize: 20)),
          ),
        );
      }),
    );
  }
}

// Medication model
class Medication {
  final String name;
  final String amount;
  final List<String> schedule;
  DateTime? lastTaken;

  Medication({
    required this.name,
    required this.amount,
    required this.schedule,
  });

  void markAsTaken() {
    lastTaken = DateTime.now();
  }

  void simulateLastTaken() {
    final now = DateTime.now();
    for (final time in schedule.reversed) {
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      final possibleTime = DateTime(now.year, now.month, now.day, hour, minute);
      if (possibleTime.isBefore(now)) {
        lastTaken = possibleTime;
        return;
      }
    }
    lastTaken = now.subtract(const Duration(hours: 1));
  }

  String get nextTime {
    final now = DateTime.now();
    for (final time in schedule) {
      final parts = time.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      final todayTime = DateTime(now.year, now.month, now.day, hour, minute);
      if (now.isBefore(todayTime)) {
        return DateFormat('HH:mm').format(todayTime);
      }
    }
    final firstTime = schedule.first.split(':');
    final tomorrow = DateTime(
      now.year,
      now.month,
      now.day + 1,
      int.parse(firstTime[0]),
      int.parse(firstTime[1]),
    );
    return DateFormat('HH:mm').format(tomorrow);
  }
}

// Medication card
class MedicationCard extends StatelessWidget {
  final Medication medication;
  final Color containerColor;
  final VoidCallback onTaken;

  const MedicationCard({
    super.key,
    required this.medication,
    required this.containerColor,
    required this.onTaken,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  const Text('💊 ', style: TextStyle(fontSize: 18)),
                  Text(
                    medication.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💊 Amount: ${medication.amount}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '⏱️ Last taken: ${medication.lastTaken != null ? DateFormat('HH:mm').format(medication.lastTaken!) : 'Never'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '⏰ Next scheduled: ${medication.nextTime}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (_) => onTaken()),
                      const Text(
                        "Mark as taken now",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
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

// Appointment model
class Appointment {
  final String doctor;
  final String specialization;
  final DateTime time;
  final String location;

  Appointment({
    required this.doctor,
    required this.specialization,
    required this.time,
    required this.location,
  });
}

// Appointment card
class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final Color containerColor;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  const Text('🧑‍⚕️ ', style: TextStyle(fontSize: 18)),
                  Text(
                    appointment.doctor,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🏥 Specialization: ${appointment.specialization}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '📅 Time: ${DateFormat('yyyy-MM-dd HH:mm').format(appointment.time)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '📍 Location: ${appointment.location}',
                    style: TextStyle(fontSize: 16),
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
