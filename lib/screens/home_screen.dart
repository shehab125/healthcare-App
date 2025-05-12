import 'package:medical_app_base/screens/doctor_favorites_page.dart';

                    _buildCategoryButton(
                      icon: Icons.favorite_border,
                      label: 'Favorite',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Favorites'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.medical_services, color: Color(0xFF3EC8D6)),
                                  title: const Text('Favorite Doctors'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const DoctorFavoritesPage()),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.local_pharmacy, color: Color(0xFF3EC8D6)),
                                  title: const Text('Favorite Pharmacies'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const PharmacyFavoritesPage()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ), 