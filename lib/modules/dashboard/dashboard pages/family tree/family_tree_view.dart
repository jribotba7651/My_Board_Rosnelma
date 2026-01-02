// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:my_board/imports.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/family%20tree/family_tree_controller.dart';

// ignore: use_key_in_widget_constructors
class FamilyTreeView extends GetView<FamilyTreeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Members'),
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.10,
        color: Colors.white,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ElevatedButtonW(
              buttonText: "Add Family Member",
              onTap: () {
                Get.toNamed(Routes.addFamilyTree);
              }),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: GetBuilder<FamilyTreeController>(builder: (cont) {
            if (cont.dataLoading) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.only(top: Get.height * 0.4),
                child: CircularProgressIndicator(
                  color: AppColors.appColor,
                ),
              ));
            } else if (cont.familyTree == null) {
              return Center(child: Text('No Family Data Available'));
            } else {
              return Column(
                children: [
                  // Grandparents Row
                  _relationRow(
                      'Grandma',
                      cont.familyTree.grandMother?.firstName ?? 'Empty',
                      'Grandpa',
                      cont.familyTree.grandFather?.firstName ?? 'Empty',
                      Icons.person_outline),
                  SizedBox(height: 20),

                  // Parents Row
                  _relationRow(
                      'Mother',
                      cont.familyTree.mother?.firstName ?? 'Empty',
                      'Father',
                      cont.familyTree.father?.firstName ?? 'Empty',
                      Icons.person_outline),
                  SizedBox(height: 30),

                  // Family Owner and Spouse
                  _familyOwnerAndSpouse(cont.familyTree.ownerName ?? 'Owner',
                      cont.familyTree.wife?.firstName ?? 'Wife'),
                  SizedBox(height: 30),

                  // Sons List
                  _familyRelationsGrid(
                      'Sons',
                      cont.familyTree.sons
                              ?.map((son) => son.firstName ?? 'Unknown Son')
                              .toList() ??
                          [],
                      Colors.blueAccent),

                  SizedBox(height: 20),

                  // Daughters List
                  _familyRelationsGrid(
                      'Daughters',
                      cont.familyTree.daughters
                              ?.map((daughter) =>
                                  daughter.firstName ?? 'Unknown Daughter')
                              .toList() ??
                          [],
                      Colors.pinkAccent),

                  SizedBox(height: 20),

                  // Siblings List
                  _familyRelationsGrid(
                      'Siblings',
                      [
                        ...?cont.familyTree.brother?.map((brother) =>
                            brother.firstName ?? 'Unknown Brother'),
                        ...?cont.familyTree.sister?.map(
                            (sister) => sister.firstName ?? 'Unknown Sister')
                      ],
                      Colors.greenAccent),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  // Relation Row for Grandparents and Parents
  Widget _relationRow(String leftRelationTitle, String leftRelation,
      String rightRelationTitle, String rightRelation, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _relationCard(leftRelationTitle, leftRelation, icon),
        _relationCard(rightRelationTitle, rightRelation, icon),
      ],
    );
  }

  // Relation Card
  Widget _relationCard(String relationTitle, String relation, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.blueAccent),
              SizedBox(height: 10),
              Text(
                relationTitle,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                relation,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Family Owner and Spouse
  Widget _familyOwnerAndSpouse(String ownerName, String spouseName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _relationCardWithIcon(
            ownerName, Icons.account_circle, Colors.greenAccent),
        SizedBox(width: 20),
        _relationCardWithIcon(
            spouseName, Icons.account_circle_outlined, Colors.pinkAccent),
      ],
    );
  }

  // Relation Card with Custom Icon
  Widget _relationCardWithIcon(String relation, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 50, color: color),
              SizedBox(height: 10),
              Text(
                relation,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Family Relations Grid (for Sons, Daughters, Siblings)
  Widget _familyRelationsGrid(String title, List<String> members, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
          ),
          itemCount: members.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  members[index],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
