import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String ticket = '';

  void _startScan() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerScreen()),
    );

    if (result != null && result is String) {
      setState(() {
        ticket = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Scanner',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.wallet_giftcard,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Concorra a prêmios',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Ao escanear uma nota, você ganha descontos e concorre a prêmios.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8BE78E),
                          foregroundColor: Colors.black,
                          textStyle: const TextStyle(fontSize: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.zero,
                          elevation: 0,
                        ),
                        child: const Text('Conferir prêmios'),
                      ),
                    ),
                  ),

                  if (ticket.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        'Ticket: $ticket',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Últimas notas escaneadas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _startScan,
        backgroundColor: const Color(0xFF8BE78E),
        foregroundColor: Colors.black,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Escanear'),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escaneie o QR Code')),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            if (code != null) {
              Navigator.pop(context, code);

              break;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('QR Code inválido.')),
              );
            }
          }
        },
      ),
    );
  }
}
// class QRScannerScreen extends StatelessWidget {
//   const QRScannerScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const fakeQrUrl =
//         'https://nfeweb.sefaz.go.gov.br/nfeweb/sites/nfce/danfeNFCe?p=52250906948636000146650180001466341002356983%7C2%7C1%7C1%7Ca74b2cc3f9e1050c96f05d758042063f1f84bb4b';

//     return Scaffold(
//       appBar: AppBar(title: const Text('Simulador de QR Code')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context, fakeQrUrl);
//           },
//           child: const Text('Simular leitura de QR Code'),
//         ),
//       ),
//     );
//   }
// }
