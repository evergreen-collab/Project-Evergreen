import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:provider/provider.dart';
import '../widgets/joy_nest_app_bar.dart';
import '../providers/settings_provider.dart';

class VideocallPage extends StatefulWidget {
  const VideocallPage({super.key});

  @override
  State<VideocallPage> createState() => _VideocallPageState();
}

class _VideocallPageState extends State<VideocallPage> {
  List<Contact> _contacts = [];
  bool _permissionDenied = false;
  bool _loaded = false;

  final List<SampleContact> _sampleContacts = [
    SampleContact(name: 'John Doe', phone: '+1 555 123 4567'),
    SampleContact(name: 'Jane Smith', phone: '+1 555 987 6543'),
    SampleContact(name: 'Alice Johnson', phone: '+1 555 222 3344'),
    SampleContact(name: 'Bob Williams', phone: '+1 555 333 4455'),
  ];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    try {
      if (!await FlutterContacts.requestPermission()) {
        setState(() {
          _permissionDenied = true;
          _loaded = true;
        });
        return;
      }
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {
        _contacts = contacts;
        _loaded = true;
      });
    } catch (e) {
      setState(() {
        _contacts = [];
        _loaded = true;
      });
    }
  }

  void _showVideoCallPopup({Contact? contact, SampleContact? sampleContact}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => VideoCallPopup(
        contact: contact,
        sampleContact: sampleContact,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    // Determine icon color based on theme
    final bool isDark = settings.darkMode || settings.highContrast;
    final Color sampleIconColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      appBar: const JoyNestAppBar(showBackButton: true),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : _permissionDenied
          ? const Center(child: Text('Contacts permission denied'))
          : (_contacts.isEmpty
          ? ListView.builder(
        itemCount: _sampleContacts.length,
        itemBuilder: (context, index) {
          final sample = _sampleContacts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: ContactCard(
              avatar: Icon(
                Icons.man_2_rounded,
                size: 56,
                color: sampleIconColor,
              ),
              name: sample.name,
              phone: sample.phone,
              onCall: () => _showVideoCallPopup(sampleContact: sample),
            ),
          );
        },
      )
          : ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          Widget avatar;
          if (contact.photoOrThumbnail != null) {
            avatar = CircleAvatar(
              radius: 36,
              backgroundImage: MemoryImage(contact.photoOrThumbnail!),
              backgroundColor: Colors.grey[700],
            );
          } else {
            avatar = CircleAvatar(
              radius: 36,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.man_2_rounded,
                size: 56,
                color: sampleIconColor,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: ContactCard(
              avatar: avatar,
              name: contact.displayName,
              phone: contact.phones.isNotEmpty
                  ? contact.phones.first.number
                  : 'No phone number',
              onCall: contact.phones.isNotEmpty
                  ? () => _showVideoCallPopup(contact: contact)
                  : null,
            ),
          );
        },
      )),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Widget avatar;
  final String name;
  final String phone;
  final VoidCallback? onCall;

  const ContactCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.phone,
    this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(24),
      color: Theme.of(context).cardColor.withValues(alpha: 0.97),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            avatar,
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    phone,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700]?.withValues(alpha: 0.95),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
                elevation: 4,
              ),
              onPressed: onCall,
              child: const Icon(Icons.videocam, size: 36, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoCallPopup extends StatelessWidget {
  final Contact? contact;
  final SampleContact? sampleContact;

  const VideoCallPopup({super.key, this.contact, this.sampleContact})
      : assert(contact != null || sampleContact != null);

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context, listen: false);
    final bool isDark = settings.darkMode || settings.highContrast;
    final Color sampleIconColor = isDark ? Colors.white : Colors.black;

    final String displayName =
        contact?.displayName ?? sampleContact?.name ?? '';
    final String? phone =
    contact?.phones.isNotEmpty == true ? contact!.phones.first.number : sampleContact?.phone;

    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Colors.black.withValues(alpha: 0.9),
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (contact?.photoOrThumbnail != null)
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: MemoryImage(contact!.photoOrThumbnail!),
                      backgroundColor: Colors.grey[700],
                    )
                  else
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.man_2_rounded,
                        size: 60,
                        color: sampleIconColor,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (phone != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      phone,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  const Text(
                    'Connecting...',
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.call_end, size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SampleContact {
  final String name;
  final String phone;
  const SampleContact({required this.name, required this.phone});
}
