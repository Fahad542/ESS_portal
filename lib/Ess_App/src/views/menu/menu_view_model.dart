import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:stacked/stacked.dart';
import '../login/local/local_db.dart';
class CustomMenuItem {
  final String label;
  final GestureTapCallback onPress;
  final bool isParent;
  final List<CustomMenuItem>? children;

  CustomMenuItem({
    required this.label,
    required this.onPress,
    required this.isParent,
    this.children,
  });
}

class MenuViewModel extends ReactiveViewModel with ApiViewModel, AuthViewModel {
  final BuildContext context;

  MenuViewModel(this.context);

  int collapsedIndex = -1;
  bool? checktabledata;
  final dbHelper = DatabaseHelper();
  Future<void> checktable() async {
    checktabledata = await  dbHelper.checkTable();
    print("table data: ${checktabledata}");
    notifyListeners();
  }

  void init(BuildContext context){
    checktable();
  }
  changeIndex(int index) {
    if (collapsedIndex == index) {
      collapsedIndex = -1;
    } else {
      collapsedIndex = index;
    }
    notifyListeners();
  }

  onLogout() async
  {

    FlutterBackgroundService().sendData({"action": "stopService"});
    Scaffold.of(context).closeDrawer();
    authService.user = null;
    authService.logout();
    print(authService.user);
    NavService.appmenu();
  }


  List<CustomMenuItem> get menuItems => [
        CustomMenuItem(
          label: "Dashboard",
          isParent: true,
          onPress: () {
            changeIndex(-1);
            NavService.dashboard();
            Scaffold.of(context).closeDrawer();
          },
        ),
        CustomMenuItem(
            label: "Attendance",
            isParent: true,
            onPress: () {
              changeIndex(1);
            },
            children: [
              CustomMenuItem(
                label: "Your Attendance",
                isParent: false,
                onPress: () {
                  NavService.yourAttendance();
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ]),
        CustomMenuItem(
            label: "Leaves / Visits",
            isParent: true,
            onPress: () {
              changeIndex(2);
            },
            children: [
              CustomMenuItem(
                label: "Leaves Form",
                isParent: false,
                onPress: () {
                  NavService.applyLeave();
                  Scaffold.of(context).closeDrawer();
                },
              ),
              CustomMenuItem(
                label: "Pending Leave Approval",
                isParent: false,
                onPress: () {
                  NavService.Pendingapproval();
                  Scaffold.of(context).closeDrawer();
                },
              ),
              CustomMenuItem(
                label: "Your Leave Applications",
                isParent: false,
                onPress: () {
                  NavService.leaveApplications();
                  Scaffold.of(context).closeDrawer();
                },
              ),
              CustomMenuItem(
                label: "Visit Form",
                isParent: false,
                onPress: () {
                  NavService.applyVisit();
                  Scaffold.of(context).closeDrawer();
                },
              ),
              CustomMenuItem(
                label: "Pending Visit Approval",
                isParent: false,
                onPress: () {
                  NavService.Pendingvisitapproval();
                  Scaffold.of(context).closeDrawer();
                },
              ),
              CustomMenuItem(
                label: "Your All Visits",
                isParent: false,
                onPress: () {
                  NavService.visits();
                  Scaffold.of(context).closeDrawer();
                },
              ),
            ]
        ),
        CustomMenuItem(
            label: "Reservation",
            isParent: true,
            onPress: () {
              changeIndex(3);
            },
            children: [
              CustomMenuItem(
                label: "Reserve Board Room",
                isParent: false,
                onPress: () {
                  NavService.reserveBoardRoom();
                  Scaffold.of(context).closeDrawer();
                },
              ),
              CustomMenuItem(
                label: "See All Reservation",
                isParent: false,
                onPress: () {NavService.allReservations();Scaffold.of(context).closeDrawer();},
              ),
            ]
        ),
        CustomMenuItem(
            label: "Advance",
            isParent: true,
            onPress: () {
              changeIndex(4);
            },
            children: [
              if(authService.user?.AdvFinApp == 'yes')
              CustomMenuItem(
                label: "Final Advance Approval",
                isParent: false,
                onPress: () {NavService.Final_advance();Scaffold.of(context).closeDrawer();},
              ),
              CustomMenuItem(
                label: "Request Advance",
                isParent: false,
                onPress: () {NavService.Request_advance();Scaffold.of(context).closeDrawer();},
              ),
              CustomMenuItem(
                label: "Line Manager Approval",
                isParent: false,
                onPress: () {NavService.line_manager();Scaffold.of(context).closeDrawer();},
              ),

            ]
        ),
        CustomMenuItem(
        label: "Loan",
        isParent: true,
        onPress: () {
          changeIndex(5);
        },
        children: [
          CustomMenuItem(
            label: "Apply Loan",
            isParent: false,
            onPress: () {NavService.loan();Scaffold.of(context).closeDrawer();},
          ),
          CustomMenuItem(
            label: "See All Loan",
            isParent: false,
            onPress: () {

              NavService.allloan();
              Scaffold.of(context).closeDrawer();
            },
          ),
          CustomMenuItem(
            label: "Pending Guarantees",
            isParent: false,
            onPress: () {NavService.pending_guarantees();Scaffold.of(context).closeDrawer();},
          ),

          if(authService.user?.role == 'hod')
            CustomMenuItem(
              label: "Pending HOD Approvals",
              isParent: false,
              onPress: () {

                NavService.pending_hod_approval();
                Scaffold.of(context).closeDrawer();
              },
            ),
          if(authService.user?.userId == '99917864' || authService.user?.userId == '99938' || authService.user?.userId == '999850' || authService.user?.userId == '99946879' )
          CustomMenuItem(
            label: "Director Loan Approvals",
            isParent: false,
            onPress: () {

              NavService.director_approval();
              Scaffold.of(context).closeDrawer();
            },
          ),

        ]
    ),
        CustomMenuItem(
        label: "Copex",
        isParent: true,
        onPress: () {
          changeIndex(6);
        },
        children: [
          CustomMenuItem(
            label: "Capex Form",
            isParent: false,
            onPress: () {

              NavService.capexform();
              Scaffold.of(context).closeDrawer();
            },
          ),
          CustomMenuItem(
            label: "Generate Capex",
            isParent: false,
            onPress: () {

              NavService.Generatecapex();
              Scaffold.of(context).closeDrawer();
            },
          ),
        ]
    ),
    if(authService.user?.is_qms == 1)
    CustomMenuItem(
        label: "QMS",
        isParent: true,
        onPress: () {

          changeIndex(7);
        },
        children: [
          CustomMenuItem(
            label: "Create new sheet",
            isParent: false,
            onPress: () {

              NavService.createsheet();
              Scaffold.of(context).closeDrawer();
            },
          ),
          CustomMenuItem(
            label: "Add temperature",
            isParent: false,
            onPress: () {

              NavService.tempurature_list_view();
              Scaffold.of(context).closeDrawer();
            },
          ),
          CustomMenuItem(
            label: "Store Incharge Approval",
            isParent: false,
            onPress: () {

              NavService.view_sheet();
              Scaffold.of(context).closeDrawer();
            },
          ),
          CustomMenuItem(
            label: "Pharmacist Approval",
            isParent: false,
            onPress: () {

              NavService.pharmacist_approval();
              Scaffold.of(context).closeDrawer();
            },
          ),


        ]
    ),
    CustomMenuItem(
        label: "Performance Section",
        isParent: true,
        onPress: () {
         if( authService.user?.is_qms == 1 ) {
           changeIndex(8);
         }
         else {
           changeIndex(7);
         }
        },
        children: [
          CustomMenuItem(
            label: "Add Smart Goals",
            isParent: false,
            onPress: () {

              NavService.editsmartgoal();
              Scaffold.of(context).closeDrawer();
            },
          ),
          CustomMenuItem(
            label: "My Smart Goals",
            isParent: false,
            onPress: () {

              NavService.smartgoal();
              Scaffold.of(context).closeDrawer();
            },
          ),
          CustomMenuItem(
            label: "My Training",
            isParent: false,
            onPress: () {

              NavService.training();
              Scaffold.of(context).closeDrawer();
            },
          ),



        ]
    ),
    CustomMenuItem(
        label: "Whistle Blowing",
        isParent: true,
        onPress: () {
  if( authService.user?.is_qms == 1 ) {
    changeIndex(9);
  }
  else {
    changeIndex(8);
  }
        },
        children: [
          CustomMenuItem(
            label: "Blow A Whistle",
            isParent: false,
            onPress: () {

              NavService.whistle();
              Scaffold.of(context).closeDrawer();
            },
          ),


        ]
    ),
    CustomMenuItem (
        label: "Resignation",
        isParent: true,
        onPress: () {
          if( authService.user?.is_qms == 1 ) {
            changeIndex(10);
          }
          else {
            changeIndex(9);
          }
        },
        children: [
          CustomMenuItem(
            label: "Resignation form",
            isParent: false,
            onPress: () {

              NavService.Resignation();
              Scaffold.of(context).closeDrawer();
            },
          ),
        ]
    ),
    if(authService.user?.memberAccess=='yes')
      CustomMenuItem(
          label: "Members",
          isParent: true,
          onPress: () {
            changeIndex(11);
          },
          children: [
            CustomMenuItem(
              label: "Member List",
              isParent: false,
              onPress: () {

                NavService.member();
                Scaffold.of(context).closeDrawer();
              },
            ),
          ]
      ),
    CustomMenuItem(
        label: "Profile",
        isParent: true,
        onPress: () {
          if(authService.user?.is_qms== 1)
            {
              changeIndex(13);
            }
          if(authService.user?.memberAccess=='yes' )
          {
            changeIndex(12);
          }
          else {
            changeIndex(11);
          }
        },
        children: [
          CustomMenuItem(
            label: "Change Password",
            isParent: false,
            onPress: () {

              NavService.profile();
              Scaffold.of(context).closeDrawer();
            },
          ),
          if(checktabledata == true)
          CustomMenuItem(
            label: "Reset Thumb Recognition",
            isParent: false,
            onPress: () {

              NavService.thumb_recognition();
              Scaffold.of(context).closeDrawer();
            },
          ),
        ]
    ),
    CustomMenuItem(
        label: "All Apps",
        isParent: true,
        onPress: () {
          if(authService.user?.is_qms==1 ) {
            changeIndex(14);
          }
          if(authService.user?.memberAccess=='yes' ) {
            changeIndex(13);
          }
          else {
            changeIndex(12);
          }
          Scaffold.of(context).closeDrawer();
          NavService.appmenu();
        },

    ),




  ];
}
